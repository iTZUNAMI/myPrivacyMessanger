//
//  NewMessageController.swift
//  pizzino
//
//  Created by PERSEO on 14/04/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//

import UIKit
import SystemConfiguration

import EasyTipView
import ENSwiftSideMenu
import SCLAlertView

class NewMessageController: UIViewController,UITextViewDelegate, ENSideMenuDelegate, OpzioniDelegate{



    //campo testo
    @IBOutlet var myText: UITextView!
    @IBOutlet var closeKeyboardButton: UIBarButtonItem!
    
    @IBOutlet var addTestoButton: UIButton!
    //creo oggetto MessaggioModel con valori di default
    @IBOutlet var immagineHome: UIImageView!
    
    
    var impostazioni = OpzioniModel()
    var setMessage = ""


    @IBAction func aggiungiTesto(sender: UIButton) {
        
        //nascondo immagine home
        immagineHome.hidden = true
        myText.becomeFirstResponder()
        myText.userInteractionEnabled = true
       
    }
    //pulsante sidebar in alto
    @IBAction func aprimenu(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    //pulsante Done chiude tastiera o anche con tap fuori
    @IBAction func closeKeyboard(sender: UIBarButtonItem) {
        dismissKeyboard()
    }

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        //impostazioni navbar
        navigationItem.title = "NEWMESSAGE".localized_con_commento("titolo princiaple")
        //top bar
        navigationController!.navigationBar.barStyle = UIBarStyle.BlackOpaque
        navigationController!.navigationBar.barTintColor = myColor_verde
        //colore font
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    
    
        // add notification observers
        // mi servono per controllare connessione anche da rientro multitasking
        // e per nascondere testo dallo snashot
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewMessageController.didBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewMessageController.willEnterForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)

        
        //collego sidebar
        self.sideMenuController()?.sideMenu?.delegate = self
        
        //myText impostazioni grafiche
        //spazi bianchi in alto rimossi
       // myText.text = "MYTEXT".localized_con_commento("testo campo iniziale")
        self.automaticallyAdjustsScrollViewInsets = false
        myText.delegate = self
        myText.userInteractionEnabled = false
    
        nascondiButton(closeKeyboardButton)

       // print (PostManager.sharedInstance.myResultJsonArray.count)

       
               
    }
    
    func aggiornaDati(){
    
        print ("aggiorno dati")
        if impostazioni.setClear == true{
            self.myText.text = ""
            self.setMessage = ""
            
        }
        setMessage = myText.text
        
        //nascondo graficamente il pulsante
        if self.setMessage.isEmpty{
            
            addTestoButton.hidden = false
            
        }
        else {
            addTestoButton.hidden = true
            
        }
    }
    
    func saveMessage(){
    
     //solo se ho premuto il pulsante crea mostro/eseguo qualcosa
        
        if impostazioni.setCreate == true {
        
        //gestione dei dati
        //qua ho setMessage e impostazioni corretti
        print ("--messaggio e impostazioni finali pulsante --")
        print (setMessage)
        print ("--")
        print (impostazioni.setHours)
        print ("--")
        print (impostazioni.setViews)
        print ("--")
        print (impostazioni.setPassword)
        print ("--")
        print (impostazioni.setRedirectUrl)
        print ("--")
        print (impostazioni.setShowDeleteMessage)
        print ("--")
        print (impostazioni.setShowDeleteMessage + " " + impostazioni.isSetMasking().url)
        print ("--")
        
        print ("--fine--")
            
         
        //utilizzo i dati e li passo in Json
            PostManager.sharedInstance.postForm(setMessage , impostazioni: impostazioni)
            
            
        }
    }
    
    
    //pulsante Done chiude tastiera , nascosto di default
    func nascondiButton (bottone: UIBarButtonItem){
        //se nascondo mostra altrimenti nascondi
        //si nasconde con il trick del colore quindi in realta ci sta
        //sarebbe da cambiare il title ma sono di sistema
            bottone.enabled = false
            bottone.tintColor = UIColor.clearColor()
    }
    
    //mostro Done quando apro tasiera
    func mostraButton (bottone: UIBarButtonItem){
        
            bottone.enabled = true
            bottone.tintColor = nil
        
    }

    //tap sul campo di testo
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.hideKeyboardWhenTappedAround()
        mostraButton(closeKeyboardButton)
        return true
    }
   
    //chiusura tastiera tramite pulsante Done o Tap
    func dismissKeyboard() {
        view.endEditing(true)
        nascondiButton(closeKeyboardButton)
        self.removetap()
        
        //qua mi salvo il messaggio e faccio controllo
        aggiornaDati()
        saveMessage()
        
    }
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewMessageController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //cancello ricerca tap quando chiudo keyboard
    func removetap(){
        for recognizer in self.view.gestureRecognizers! {
            self.view.removeGestureRecognizer(recognizer)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        //print("view will appear")
        
        //controllo connessione e imposto grafica
        //viene avviato la prima volta
        
    }
    
    override func viewDidAppear(animated: Bool) {
         // print("view did appear")
    }
    
    // MARK: - Notification oberserver methods
    
    func didBecomeActive() {
        print("did become active")
        
        //controllo connessione e imposto grafica
        //qua in caso di ritorno dal multitasking e quindi puo avere wifi 3g off
        
        let hasInternet = connectedToNetwork()
        print (hasInternet)
    }
    
    func willEnterForeground() {
        print("will enter foreground")
    }
    
    
    
  
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            
            return false
            
        }
        
        let isReachable = flags.contains(.Reachable)
        
        let needsConnection = flags.contains(.ConnectionRequired)
        
        return (isReachable && !needsConnection)
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
   
    
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
      //  print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
      //  print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
       // print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
       // print("sideMenuDidClose")
    }


 
    
    
    
    
    //funzione delegato
    
    func dataChanged(impo: OpzioniModel) {
     
        //faccio una copia (e sovrascrivo quello locale) delle impostazioni create e modificate su OpzioniController
        //qua ricevo i dati impo modificati su Opzioni controller
        self.impostazioni = impo
        aggiornaDati()
        saveMessage()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueId = segue.identifier else { return }
        
        switch segueId {
        case "myEmbeddedSegue":
            let destVC = segue.destinationViewController as! OpzioniController
            destVC.delegate = self
            
            let backItem = UIBarButtonItem()
            backItem.title = "BACKHOME".localized_con_commento("Back sul titolo")
            navigationItem.backBarButtonItem = backItem
            break
        default:
            break
        }
    }
    
 

}





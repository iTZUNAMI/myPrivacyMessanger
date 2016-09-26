//
//  OpzioniController.swift
//  pizzino
//
//  Created by PERSEO on 19/05/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//



import UIKit
import SCLAlertView

class OpzioniController: UITableViewController,SetPasswordDelegate,SetRedirectDelegate,SetShowMessageDelegate,SetMaskingDelegate {
    
    
    
    //delegato dalla table al newmessage
    var delegate: OpzioniDelegate?
    
    //modifiche delegato
    func whereTheChangesAreMade(data: OpzioniModel) {
        if let del = delegate {
            //richiamo la funzione del protocollo che viene letta
            del.dataChanged(data)
        }
    }
    
    
    //ritorno dei dati dei delegati
    func aggiornaSetPasswordDelegate(valore: String) {
        self.impostazioni.setPassword = valore
        //aggiorno globalmente al newmessagecontroller
        self.whereTheChangesAreMade(self.impostazioni)
        aggiornaValori()
    }
    
    
    func aggiornaSetRedirectDelegate(valore: String) {
        impostazioni.setRedirectUrl = valore
        self.whereTheChangesAreMade(self.impostazioni)
        aggiornaValori()
    }
    
    
    func aggiornaSetShowMessageDelegate(valore: String) {
        impostazioni.setShowDeleteMessage = valore
        self.whereTheChangesAreMade(self.impostazioni)
        aggiornaValori()
    }
    
    func aggiornaSetMaskingDelegate(valore: String) {
        impostazioni.setMaskingDomain = valore
        self.whereTheChangesAreMade(self.impostazioni)
        aggiornaValori()
    }
    
    //testi per localizzazione
    
    //sezioni
    @IBOutlet var testoPrimaSezione: UILabel!
    @IBOutlet var testoSecondaSezione: UILabel!
    
    //titoli sinistra
    @IBOutlet var testoTime: UILabel!
    @IBOutlet var testoView: UILabel!
    @IBOutlet var testoPassword: UILabel!
    @IBOutlet var testoRedirect: UILabel!
    @IBOutlet var testoDomainMasking: UILabel!
    @IBOutlet var testoShowDeleted: UILabel!
  
    //impostazioni destra
    @IBOutlet var testoTimeAttuale: UILabel!
    @IBOutlet var testoViewAttuale: UILabel!
    @IBOutlet var testoPasswordAttuale: UILabel!
    @IBOutlet var testoRedirectAttuale: UILabel!
    @IBOutlet var testoMaskingAttuale: UILabel!
    @IBOutlet var testoShowMessageAttuale: UILabel!
    
    //timer descrizione selezione action sheet
    var testoTitoloTimeSelezione : String!
    var testoTimeSelezione : String!
    
    //view descrizione selezione action sheet
    var testoTitoloViewSelezione : String!
    var testoViewSelezione : String!
    
   
    
    //valori impostazioni
    
    var impostazioni = OpzioniModel()
    
    
    //altert titolo e sub switch password
    
    var testoTitoloAlertSwitch : String!
    var testoSottotitoloAlertSwitch : String!
    var testoDoneAlertSwitch : String!
    
    //testo pulsanti action sheet
    var testoCancella : String!
    
    
    //i due pulsanti principali

    @IBOutlet var clearButton: UIButton!
  
    @IBOutlet var saveButton: UIButton!
    

    
    
    @IBAction func clearButtonFunc(sender: UIButton) {
        print ("clear button")
        print ("fin-clear button--")
        
        
        //resetto valori e refresh grafica
        
        //aggiornaValori()
        
        //dico al navcontroller di cancellare il testo
        impostazioni.setClear = true
        whereTheChangesAreMade(impostazioni)
        //reimposto
        impostazioni.setClear = false
        
    }
    
 
    @IBAction func saveButtonFunc(sender: UIButton) {
        
        impostazioni.setCreate = true
        whereTheChangesAreMade(impostazioni)
        impostazioni.setCreate = false
    }
    
    
    
    //aggiorno e setto i testi localizzati
    func aggiornaValori(){
    
    
        testoPrimaSezione.text = "DESTROYMSG".localized_con_commento("Text first section")
        testoSecondaSezione.text = "OPTIONALS".localized_con_commento("Optionals")
        
        
        //time
        testoTime.text = "TIME".localized_con_commento("Time expire message")
        testoTimeAttuale.text = impostazioni.setHours + " " +  "TIMESET".localized_con_commento("Time set")
        
        //view or views
        testoView.text = "TESTOVIEW".localized_con_commento("testo view")
        if impostazioni.setViews == "1"{
            testoViewAttuale.text = impostazioni.setViews + " " + "TESTOVIEWATTUALE".localized_con_commento("View set")
            }
            else{
            testoViewAttuale.text = impostazioni.setViews + " " + "TESTOVIEWATTUALE_MORE".localized_con_commento("views plurale")
            }
        
        //password
        testoPassword.text = "TESTOPASSWORD".localized_con_commento("password")
        //on off se impostata
        if impostazioni.isSetPassword() {
            testoPasswordAttuale.text = "TESTOPASSWORDATTUALE_ON".localized_con_commento("On")
            testoPasswordAttuale.textColor = myColor_verde
        }
        else{
            testoPasswordAttuale.text = "TESTOPASSWORDATTUALE_OFF".localized_con_commento("Off")
            testoPasswordAttuale.textColor = myColor_grigio3
        }
        
        //redirect
        testoRedirect.text = "TESTOREDIRECT".localized_con_commento("Redirect WWW")
        //on off se impostata
        if impostazioni.isSetRedirect() {
            testoRedirectAttuale.text = "TESTOREDIRECTATTUALE_ON".localized_con_commento("On")
            testoRedirectAttuale.textColor = myColor_verde
        }
        else{
            testoRedirectAttuale.text = "TESTOREDIRECTATTUALE_OFF".localized_con_commento("Off")
            testoRedirectAttuale.textColor = myColor_grigio3
        }
        
        //domain sempre on cambia solo dominio default : T
        testoMaskingAttuale.text = impostazioni.isSetMasking().iniziale.uppercaseString
        testoMaskingAttuale.textColor = myColor_verde
        
        //show deleted
        testoShowDeleted.text = "TESTOSHOWDELETED".localized_con_commento("Show deleted Message")
        if impostazioni.isSetShowMessage() {
            testoShowMessageAttuale.text = "TEXTSHOWDELETEATTUALE_ON".localized_con_commento("on")
            testoShowMessageAttuale.textColor = myColor_verde
        }
        else{
            testoShowMessageAttuale.text = "TEXTSHOWDELETEATTUALE_OFF".localized_con_commento("off")
            testoShowMessageAttuale.textColor = myColor_grigio3
        }
        
        
   
        
        
    }
    
    
    func aggiornaTemplate(){
        
        
        let attributedTitle = NSAttributedString(string: "CRYPT".localized_con_commento("CREATE").uppercaseString, attributes: [NSKernAttributeName: 1.5])
        saveButton.setAttributedTitle(attributedTitle, forState: .Normal)
        saveButton.tintColor = myColor_bianco
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = myColor_verde.CGColor
        saveButton.layer.backgroundColor = myColor_verde.CGColor
        
        
        let attributedTitle2 = NSAttributedString(string: "CLEAR".localized_con_commento("CLEAR").uppercaseString, attributes: [NSKernAttributeName: 1.5])
        clearButton.setAttributedTitle(attributedTitle2, forState: .Normal)
        clearButton.tintColor = myColor_grigio3
        clearButton.layer.cornerRadius = 15
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = myColor_grigio2.CGColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        aggiornaTemplate()
        aggiornaValori()
        
       
       
    }

    
    //funzioni click sulle celle statiche (con sezioni)
    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        //print(indexPath.section)
        //print(indexPath.row)
        
        //prima cella
        if indexPath.section == 0 && indexPath.row == 0 {
            //selezione timer
            selezioneTimer()
        }
        
        //seconda cella
        if indexPath.section == 0 && indexPath.row == 1 {
            //selezione view
            selezioneView()
        }
        //terza cella
        if indexPath.section == 1 && indexPath.row == 0 {
            
        }
        //quarta cella
        if indexPath.section == 1 && indexPath.row == 1 {
            
        }
        

        
    }
  

    
    func selezioneTimer() {
        
        testoTitoloTimeSelezione = "TESTOTITOLOSELEZIONETIME".localized_con_commento("titolo action sheet selezione tempo")
        testoTimeSelezione = "TESTOTIMESELEZIONE".localized_con_commento("testo della scelta tempo")
        testoCancella = "TESTOCANCELLA".localized_con_commento("pulsante cancella")
        
        
        let alertController = UIAlertController(title: testoTitoloTimeSelezione, message: testoTimeSelezione, preferredStyle: .ActionSheet)
        
        // 23 48 72  120 240
        let sel1 = UIAlertAction(title: "24", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setHours = "24"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato 
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel2 = UIAlertAction(title: "48", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setHours = "48"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel3 = UIAlertAction(title: "72", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setHours = "72"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
            
        })
        
        let sel4 = UIAlertAction(title: "120", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setHours = "120"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel5 = UIAlertAction(title: "240", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setHours = "240"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        

        let cancel = UIAlertAction(title: testoCancella, style: .Cancel, handler: { (action) -> Void in
            //non fa nulla
        })

        
        alertController.addAction(sel1)
        alertController.addAction(sel2)
        alertController.addAction(sel3)
        alertController.addAction(sel4)
        alertController.addAction(sel5)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func selezioneView() {
        
        testoTitoloViewSelezione = "TESTOTITOLOSELEZIONEVIEW".localized_con_commento("titolo action sheet selezione view")
        testoViewSelezione = "TESTOVIEWSELEZIONE".localized_con_commento("testo della scelta tempo")
        testoCancella = "TESTOCANCELLA".localized_con_commento("pulsante cancella")
        
        
        let alertController = UIAlertController(title: testoTitoloViewSelezione, message: testoViewSelezione, preferredStyle: .ActionSheet)
        
        // 1 2 3 4 5 10
        let sel1 = UIAlertAction(title: "1", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setViews = "1"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel2 = UIAlertAction(title: "2", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setViews = "2"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel3 = UIAlertAction(title: "3", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setViews = "3"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
            
        })
        
        let sel4 = UIAlertAction(title: "4", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setViews = "4"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel5 = UIAlertAction(title: "5", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setViews = "5"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        let sel6 = UIAlertAction(title: "10", style: .Default, handler: { (action) -> Void in
            //azioni
            self.impostazioni.setViews = "10"
            //aggiorno testo
            self.aggiornaValori()
            //passo oggetto come delegato
            self.whereTheChangesAreMade(self.impostazioni)
        })
        
        
        let cancel = UIAlertAction(title: testoCancella, style: .Cancel, handler: { (action) -> Void in
            //non fa nulla
        })
        
        
        alertController.addAction(sel1)
        alertController.addAction(sel2)
        alertController.addAction(sel3)
        alertController.addAction(sel4)
        alertController.addAction(sel5)
        alertController.addAction(sel6)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
    }


    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SetPasswordSegue" {
            let dueViewController = segue.destinationViewController as! SetPasswordController
            dueViewController.delegate = self
            dueViewController.statoAttuale = impostazioni.setPassword
            
            
        }
        if segue.identifier == "SetRedirectSegue" {
            let treViewController = segue.destinationViewController as! SetRedirectController
            treViewController.delegate = self
            treViewController.statoAttuale = impostazioni.setRedirectUrl
            
        }
        
        if segue.identifier == "SetShowMessageSegue" {
            let quattroViewController = segue.destinationViewController as! SetShowMessageController
            quattroViewController.delegate = self
            quattroViewController.statoAttuale = impostazioni.setShowDeleteMessage
            
        }
        
        if segue.identifier == "SetMaskingSegue" {
            let cinqueViewController = segue.destinationViewController as! SetMaskingController
            cinqueViewController.delegate = self
            cinqueViewController.OggettoTemp = impostazioni
        }
    }
    
}

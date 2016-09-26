//
//  SetPasswordController.swift
//  pizzino
//
//  Created by PERSEO on 09/06/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//

import UIKit
import SCLAlertView

class SetRedirectController: UITableViewController,SetRedirectWebViewDelegate {
    
    //delegato dalla table al newmessage
    var delegate: SetRedirectDelegate?
    
    //modifiche delegato
    func whereTheChangesAreMade(data: String!) {
        
        if let del = delegate {
            //richiamo la funzione del protocollo che viene letta
            del.aggiornaSetRedirectDelegate(data)
            
        }
    }
    
    var statoAttuale : String!
    //lettura impostazione corrente
    //al primo avvio letto dal proprieta segue
    
    @IBOutlet var testoRedirect: UILabel!
    @IBOutlet var testoDescRedirect: UITextView!
    @IBOutlet var switchRedirect: UISwitch!
    
    @IBOutlet var testoRedirectAttuale: UILabel!
    @IBOutlet var testoDescRedirectAttuale: UITextView!
    
    @IBOutlet var testoDefaultRedirect: UILabel!
    @IBOutlet var testoDescDefaultRedirect: UITextView!
    @IBOutlet var switchDefaultRedirect: UISwitch!
    
    
    @IBOutlet var cellaRedirect: UIView!
    
    @IBOutlet var cellaDefault: UIView!

    @IBOutlet var previewButton: UIButton!
    @IBOutlet var previewButtonFunc: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //impostazioni navbar
        navigationItem.title = "SETREDIRECT".localized_con_commento("titolo princiaple")
        //top bar
        navigationController!.navigationBar.barStyle = UIBarStyle.BlackOpaque
        navigationController!.navigationBar.barTintColor = myColor_verde
        //colore font
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        testoRedirect.text = "SETREDIRECTCELLA".localized_con_commento("Set Redirect")
        testoDescRedirect.text = "DESCSETREDIRECT".localized_con_commento("descrizione").uppercaseString
        testoDescRedirect.textColor = myColor_grigio3
        testoDescRedirect.font = .systemFontOfSize(12)
        
        testoRedirectAttuale.textColor = myColor_bianco
        testoRedirectAttuale.font = .systemFontOfSize(12)
        
        testoDescRedirectAttuale.text = "TESTODESCREDIRECTATTUALE".localized_con_commento("Current url").uppercaseString
        testoDescRedirectAttuale.textColor = myColor_grigio3
        testoDescRedirectAttuale.font = .systemFontOfSize(12)
        
        testoDefaultRedirect.text = "TESTOIMPOSTADEFAULTREDIRECT".localized_con_commento("Set as default redirect")
        testoDescDefaultRedirect.text = "TESTODESCIMPOSTADEFAULTREDIRECT".localized_con_commento("desc default redirect").uppercaseString
        testoDescDefaultRedirect.textColor = myColor_grigio3
        testoDescDefaultRedirect.font = .systemFontOfSize(12)
        
       
        
        
        
        previewButton.layer.cornerRadius = 15
        previewButton.layer.borderWidth = 1
        previewButton.layer.borderColor = myColor_verde.CGColor
        previewButton.setTitle("OPENWWW".localized_con_commento("Open"), forState: .Normal)
        
        
        switchRedirect.addTarget(self, action: #selector(SetRedirectController.selezioneRedirect(_:)), forControlEvents: UIControlEvents.ValueChanged)
        switchDefaultRedirect.addTarget(self, action: #selector(SetRedirectController.defaultRedirect(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        aggiornaImpostazioni()
        
        

    }
    
    func aggiornaImpostazioni(){
        
        if statoAttuale.isEmpty {
            self.switchRedirect.setOn(false, animated: true)
            //nascondo anche configurazioni in basso
            testoRedirectAttuale.hidden = true
            testoDescRedirectAttuale.hidden = true
            cellaRedirect.hidden = true
            testoDefaultRedirect.hidden = true
            testoDescDefaultRedirect.hidden = true
            cellaDefault.hidden = true
            switchDefaultRedirect.hidden = true
            previewButton.hidden = true
        }
        else{
            self.switchRedirect.setOn(true, animated: true)
            //mostro tutto
            testoRedirectAttuale.text = self.statoAttuale
            
            testoRedirectAttuale.hidden = false
            testoDescRedirectAttuale.hidden = false
            cellaRedirect.hidden = false
            testoDefaultRedirect.hidden = false
            testoDescDefaultRedirect.hidden = false
            cellaDefault.hidden = false
            switchDefaultRedirect.hidden = false
            previewButton.hidden = false
            
            //se gia impostata default metto on swith
            if !SettingsManager.sharedInstance.mySettings.setRedirectUrl.isEmpty {
                self.switchDefaultRedirect.setOn(true, animated: false)
            }
            
            
        }
        
    }
    
    func defaultRedirect(switchState: UISwitch) {
        //se metto on salvo password corrente come default
        if switchDefaultRedirect.on {
            SettingsManager.sharedInstance.mySettings.setRedirectUrl = self.statoAttuale
            SettingsManager.sharedInstance.salva()
            
        }
        else{
            //altrimenti se metto off la resetto
            SettingsManager.sharedInstance.mySettings.resetRedirectUrl()
            SettingsManager.sharedInstance.salva()
        }
    }
    
    
    
    func selezioneRedirect(switchState: UISwitch) {
        if switchRedirect.on {
            //selezinato on
            
            //controllo se ho gia salvato quella di default. Se si la carico senza mostrare nulla
            if SettingsManager.sharedInstance.mySettings.setRedirectUrl.isEmpty {
                alertRedirect()
            }
            else {
                //altrimenti carico
                self.statoAttuale = SettingsManager.sharedInstance.mySettings.setRedirectUrl
                self.whereTheChangesAreMade(self.statoAttuale)
                self.switchDefaultRedirect.setOn(true, animated: true)
                self.aggiornaImpostazioni()
            }
        }
            //se swith off
        else {
            //clear
            self.statoAttuale = ""
            self.whereTheChangesAreMade("")
            self.aggiornaImpostazioni()
        }
    }
    
    
    //funzione che mostra alert e imposta
    func alertRedirect(){
        
        //impostazioni alert
        //disabilito il default Done button per localizzare uno nuovo...
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        

        
        let alertView = SCLAlertView(appearance: appearance)
        
        let txt = alertView.addTextField("TESTOFIELDALERTSWITCHREDIRECT".localized_con_commento("enter text here"))
        txt.autocapitalizationType = .None
        let prehttp = "http://"
        txt.text = prehttp
        alertView.addButton("TESTODONEALERTSWITCHREDIRECT".localized_con_commento("done")) {
            //azione pulsante done nel txt ho il testo
            if !txt.text!.isEmpty && txt != prehttp {
                self.statoAttuale = txt.text
                self.whereTheChangesAreMade(txt.text)
                self.aggiornaImpostazioni()
            }
            else {
                //se lascia vuoto ripristino switch su off visto che non fa nulla
                //cosi non metto pulsante cancella
                self.switchRedirect.setOn(false, animated: true)
            }
            
        }
        
        alertView.showEdit(
            "TESTOTITOLOALERTSWITCHREDIRECT".localized_con_commento("titolo"),
            subTitle: "TESTOSOTTOTITOLOALERTSWITCHREDIRECT".localized_con_commento("sottotitolo"),
            colorStyle: myColor_verde_hex
        )
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SetRedirectWebView" {
            let WebViewController = segue.destinationViewController as! SetRedirectWebViewController
             WebViewController.delegate = self
             WebViewController.SetIndirizzoWeb = self.statoAttuale
            
        }
    }
    
}

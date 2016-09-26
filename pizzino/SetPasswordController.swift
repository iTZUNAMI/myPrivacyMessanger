//
//  SetPasswordController.swift
//  pizzino
//
//  Created by PERSEO on 09/06/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//

import UIKit
import SCLAlertView

class SetPasswordController: UITableViewController {

    //delegato dalla table al newmessage
    var delegate: SetPasswordDelegate?
    
    //modifiche delegato
    func whereTheChangesAreMade(data: String!) {
      
        if let del = delegate {
            //richiamo la funzione del protocollo che viene letta
            del.aggiornaSetPasswordDelegate(data)
           
        }
    }
    
    var statoAttuale : String! //lettura impostazione corrente

    @IBOutlet var testoSetPassword: UILabel!
    @IBOutlet var testoDescrizioneSetPassword: UITextView!
    @IBOutlet var switchSetPassword: UISwitch!
  
    
    @IBOutlet var testoPasswordCorrente: UILabel!
    @IBOutlet var testoDescPasswordCorrente: UITextView!
    
    @IBOutlet var testoImpostaDefaultPassword: UILabel!
    @IBOutlet var testoDescImpostaDefaultPassword: UITextView!
    
    @IBOutlet var switchSetDefaultPassword: UISwitch!
    
    
    @IBOutlet var cellaPassword: UIView!
    @IBOutlet var cellaDefaultPassword: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //impostazioni navbar
        navigationItem.title = "SETPASSWORD".localized_con_commento("titolo princiaple")
        //top bar
        navigationController!.navigationBar.barStyle = UIBarStyle.BlackOpaque
        navigationController!.navigationBar.barTintColor = myColor_verde
        //colore font
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        testoSetPassword.text = "SETPASSWORDCELLA".localized_con_commento("Set Password")
        testoDescrizioneSetPassword.text = "DESCSETPASSWORD".localized_con_commento("descrizione").uppercaseString
        testoDescrizioneSetPassword.textColor = myColor_grigio3
        testoDescrizioneSetPassword.font = .systemFontOfSize(12)
        
        testoPasswordCorrente.textColor = myColor_bianco
        
        testoDescPasswordCorrente.text = "TESTODESCPASSWORDCORRENTE".localized_con_commento("Current password").uppercaseString
        testoDescPasswordCorrente.textColor = myColor_grigio3
        testoDescPasswordCorrente.font = .systemFontOfSize(12)
        
        testoImpostaDefaultPassword.text = "TESTOIMPOSTADEFAULTPASSWORD".localized_con_commento("Set as default password")
        testoDescImpostaDefaultPassword.text = "TESTODESCIMPOSTADEFAULTPASSWORD".localized_con_commento("desc default password").uppercaseString
        testoDescImpostaDefaultPassword.textColor = myColor_grigio3
        testoDescImpostaDefaultPassword.font = .systemFontOfSize(12)
        
        switchSetPassword.addTarget(self, action: #selector(SetPasswordController.selezionePassword(_:)), forControlEvents: UIControlEvents.ValueChanged)
        switchSetDefaultPassword.addTarget(self, action: #selector(SetPasswordController.defaultPassword(_:)), forControlEvents: UIControlEvents.ValueChanged)
      
        aggiornaImpostazioni()
        
    }

    func aggiornaImpostazioni(){
        
        if statoAttuale.isEmpty {
            self.switchSetPassword.setOn(false, animated: true)
            //nascondo anche configurazioni in basso
            testoPasswordCorrente.hidden = true
            testoDescPasswordCorrente.hidden = true
            cellaPassword.hidden = true
            testoImpostaDefaultPassword.hidden = true
            testoDescImpostaDefaultPassword.hidden = true
            cellaDefaultPassword.hidden = true
            switchSetDefaultPassword.hidden = true
        }
        else{
            self.switchSetPassword.setOn(true, animated: true)
            //mostro tutto
            testoPasswordCorrente.text = self.statoAttuale
            
            testoPasswordCorrente.hidden = false
            testoDescPasswordCorrente.hidden = false
            cellaPassword.hidden = false
            testoImpostaDefaultPassword.hidden = false
            testoDescImpostaDefaultPassword.hidden = false
            cellaDefaultPassword.hidden = false
            switchSetDefaultPassword.hidden = false
            //se gia impostata default metto on swith
            if !SettingsManager.sharedInstance.mySettings.setPassword.isEmpty {
                self.switchSetDefaultPassword.setOn(true, animated: false)
            }
            
            
        }
        
    }
    
    func defaultPassword(switchState: UISwitch) {
        //se metto on salvo password corrente come default
        if switchSetDefaultPassword.on {
        SettingsManager.sharedInstance.mySettings.setPassword = self.statoAttuale
        SettingsManager.sharedInstance.salva()

        }
        else{
        //altrimenti se metto off la resetto
        SettingsManager.sharedInstance.mySettings.resetPassword()
        SettingsManager.sharedInstance.salva()
        }
    }
    
    
    
    func selezionePassword(switchState: UISwitch) {
     if switchSetPassword.on {
     //selezinato on
     
     //controllo se ho gia salvato quella di default. Se si la carico senza mostrare nulla
        if SettingsManager.sharedInstance.mySettings.setPassword.isEmpty {
            alertPassword()
        }
        else {
         //altrimenti carico
            self.statoAttuale = SettingsManager.sharedInstance.mySettings.setPassword
            self.whereTheChangesAreMade(self.statoAttuale)
            self.switchSetDefaultPassword.setOn(true, animated: true)
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
    func alertPassword(){
        
        //impostazioni alert
        //disabilito il default Done button per localizzare uno nuovo...
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        let txt = alertView.addTextField("TESTOFIELDALERTSWITCHPASSWORD".localized_con_commento("enter text here"))
        txt.autocapitalizationType = .None
        alertView.addButton("TESTODONEALERTSWITCHPASSWORD".localized_con_commento("done")) {
            //azione pulsante done nel txt ho il testo
            if !txt.text!.isEmpty {
                self.statoAttuale = txt.text
                self.whereTheChangesAreMade(txt.text)
                self.aggiornaImpostazioni()
            }
            else {
                //se lascia vuoto ripristino switch su off visto che non fa nulla
                //cosi non metto pulsante cancella
                self.switchSetPassword.setOn(false, animated: true)
            }
            
        }
        
        alertView.showEdit(
            "TESTOTITOLOALERTSWITCHPASSWORD".localized_con_commento("titolo"),
            subTitle: "TESTOSOTTOTITOLOALERTSWITCHPASSWORD".localized_con_commento("sottotitolo"),
            colorStyle: myColor_verde_hex
        )
    }
    
    
}

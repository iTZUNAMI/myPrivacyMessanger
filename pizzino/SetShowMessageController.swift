//
//  SetShowMessage.swift
//  pizzino
//
//  Created by PERSEO on 25/06/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//


import UIKit
import SCLAlertView

class SetShowMessageController: UITableViewController {
    
    //delegato dalla table al newmessage
    var delegate: SetShowMessageDelegate?
    
    //modifiche delegato
    func whereTheChangesAreMade(data: String!) {
        
        if let del = delegate {
            //richiamo la funzione del protocollo che viene letta
            del.aggiornaSetShowMessageDelegate(data)
            
        }
    }
    
    var statoAttuale : String!
    //lettura impostazione corrente
    //al primo avvio letto dal proprieta segue
    
    
    @IBOutlet var testoShowMessage: UILabel!
    @IBOutlet var testoDescShowMessage: UITextView!
    @IBOutlet var switchShowMessage: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //impostazioni navbar
        navigationItem.title = "SETSHOWDELETE".localized_con_commento("titolo princiaple")
        //top bar
        navigationController!.navigationBar.barStyle = UIBarStyle.BlackOpaque
        navigationController!.navigationBar.barTintColor = myColor_verde
        //colore font
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        testoShowMessage.text = "SETSHOWMESSAGECELLA".localized_con_commento("Show deleted message")
        testoDescShowMessage.text = "DESCSHOWMESSAGE".localized_con_commento("descrizione").uppercaseString
        testoDescShowMessage.textColor = myColor_grigio3
        testoDescShowMessage.font = .systemFontOfSize(12)
        
        switchShowMessage.addTarget(self, action: #selector(SetShowMessageController.selezioneShowMessage(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        aggiornaImpostazioni()
        
    }
    
    
    func aggiornaImpostazioni(){
        
        if statoAttuale == "0" {
            self.switchShowMessage.setOn(false, animated: true)
             }
        else{
            self.switchShowMessage.setOn(true, animated: true)
        }
        
    }
    
    
    func selezioneShowMessage(switchState: UISwitch) {
        if switchShowMessage.on {
            //selezinato on
            
                self.statoAttuale = "1"
                self.whereTheChangesAreMade(self.statoAttuale)
                self.switchShowMessage.setOn(true, animated: true)
                self.aggiornaImpostazioni()
            
        }
            //se swith off
        else {
            //clear
            self.statoAttuale = "0"
            self.whereTheChangesAreMade(self.statoAttuale)
            self.aggiornaImpostazioni()
            
        }
    }
    

}
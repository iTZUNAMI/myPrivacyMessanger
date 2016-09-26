//
//  SetShowMessage.swift
//  pizzino
//
//  Created by PERSEO on 25/06/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//


import UIKit
import SCLAlertView

class SetMaskingController: UITableViewController {
    
    //delegato dalla table al newmessage
    var delegate: SetMaskingDelegate?
    
    //modifiche delegato
    func whereTheChangesAreMade(data: String!) {
        
        if let del = delegate {
            //richiamo la funzione del protocollo che viene letta
            del.aggiornaSetMaskingDelegate(data)
            
        }
    }
    
    var OggettoTemp : OpzioniModel! //mi serve per la funzione valore dominio
    //lettura impostazione corrente
    //al primo avvio letto dal proprieta segue
    @IBOutlet var testoMasking: UILabel!
    @IBOutlet var testoDescMasking: UITextView!
    
    @IBOutlet var testoCurrentMasking: UILabel!
    @IBOutlet var testoDescCurrentMasking: UITextView!
    @IBOutlet var changeButton: UIButton!
    
    
    @IBAction func changeButtonFunc(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //impostazioni navbar
        navigationItem.title = "SETMASKINGDOMAIN".localized_con_commento("titolo princiaple")
        //top bar
        navigationController!.navigationBar.barStyle = UIBarStyle.BlackOpaque
        navigationController!.navigationBar.barTintColor = myColor_verde
        //colore font
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        testoMasking.text = "SETMASKINGCELLA".localized_con_commento("URL Masking")
        testoDescMasking.text = "DESCSETMASKING".localized_con_commento("descrizione").uppercaseString
        testoDescMasking.textColor = myColor_grigio3
        testoDescMasking.font = .systemFontOfSize(12)
        
        testoCurrentMasking.textColor = myColor_bianco
        testoCurrentMasking.font = .systemFontOfSize(12)
        testoCurrentMasking.text = OggettoTemp.isSetMasking().iniziale.uppercaseString + " : " + OggettoTemp.isSetMasking().url
        
        testoDescCurrentMasking.text = "DESCSETMASKINGCURRENT".localized_con_commento("descrizione").uppercaseString
        testoDescCurrentMasking.textColor = myColor_grigio3
        testoDescCurrentMasking.font = .systemFontOfSize(12)
        
        
        changeButton.layer.cornerRadius = 15
        changeButton.layer.borderWidth = 1
        changeButton.layer.borderColor = myColor_verde.CGColor
        changeButton.setTitle("CHANGEMASKING".localized_con_commento("Change"), forState: .Normal)
    }
    
}
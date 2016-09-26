//
//  StringExtension.swift
//  pizzino
//
//  Created by PERSEO on 18/04/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//


// Uso per localization facile e veloce

import Foundation



//versione con linuga forzata
extension String {
    
    func localized_forzato_con_lingua(lang:String) -> String {
        
        
        
        let path = NSBundle.mainBundle().pathForResource(lang, ofType: "lproj")
        
        let bundle = NSBundle(path: path!)
        
        
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }
    
}


//versione standard con commento, lingua impostata dal sistema in automatico
extension String {
    
    func localized_con_commento(comment:String) -> String {
        
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: comment)
    }
}


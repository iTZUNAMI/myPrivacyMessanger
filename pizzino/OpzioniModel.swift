//
//  MessaggioModel.swift
//  pizzino
//
//  Created by PERSEO on 27/05/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//

import UIKit

class OpzioniModel: NSObject {
    
    //valordi di default
    
    var defSetHours = "24"
    var defSetViews = "1"
    var defSetPassowrd = "" //no
    var defSetRedirectUrl = "" //no
    var defMaskingDomain = "0"  //tinuyrl
    var defShowDeleteMessage = "0" //no
    
    // variabili impostazioni 
    
    var setHours : String!
    var setViews : String!
    var setPassword : String!
    var setRedirectUrl : String!
    var setMaskingDomain : String!
    var setShowDeleteMessage : String!
    
    var setClear = false //0 no 1 si per reset grafico
    var setCreate = false
    override init (){
        
        self.setHours = defSetHours
        self.setViews = defSetViews
        self.setPassword = defSetPassowrd
        self.setRedirectUrl = defSetRedirectUrl
        self.setMaskingDomain = defMaskingDomain
        self.setShowDeleteMessage = defShowDeleteMessage
    }
    
    
    internal required init(coder aDecoder: NSCoder) {
        self.setPassword = aDecoder.decodeObjectForKey("SetPassword") as! String
        self.setRedirectUrl = aDecoder.decodeObjectForKey("SetRedirect") as! String
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.setPassword, forKey: "SetPassword")
        encoder.encodeObject(self.setRedirectUrl, forKey: "SetRedirect")
    }
    
    
    func isSetPassword() ->Bool {
        if setPassword.isEmpty {
        return false
        }
        
        return true
    }
    
    func isSetRedirect() ->Bool {
        if setRedirectUrl.isEmpty {
            return false
        }
        
        return true
    }
    
    func isSetShowMessage() ->Bool {
        if setShowDeleteMessage == "0" {
            return false
        }
        
        return true
    }
    
    func isSetMasking() -> (iniziale : String ,url : String) {
        //tinyurl.me
        var iniziale : String!
        var url : String!
        
        switch setMaskingDomain {
        case "0":
            iniziale = "T"
            url = "http://tinyurl.me"
        default:
            iniziale = "T"
            url = ""
        }
        return (iniziale, url)
    }
    
    func resetHours(){
        self.setHours = defSetHours
    }
    func resetViews(){
        self.setViews = defSetViews
    }
    func resetPassword(){
        self.setPassword = defSetPassowrd
    }
    func resetRedirectUrl(){
        self.setRedirectUrl = defSetRedirectUrl
    }
    
    
    func resetClearAll(){
        
        resetHours()
        resetViews()
        resetPassword()
        resetRedirectUrl()
        
    }
    
    
}



import UIKit
import Alamofire
import SwiftyJSON

class SettingsManager: NSObject {
    
    
    //indirizzo file locale
    private var filePath : String!
    //oggetto di tipo SettingsModel per il salvataggio locale delle impostazioni dell'app
    //riutilizzo quella classe per far prima e uso setPassword ecc come salvataggi non defSet..
    var mySettings = OpzioniModel()

    // questo è il codice speciale che lo rende un singleton
    
    class var sharedInstance : SettingsManager {
        get {
            struct Static {
                static var instance : SettingsManager? = nil
                static var token : dispatch_once_t = 0
            }
            
            dispatch_once(&Static.token) { Static.instance = SettingsManager() }
            
            return Static.instance!
        }
    }
    
    
    
    //avvio iniziale e caricamento impostazioni salvate
    func startDataManager(){
        
        filePath = cartellaDocuments() + "/mySettings_.plist"
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath) == true {
            mySettings = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! OpzioniModel
        } else {
            //altrimenti al primo avvio ne creo uno di default vuoto
            mySettings = OpzioniModel()
            salva()
            
        }
        
    }

    func salva(){
        NSKeyedArchiver.archiveRootObject(mySettings, toFile: filePath)
    }
    
    func cartellaDocuments() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0] as String
    }
    
}
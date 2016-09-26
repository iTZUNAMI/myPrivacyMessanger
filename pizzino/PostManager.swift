

import UIKit
import Alamofire
import SwiftyJSON

class PostManager: NSObject {
    
    
    // impostazioni globali
    
    let myPizzinoURL = "https://pizzino.pw/app/test.php"
    
    
    // Salvataggio dati Json di ritorno
    //inizialzzo vuoto
    var myResultJsonArray : [ResultModel] = []
    
    var uc : RecentiController!
    
    //indirizzo file locale
    private var filePath : String!
    
    // questo è il codice speciale che lo rende un singleton
    
    class var sharedInstance : PostManager {
        get {
            struct Static {
                static var instance : PostManager? = nil
                static var token : dispatch_once_t = 0
            }
            
            dispatch_once(&Static.token) { Static.instance = PostManager() }
            
            return Static.instance!
        }
    }
    

    
    //init dblocale se presente carica altrimenti nulla o inizializza
    func startDataManager(){
        
        filePath = cartellaDocuments() + "/myUrl.plist"
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath) == true {
            myResultJsonArray = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! [ResultModel]
        } else {
        
            let esempio = ResultModel(urlfinale: "ciao", urlcheck: "culo")
            let esempio2 = ResultModel(urlfinale: "ciao2", urlcheck: "culo2")
            myResultJsonArray = [esempio,esempio2]
            salva()
            
        }
        
    }
    
    
    //metodo passaggio dei dati e salvataggio response in Json con Alamo
    
    func postForm (messaggio : String, impostazioni : OpzioniModel) {
        
        
        
        //testo e parametri
        
        let parameters = [
            "testo": messaggio
        ]
        
        Alamofire.request(.POST, myPizzinoURL, parameters: parameters)
            .responseJSON { response in
                //  print(response.request)  // original URL request
                //  print(response.response) // URL response
                //  print(response.data)     // server data
                //  print(response.result)   // result of response serialization
                
                // controlliamo se c'è un errore e nel caso lo stampiamo in console
                if let er = response.result.error {
                    print(er.localizedDescription)
                }
                
                
                // controlliamo che il JSON sia correttamente arrivato, in caso contrario fermiamo il caricamento (se no va in crash)
                // l'_ è un trucco per evitare di fare una var a "ufo" che non verrà mai usata
                if let _ = response.result.value {
                    print("JSON OK")
                } else {
                    print("JSON Nil")
                    return
                }
                
                // JSON() - in verde - è uno struct presente nella libreria SwiftyJSON.swift
                // gli viene passato JSONn che è la var di risposta di Alamofire che contiene il JSON scaricato
                // analizzando il JSON dell'App Store ho trovato una chiave principale feed ed una sottochave entry che contiene tutte le App
                // la sintassi di SwiftyJSON per passare da una chiave all'altra sembra di fare un array con una stringa! Non confonderti!
                // dentro alla chiave entry c'è l'array delle App, quindi la let json diventa un array
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON) ---fine stampa raw dati---")
                }
                
                
                // tutto il json
                let rispostaJSON = JSON(response.result.value!)
                
                //salvo su oggetto di tipo
                let urlTinyUrl = rispostaJSON["urlTinyUrl"].string!
                
                let salvaDati = ResultModel(urlfinale: urlTinyUrl, urlcheck: "ccc")
                //salvaDati.urlTinyUrl = rispostaJSON["urlTinyUrl"].string!
                //salvaDati.urlPizzinoCheck = "da leggere"
                
                self.myResultJsonArray.append(salvaDati)
                self.salva()
                
                
        }
        
        
    }
    
    
    func salva(){
        
        NSKeyedArchiver.archiveRootObject(myResultJsonArray, toFile: filePath)
        
    }
    
    func cartellaDocuments() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        //print(paths[0] as String)
        return paths[0] as String
    }
    
}
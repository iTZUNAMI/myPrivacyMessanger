


import UIKit

//classe che salva in locale i risultati del json
class ResultModel: NSObject {
    
    
    //url finale
    var urlTinyUrl : String!
    
    //url check stato lettura da fare
    var urlPizzinoCheck : String!

    
    
    init(urlfinale: String, urlcheck: String){
        
        self.urlTinyUrl = urlfinale
        self.urlPizzinoCheck = urlcheck
        
    }
    
    internal required init(coder aDecoder: NSCoder) {
        self.urlTinyUrl = aDecoder.decodeObjectForKey("urlfinale") as! String
        self.urlPizzinoCheck = aDecoder.decodeObjectForKey("urlcheck") as! String
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.urlTinyUrl, forKey: "urlfinale")
        encoder.encodeObject(self.urlPizzinoCheck, forKey: "urlcheck")
    }
}

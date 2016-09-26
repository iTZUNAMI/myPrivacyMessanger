//
//  SetRedirectWebViewController.swift
//  pizzino
//
//  Created by PERSEO on 20/06/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//

import Foundation
import WebKit

class SetRedirectWebViewController : UIViewController {

    
    //delegato dalla table al newmessage
    var delegate: SetRedirectWebViewDelegate?
    
    var SetIndirizzoWeb : String!
    
    @IBOutlet var webView: UIWebView!
    @IBAction func stop(sender: UIBarButtonItem) {
        
        webView.stopLoading()
    }
   
    @IBAction func refresh(sender: UIBarButtonItem) {
        
        webView.reload()
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //impostazioni navbar
        navigationItem.title = "SETREDIRECTWEBTITLE".localized_con_commento("titolo princiaple")
        //top bar
        navigationController!.navigationBar.barStyle = UIBarStyle.BlackOpaque
        navigationController!.navigationBar.barTintColor = myColor_verde
        //colore font
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let url = NSURL(string: SetIndirizzoWeb)
        
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
        
    }
    
}
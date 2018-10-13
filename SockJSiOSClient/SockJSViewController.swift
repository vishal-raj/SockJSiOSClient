//
//  ViewController.swift
//  SockJSiOSClient
//
//  Created by Vishal Raj on 11/10/18.
//  Copyright © 2018 Vishal Raj. All rights reserved.
//

import UIKit
import WebKit

class SockJSViewController: UIViewController {
    
    var webView: WKWebView?
    var webViewLoaded = false
    var serverUrl = ""
    var accessKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSockJS()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //webView?.removeFromSuperview()
        webView = nil
        super.viewWillDisappear(animated)
    }
    
//     func auth (){
//         NetworkRequest().authenticate(org: "org_name", userName: "user_name", password: "password") { (token) in
//             if(token != nil){
//                 print(token!)
//                 NetworkRequest().getLiveUpdateKey(token: token!, completion: { (url, accessKey) in
//                     if(url != nil && accessKey != nil){
//                         self.serverUrl = url!
//                         self.accessKey = accessKey!
//                         self.initSockJS()
//                     }
//                 })
//             }
//         }
//     }
    
    func initSockJS (){
        webView = WKWebView()
        //webView!.frame = CGRect.zero
        //view.addSubview(webView!)
        
        if let url = Bundle.main.url(forResource: "template", withExtension: "html", subdirectory: "web") {
            let requestURL = NSURLRequest(url: url)
            print("request: \(requestURL)")
            webView!.uiDelegate = self
            webView!.navigationDelegate = self
            webView!.load(requestURL as URLRequest)
        }
    }
}

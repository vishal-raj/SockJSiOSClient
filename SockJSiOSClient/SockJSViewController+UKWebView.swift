//
//  ViewController+UIWebView.swift
//  SockJSiOSClient
//
//  Created by Vishal Raj on 12/10/18.
//  Copyright © 2018 Vishal Raj. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

extension SockJSViewController : WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView Loaded")
        if self.webViewLoaded == false {
            webView.evaluateJavaScript("connectToSocket('\(self.serverUrl)','\(self.accessKey)')", completionHandler: { (result, error) in
                if error != nil && result != nil{
                    print(result!)
                }
            })
            self.webViewLoaded = true
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.navigationType == .linkActivated){
            print("cancel")
            decisionHandler(.cancel)
        } else {
            print("allow")
            if navigationAction.request.url?.scheme == "sockjs" {
                DispatchQueue.main.async {
                        let urlComponents = NSURLComponents(string: (navigationAction.request.url?.absoluteString)!)
                        let queryItems = urlComponents?.queryItems
                        let param1 = queryItems?.filter({$0.name == "msg"}).first
                        let temp = String(param1!.value!)
                        if let data = temp.data(using: String.Encoding.utf8) {
                            //let json = JSON(data: data)
                            print("Live Data: \(data.debugDescription)")
                        }
                }
            }
            decisionHandler(.allow)
        }
    }
}

extension SockJSViewController: WKUIDelegate{

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: message,
                                                preferredStyle: UIAlertController.Style.alert);
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            _ in completionHandler()}
        );
        self.present(alertController, animated: true, completion: {});
    }
}


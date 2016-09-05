//
//  APUHomeVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/29/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import WebKit

class APUHomeVC: UIViewController, WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
    // Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Variables
    var url: URL!
    var timeBool: Bool!
    var timer: Timer!

    // Main
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        progressBar.progress = 0.0
        loadHomePage()
    }
    
    // Load web view
    func loadHomePage() {
//        url = URL(string: "https://home.apu.edu/")
        url = URL(string: "https://den.apu.edu/cas/login?service=https%3A//home.apu.edu/psp/PRODPRT/EMPLOYEE/HRMS/h/%3Ftab%3DDEFAULT")
        webView.loadRequest(URLRequest(url: url))
    }
    
    // Load progress bar
    func webViewDidStartLoad(_ webView: UIWebView) {
        timeBool = false
        timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(APUHomeVC.timerCallBack), userInfo: nil, repeats: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        timeBool = false
        
//        // Code found on Stack Overflow at goo.gl/Hclo7T  (Shortened url)
//        let result = webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');" +
//        "script.type = 'text/javascript';" +
//        "script.text = \"function myFunction() { " +
//        "var field = document.getElementById('field_3');" +
//        "field.value='Calling function - OK';" +
//        "}\";" +
//        "document.getElementsByTagName('head')[0].appendChild(script);")!
//        webView.stringByEvaluatingJavaScript(from: "myFunction();")!
        
//        let script = "var script = document.createElement('script');" +
//                "script.type = 'text/javascript';" +
//                "script.text = \"function myFunction() { " +
//            
//                "var TheTextBox = document.getElementById('username');" +
//                "TheTextBox.value = \"Hello World\";" +
//        
//                "}\";" +
//                "document.getElementsByTagName('head')[0].appendChild(script);"
//        webView.stringByEvaluatingJavaScript(from: "myFunction();")!
        
        let myUser = "knakamura13"
        let myPassword = "Suki1suki"
        
        let result = webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');" +
            "script.type = 'text/javascript';" +
            "script.text = \"function myFunction() { " +
                "var userNameField = document.getElementById('username');" +
                    "var passwordField = document.getElementById('password');" +
                    "var loginButton = document.getElementsByName('submit')[0];" +
                    "userNameField.value='\(myUser)';" +
                    "passwordField.value='\(myPassword)';" +
                    "loginButton.click();" +
                "}\";" +
                "document.getElementsByTagName('head')[0].appendChild(script);")!
                webView.stringByEvaluatingJavaScript(from: "myFunction();")!
    }
    
    func timerCallBack() {
        if timeBool != nil {
            if progressBar.progress >= 1 {
                progressBar.isHidden = true
                timer.invalidate()
                progressBar.progress = 1
            } else {
                progressBar.progress += 0.01
            }
        } else {
            progressBar.progress += 0.05
            if progressBar.progress >= 0.95 {
                progressBar.progress = 0.95
            }
        }
    }
}

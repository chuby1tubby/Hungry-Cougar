//
//  APUHomeVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/29/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import WebKit

var usernameStr: String? = ""
var passwordStr: String? = ""

class APUHomeVC: UIViewController, WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
    // Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Variables
    var url: URL!
    var timeBool: Bool!
    var timer: Timer!

    // Main functions
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
        url = URL(string: "https://den.apu.edu/cas/login?service=https%3A//home.apu.edu/psp/PRODPRT/EMPLOYEE/HRMS/h/%3Ftab%3DDEFAULT")
        webView.loadRequest(URLRequest(url: url))
    }
    
    // Web view finished loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // Hide the progress bar
        timeBool = false
        
        loginUser(username: usernameStr, password: passwordStr)
    }
    
    func loginUser(username: String?, password: String?) {
        // Run JavaScript script to automatically login the user
        let result1 = webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');" +
            "script.type = 'text/javascript';" +
            "script.text = \"function myFunction() { " +
            "var userNameField = document.getElementById('username');" +
            "var passwordField = document.getElementById('password');" +
            "var loginButton = document.getElementsByName('submit')[0];" +
            "userNameField.value='\(username)';" +
            "passwordField.value='\(password)';" +
            "loginButton.click();" +
            "}\";" +
            "document.getElementsByTagName('head')[0].appendChild(script);")!
        webView.stringByEvaluatingJavaScript(from: "myFunction();")!
        
        //        let result2 = webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');" +
        //            "script.type = 'text/javascript';" +
        //            "script.text = \"function findFirstDescendant(parent, tagname) { " +
        //
        //            "parent = document.getElementById(parent);" +
        //            "var descendants = parent.getElementsByTagName(tagname);" +
        //            "if (descendants.length)" +
        //            "return descendats[0];" +
        //            "return null;" +
        //
        //            "}\";" +
        //
        //            "document.getElementsByTagName('head')[0].appendChild(script);")!
        //        webView.stringByEvaluatingJavaScript(from: "findFirstDescendant(\"ptpgltbody_ADMN_APU_ONE_CARD_PAGELET_HMPG\", \"   \");")!

    }
    
    // Load progress bar
    func webViewDidStartLoad(_ webView: UIWebView) {
        timeBool = false
        timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(APUHomeVC.timerCallBack), userInfo: nil, repeats: true)
    }
    
    // Estimate progress for progress bar
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

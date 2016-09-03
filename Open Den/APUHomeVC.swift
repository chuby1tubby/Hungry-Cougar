//
//  APUHomeVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/29/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import WebKit

class APUHomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    // Variables
    var url: URL!
    var theBool: Bool = false
    var myTimer: Timer = Timer()
    var didFinishTimer: Timer = Timer()

    // Main
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHomePage()
    }
    
    // Load web view
    func loadHomePage() {
        url = URL(string: "https://home.apu.edu/")
        webView.load(URLRequest(url: url))
    }
    
    // Load progress bar
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.progressView?.setProgress(0.1, animated: false)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.progressView?.setProgress(1.0, animated: true)
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.progressView?.setProgress(1.0, animated: true)
    }
}

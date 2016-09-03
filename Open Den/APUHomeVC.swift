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
    
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadHomePage()
    }
    
    func loadHomePage() {
        url = URL(string: "https://home.apu.edu/")
        webView.load(URLRequest(url: url))
    }
}

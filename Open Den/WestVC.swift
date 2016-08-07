//
//  WestVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class WestVC: UIViewController {
    
    @IBOutlet weak var westTitleLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }
    
    func setTitle() {
        westTitleLbl.text = "West Campus Restaurants"
    }
}

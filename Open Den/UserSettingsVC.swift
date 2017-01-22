//
//  UserSettingsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 1/21/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit

class UserSettingsVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize.height = 1000
    }
    
}

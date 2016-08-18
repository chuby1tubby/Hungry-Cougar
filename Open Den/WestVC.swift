//
//  WestVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class WestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func grillButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Fusion Grill"
    }
    
    @IBAction func hillsideButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Fresh Grounds"
    }
    
    @IBAction func marketButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "West Market"
    }
    
    @IBAction func subsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Tam's Subs"
    }
    
    @IBAction func umaiButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Tasti Sushi"
    }
}

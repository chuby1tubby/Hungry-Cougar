//
//  EastVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class EastVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func diningHallButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Dining Hall"
    }
    
    @IBAction func cornerstoneButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Coffeehouse"
    }
    
    
    @IBAction func denButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "The Den"
    }
    
    
    @IBAction func cougarButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "BBQ"
    }
    
    
    @IBAction func mexicaliButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cali Grill"
    }
    
    
    @IBAction func pawsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Pause 'n Go"
    }
    
    

    
}

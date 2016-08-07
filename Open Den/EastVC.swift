//
//  EastVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class EastVC: UIViewController {

    @IBOutlet weak var eastTitleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }
    
    func setTitle() {
        eastTitleLbl.text = "East Campus Restaurants"
    }
    
    @IBAction func diningHallButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "1899 Dining Hall"
    }
    
    @IBAction func cornerstoneButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cornerstone Coffeehouse"
    }
    
    
    @IBAction func denButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar's Den Café"
    }
    
    
    @IBAction func cougarButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar Walk Café"
    }
    
    
    @IBAction func mexicaliButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Mexicali Grill"
    }
    
    
    @IBAction func pawsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Paws 'N Go"
    }
    
    

    
}

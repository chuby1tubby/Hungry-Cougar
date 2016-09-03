//
//  InformationVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/20/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import WebKit

class InformationVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var webView: WKWebView!
    
    var nameOfRestaurant = ""
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "\(restaurantChoice) Menu"
        
        setRestaurantName()
        loadMenuPage()
    }
    
    func loadMenuPage() {
        if nameOfRestaurant == "pawsngo" {
            url = URL(string: "https://www.apu.edu/diningservices/\(nameOfRestaurant)")!
        } else {
            url = URL(string: "https://www.apu.edu/diningservices/menus/\(nameOfRestaurant)")!
        }
        webView.load(URLRequest(url: url))
    }
    
    func setRestaurantName() {
        switch restaurantChoice {
        case "Dining Hall":
            nameOfRestaurant = "dininghall"
        case "Coffeehouse":
            nameOfRestaurant = "cornerstone"
        case "The Den":
            nameOfRestaurant = "cougarsden"
        case "Cougar BBQ":
            nameOfRestaurant = "cougar-walk"
        case "Cali Grill":
            nameOfRestaurant = "mexicali"
        case "Pause 'n Go":
            nameOfRestaurant = "pawsngo"
        case "Fusion Grill":
            nameOfRestaurant = "grill"
        case "Fresh Grounds":
            nameOfRestaurant = "hillside"
        case "West Market":
            nameOfRestaurant = "market"
        case "Tam's Subs":
            nameOfRestaurant = "samssubs"
        case "Tasti Sushi":
            nameOfRestaurant = "umaisushi"
        default:
            nameOfRestaurant = "cornerstone"
        }
    }
}

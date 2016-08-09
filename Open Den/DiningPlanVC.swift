//
//  DiningPlanDisplayVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class DiningPlanVC: UIViewController {

    // Outlets
    @IBOutlet weak var diningPlanLbl: UILabel!
    
    // Variables
    var currentBalance = 0.0
    var mealBudget = 0.0
    var weeklyBudget = 0.0
    var dailyBudget = 0.0
    
    // Constants
    let mealBudgets: [Double] = [1162, 978, 696, 554, 363]
    let weeklyBudgets: [Double] = [72.5, 61, 43.5, 35, 22.5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diningPlanLbl.text = diningPlanChoice
    }
    
    func calculateDiningPoints() {
        switch diningPlanChoice {
        case "No Worries":
            mealBudget = mealBudgets[0]
            weeklyBudget = weeklyBudgets[0]
        case "We've Got You Covered":
            mealBudget = mealBudgets[1]
            weeklyBudget = weeklyBudgets[1]
        case "Weekend Away":
            mealBudget = mealBudgets[2]
            weeklyBudget = weeklyBudgets[2]
        case "Forgot To Cook":
            mealBudget = mealBudgets[3]
            weeklyBudget = weeklyBudgets[3]
        case "Grab And Go":
            mealBudget = mealBudgets[4]
            weeklyBudget = weeklyBudgets[4]
        default:
            mealBudget = mealBudgets[5]
            weeklyBudget = weeklyBudgets[5]
        }
        
        dailyBudget = weeklyBudget/7            // Set daily budget to subtract from currentBalance
    }
}

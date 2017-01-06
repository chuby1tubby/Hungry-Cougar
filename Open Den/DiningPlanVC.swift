//
//  DiningPlanDisplayVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

// Global Variables
var currentBalance = 0.0
var mealBudget = 0.0
var weeklyBudget = 0.0
var dailyBudget = 0.0
var schoolWeek: Int = 0
var minute: Int = 0
var hour: Int = 0
var weekday: Int = 0
var day: Int = 0
var month: Int = 0
var year: Int = 0
var todayDate: String? = ""

class DiningPlanVC: UIViewController, UITextFieldDelegate {
    
    // Local variables
    
    // Constants
    let mealBudgets: [Double] = [1162, 978, 696, 554, 363]
    let weeklyBudgets: [Double] = [72.5, 61, 43.5, 35, 22.5]

    // Outlets
    @IBOutlet weak var diningPlanLbl: UILabel!
    @IBOutlet weak var diningPointsLbl: UILabel!
    @IBOutlet weak var loginView: CustomView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var whiteSquareView: UIView!
    @IBOutlet weak var rememberLbl: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var whiteCheckBoxView: UIView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var usersDiningPointsView: CustomView!
    @IBOutlet weak var usersDiningPointsLbl: DontCutMe!
    @IBOutlet weak var refreshImg: UIImageView!
    @IBOutlet weak var refreshBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        calculateDiningPoints()
        calculateBalance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didReceievePointsVal == true {
            usersDiningPointsView.isHidden = false
            refreshImg.isHidden = false
            refreshBtn.isHidden = false
            loginView.isHidden = true
            loginBtn.isHidden = true
            rememberLbl.isHidden = true
            whiteSquareView.isHidden = true
            
            // Formatter
            let twoDecimalFormatter = NumberFormatter()
            twoDecimalFormatter.minimumFractionDigits = 2
            let finalDouble = NSNumber(value: myFinalDouble)
            let y = NSNumber(value: Double(round(1000*Double(finalDouble))/1000))
            myFinalDouble = NSString(string: twoDecimalFormatter.string(from: (finalDouble))!).doubleValue
            
            usersDiningPointsLbl.text = "\(y)"
        }
    }
    
    func setupViews() {
        usersDiningPointsView.isHidden = true
        refreshImg.isHidden = true
        refreshBtn.isHidden = true
        loginView.isHidden = false
        loginBtn.isHidden = false
        rememberLbl.isHidden = false
        loginView.isHidden = false
        whiteCheckBoxView.layer.cornerRadius = 7
        greyView.layer.cornerRadius = 5
        diningPlanLbl.text = diningPlanChoice
        usernameField.delegate = self
        passwordField.delegate = self
        
        let prefs = UserDefaults.standard
        // If both name and pass are stored in UserDefaults
        if let name = prefs.string(forKey: "username") {
            if let pass = prefs.string(forKey: "password") {
                usernameField.text = name
                passwordField.text = pass
                greyView.isHidden = false
            } else {
                greyView.isHidden = true
            }
        } else {
            greyView.isHidden = true
        }
    }
    
    // Jump from usernameField to passwordField, then hide the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
        }
        return true
    }
    
    // Actions
    // Login Button Action
    let defaults = UserDefaults.standard
    @IBAction func onLoginPressed(_ sender: AnyObject) {
        loginActionFunc()
    }
    
    func loginActionFunc() {
        usernameStr = usernameField.text
        passwordStr = passwordField.text
        if greyView.isHidden == false {
            defaults.set(usernameStr!, forKey: "username")
            defaults.set(passwordStr!, forKey: "password")
            defaults.set(true, forKey: "userSavedDetails")
        }
        else {
            defaults.set(nil, forKey: "username")
            defaults.set(nil, forKey: "password")
            defaults.set(false, forKey: "userSavedDetails")
        }
    }
    
    // Check-box Button Action
    @IBAction func onCheckBoxPressed(_ sender: AnyObject) {
        if greyView.isHidden {
            greyView.isHidden = false
        } else {
            greyView.isHidden = true
            // Erase login details
            defaults.set(nil, forKey: "username")
            defaults.set(nil, forKey: "password")
            defaults.set(false, forKey: "userSavedDetails")
        }
    }
    
    @IBAction func onRefreshBtnPressed(_ sender: AnyObject) {
        let prefs = UserDefaults.standard
        if let name = prefs.string(forKey: "username") {
            if let pass = prefs.string(forKey: "password") {
                usernameStr = name
                passwordStr = pass
            }
        }
    }
    
    // Hide keyboard on background tap
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    
    
    
    
    
    
    
    
    
    // Dining points functions
    func calculateDiningPoints() {
        switch diningPlanChoice {
        case "No Worries":
            mealBudget = mealBudgets[0]
        case "We've Got You Covered":
            mealBudget = mealBudgets[1]
        case "Weekend Away":
            mealBudget = mealBudgets[2]
        case "Forgot To Cook":
            mealBudget = mealBudgets[3]
        case "Grab And Go":
            mealBudget = mealBudgets[4]
        default:
            mealBudget = 0.0
            weeklyBudget = 0.0
        }
        
        dailyBudget = mealBudget / 112            // Set daily budget to subtract from currentBalance
        weeklyBudget = dailyBudget * 7
        currentBalance = mealBudget               // Set current balance equal to meal plan total balance
    }
    
    func calculateBalance() {
        setSchoolWeek()
        
        // Balance for summer vacation and winter vacation
        if schoolWeek == -1 {
            currentBalance = 0.0
        }
            // Balance for mid-semester break
        else if schoolWeek == -2 {
            currentBalance = mealBudget - ((mealBudget/112)*7*9) + (mealBudget/112) + dailyBudget
        }
            // Balance for rest of the year
        else {
            currentBalance = mealBudget - (weeklyBudget * Double(schoolWeek)) - (dailyBudget * Double(weekday)) + dailyBudget
            
        }
        
        // Formatter
        let twoDecimalFormatter = NumberFormatter()
        twoDecimalFormatter.minimumFractionDigits = 2
        let balanceNum = NSNumber(value: currentBalance)
        currentBalance = NSString(string: twoDecimalFormatter.string(from: (balanceNum))!).doubleValue
        
        // Update label
        diningPointsLbl.text = "\(currentBalance)"
    }
    
    // Set the date manualy to test the calculator
    func manuallySetDay(_ mm: Int, dd: Int, yyyy: Int, wday: Int) {
        month = mm
        day = dd
        year = yyyy
        weekday = wday
    }
    
    func setSchoolWeek() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date as Date)
        weekday = components.weekday!
        day = components.day!
        month = components.month!
        year = components.year!
        
        // Optional function for testing a day
//        manuallySetDay(9, dd: 17, yyyy: 2016, wday: 7)
        
        todayDate = String("\(month).\(day).\(year-2000)")
        
        // School has yet to begin
        if month == 8 && day < 31 {
            schoolWeek = -1
        }
        
        // September
        if (month == 8 && (day >= 28 && day <= 31)) || (month == 9 && (day >= 1 && day <= 3)) {
            schoolWeek = 0
        } else if (month == 9 && (day >= 4 && day <= 10)) {
            schoolWeek = 1
        } else if (month == 9 && (day >= 11 && day <= 17)) {
            schoolWeek = 2
        } else if (month == 9 && (day >= 18 && day <= 24)) {
            schoolWeek = 3
        } else if (month == 9 && (day >= 25 && day <= 30)) || todayDate == "10.1.16" {
            schoolWeek = 4
        }
        
        // October
        if (month == 10 && (day >= 2 && day <= 8)) {
            schoolWeek = 5
        } else if (month == 10 && (day >= 9 && day <= 15)) {
            schoolWeek = 6
        } else if (month == 10 && (day >= 16 && day <= 22)) {
            schoolWeek = 7
        } else if (month == 10 && (day >= 23 && day <= 29)) {
            schoolWeek = 8
        }
        
        // November
        if (month == 10 && (day >= 30 && day <= 31) || month == 11 && (day >= 1 && day <= 5)) {
            schoolWeek = 9
        } else if (month == 11 && (day >= 6 && day <= 12)) {
            schoolWeek = 10
        } else if (month == 11 && (day >= 13 && day <= 19)) {
            schoolWeek = 11
        } else if (month == 11 && (day >= 20 && day <= 26)) {
            schoolWeek = 12
        }
        
        // December
        if (month == 11 && (day >= 27 && day <= 30) || month == 12 && (day >= 1 && day <= 3)) {
            schoolWeek = 13
        } else if (month == 12 && (day >= 4 && day <= 10)) {
            schoolWeek = 14
        } else if (month == 12 && (day >= 11 && day <= 17)) {
            schoolWeek = 15
        }
        
 
        /*
         *
         * NEW SEMESTER
         *
         */
        
        
        // Christmas break
        if (month == 12 && (day >= 18 && day <= 31)) || (month == 1 && (day >= 1 && day <= 14)) {
            schoolWeek = -1
        }
        
        // January
        if (month == 1 && (day >= 15 && day <= 21)) {
            schoolWeek = 0
        } else if (month == 1 && (day >= 22 && day <= 28)) {
            schoolWeek = 1
        } else if (month == 1 && (day >= 29 && day <= 31)) || (month == 2 && (day >= 1 && day <= 4)) {
            schoolWeek = 2
        }
        
        // February
        if (month == 2 && (day >= 5 && day <= 11)) {
            schoolWeek = 3
        } else if (month == 2 && (day >= 12 && day <= 18)) {
            schoolWeek = 4
        } else if (month == 2 && (day >= 19 && day <= 25)) {
            schoolWeek = 5
        } else if (month == 2 && (day >= 26 && day <= 28)) || (month == 3 && (day >= 1 && day <= 4)) {
            schoolWeek = 6
        }
        
        // March
        if (month == 3 && (day >= 5 && day <= 11)) {
            schoolWeek = 7
        }
        
        // Mid-semester break
        if (month == 3 && (day >= 12 && day <= 18)) {
            schoolWeek = -2
        }
        
        // March continued
        if (month == 3 && (day >= 19 && day <= 25)) {
            schoolWeek = 8
        } else if (month == 3 && (day >= 26 && day <= 31)) || todayDate == "4.1.17" {
            schoolWeek = 9
        }
        
        // April
        if (month == 4 && (day >= 2 && day <= 8)) {
            schoolWeek = 10
        } else if (month == 4 && (day >= 9 && day <= 15)) {
            schoolWeek = 11
        } else if (month == 4 && (day >= 16 && day <= 22)) {
            schoolWeek = 12
        } else if (month == 4 && (day >= 23 && day <= 29)) {
            schoolWeek = 13
        } else if todayDate == "4.30.17" || (month == 5 && (day >= 1 && day <= 6)) {
            schoolWeek = 14 // Technically week 15
        }
    }
}

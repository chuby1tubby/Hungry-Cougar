//
//  DiningPointsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

// Global Variables
var expectedBalance = 0.0
var mealBudget = 0.0
var weeklyBudget = 0.0
var dailyBudget = 0.0
var schoolWeek: Int = 0
var minute: Int = 0
var hour: Int = 0
var day: Int = 0
var weekday: Int = 0
var weekOfYear: Int = 0
var month: Int = 0
var year: Int = 0
var todayDate: String? = ""
var todayTime: String? = ""

class DiningPointsVC: UIViewController, UITextFieldDelegate {
    
    // Constants
    let mealBudgets: [Double] = [1162, 978, 696, 554, 363]

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
    @IBOutlet weak var refreshBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        calculateDiningPoints()
        setSchoolWeek()
        calculateBalance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usernameField.delegate = self
        passwordField.delegate = self
        
        // Keyboard observers KEEP THESE DO NOT EDIT
        NotificationCenter.default.addObserver(self, selector: #selector(DiningPointsVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DiningPointsVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didReceievePointsVal == true {
            usersDiningPointsView.isHidden = false
            refreshBtn.isHidden = false
            loginView.isHidden = true
            loginBtn.isHidden = true
            rememberLbl.isHidden = true
            whiteSquareView.isHidden = true
            
            // Update current dining points balance label
            let textNum = String(format: "%.2f", arguments: [myFinalDouble])
            usersDiningPointsLbl.text = textNum
        }
    }
    
    func setupViews() {
        usersDiningPointsView.isHidden = true
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
    
    // Actions
    // Login Button Action
    let defaults = UserDefaults.standard
    @IBAction func onLoginPressed(_ sender: AnyObject) {
        loginFunction()
    }
    
    @IBAction func onRefreshPressed(_ sender: Any) {
        loginFunction()
    }
    
    func loginFunction() {
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
        performSegue(withIdentifier: "APUHome", sender: nil)
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
    
    // Refresh dining points value
    @IBAction func onRefreshBtnPressed(_ sender: AnyObject) {
        let prefs = UserDefaults.standard
        if let name = prefs.string(forKey: "username") {
            if let pass = prefs.string(forKey: "password") {
                usernameStr = name
                passwordStr = pass
            }
        }
    }
    
    // Segue to Points History
    @IBAction func pointsHistoryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "pointsHistorySegue", sender: nil)
    }
    
    // Segue to Settings
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: nil)

    }
    
    // Hide keyboard on background tap
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    /*
        Dining Points calculation functions
    */
    
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
    }
    
    func calculateBalance() {
        dailyBudget = mealBudget / 112.0
        weeklyBudget = dailyBudget * 7.0
        
        // Balance for summer vacation and winter vacation
        if schoolWeek == -1 {
            expectedBalance = 0.0
        }
        // Balance for mid-semester break
        else if schoolWeek == -2 {
            expectedBalance = mealBudget/2
        }
        // Balance for rest of the year
        else {
            expectedBalance = mealBudget - (weeklyBudget * Double(schoolWeek)) - (dailyBudget * Double(weekday)) + dailyBudget
        }
        
        // Update expected balance label
        let textNum = String(format: "%.2f", arguments: [expectedBalance])
        diningPointsLbl.text = textNum
    }
    
    // Set the date manualy to test the calculator
    func manuallySetDay(_ mm: Int, dd: Int, woy: Int, yyyy: Int, wday: Int) {
        month = mm
        day = dd
        weekOfYear = woy
        year = yyyy
        weekday = wday
    }
    
    func setSchoolWeek() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday, .day, .weekOfYear, .month, .year], from: date as Date)
        weekday = components.weekday!
        weekOfYear = components.weekOfYear!
        day = components.day!
        month = components.month!
        year = components.year!
        
        // Optional function for testing a day
//        manuallySetDay(1, dd: 18, woy: 1, yyyy: 2017, wday: 4)
        
        todayDate = String("\(month).\(day).\(year-2000)")
        
        // School has yet to begin
        if month == 1 && day < 8 {
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
        if monthBetweenDays(MM: 12, ST: 18, ED: 31) || monthBetweenDays(MM: 1, ST: 1, ED: 14) {
            schoolWeek = -1
        }
        
        // January
        if monthBetweenDays(MM: 1, ST: 8, ED: 14) {
            schoolWeek = 0
        } else if monthBetweenDays(MM: 1, ST: 15, ED: 21) {
            schoolWeek = 1
        } else if monthBetweenDays(MM: 1, ST: 22, ED: 28) {
            schoolWeek = 2
        } else if monthBetweenDays(MM: 1, ST: 29, ED: 31) || monthBetweenDays(MM: 2, ST: 1, ED: 4) {
            schoolWeek = 3
        }
        print("KYLE: The school week is: \(schoolWeek)")
        
        // February
        if monthBetweenDays(MM: 2, ST: 5, ED: 11) {
            schoolWeek = 4
        } else if monthBetweenDays(MM: 2, ST: 12, ED: 18) {
            schoolWeek = 5
        } else if monthBetweenDays(MM: 2, ST: 19, ED: 25) {
            schoolWeek = 6
        } else if monthBetweenDays(MM: 2, ST: 26, ED: 28) || monthBetweenDays(MM: 3, ST: 1, ED: 4) {
            schoolWeek = 7
        }
        
        // Mid-Semester Break
        if monthBetweenDays(MM: 3, ST: 5, ED: 11) {
            schoolWeek = -2
        }
        
        // March
        if monthBetweenDays(MM: 3, ST: 12, ED: 18) {
            schoolWeek = 8
        } else if monthBetweenDays(MM: 3, ST: 19, ED: 25) {
            schoolWeek = 9
        }
        
        // April
        if monthBetweenDays(MM: 3, ST: 26, ED: 31) || todayDate == "3.1.1" {
            schoolWeek = 10
        } else if monthBetweenDays(MM: 4, ST: 2, ED: 8) {
            schoolWeek = 11
        } else if monthBetweenDays(MM: 4, ST: 9, ED: 15) {
            schoolWeek = 12
        } else if monthBetweenDays(MM: 4, ST: 16, ED: 22) {
            schoolWeek = 13
        } else if monthBetweenDays(MM: 4, ST: 23, ED: 29) {
            schoolWeek = 14
        } else if monthBetweenDays(MM: 4, ST: 24, ED: 30) {
            schoolWeek = 15
        }
    }
    
    func monthBetweenDays(MM: Int, ST: Int, ED: Int) -> Bool {
        if month == MM && (day >= ST && day <= ED) {
            return true
        } else {
            return false
        }
    }
    
    
    
    /*
     
     Keyboard functions
     
     */
    
    // Keyboard view-moving functions
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 0.5
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height * 0.5
            }
        }
    }
    
    // Jump from usernameField to passwordField, then hide the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            usernameField.resignFirstResponder()
            passwordField.resignFirstResponder()
        }
        return true
    }
}

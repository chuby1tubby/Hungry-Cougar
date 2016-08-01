//
//  ViewController.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    // Base values
    var currentHour: Int = 0
    var currentMinute: Int = 0
    var storeIsOpen: Bool = false
    var timeUntilOpen: Int = 0
    var timeUntilClose: Int = 0
    
    @IBOutlet weak var iPhoneYesNoLbl: UILabel!
    @IBOutlet weak var iPhoneHoursLbl: UILabel!
    @IBOutlet weak var iPhoneTitleView: UIView!
    @IBOutlet weak var iPadYesNoLbl: UILabel!
    @IBOutlet weak var iPadHoursLbl: UILabel!
    @IBOutlet weak var iPadTitleView: UIView!
    
    // Initialized Days
    var Sunday: Day = Day(openingHour: 17, closingHour: 24)
    var Monday: Day = Day(openingHour: 11, closingHour: 24)
    var Tuesday: Day = Day(openingHour: 11, closingHour: 24)
    var Wednesday: Day = Day(openingHour: 11, closingHour: 24)
    var Thursday: Day = Day(openingHour: 11, closingHour: 24)
    var Friday: Day = Day(openingHour: 11, closingHour: 19)
    var Saturday: Day = Day(openingHour: 0, closingHour: 0)
    var Today: Day = Day(openingHour: 0, closingHour: 0)

    // Loads when view appears
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Loads right before view appears
    override func viewWillAppear(_ animated: Bool) {
        loadCurrentDateTime()
    }

    func loadCurrentDateTime() {
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.components([.minute, .hour, .weekday], from: date as Date)
        
        // Set time and day
        let weekday = components.weekday
        let hour = components.hour
        let minute = components.minute
        currentHour = hour!
        currentMinute = minute!
        
        // Set current day hours
        switch weekday! {
        case 1:
            Today.openHour = Sunday.openHour
            Today.closeHour = Sunday.closeHour
            checkIfOpen()
        case 2:
            Today.openHour = Monday.openHour
            Today.closeHour = Monday.closeHour
            checkIfOpen()
        case 3:
            Today.openHour = Tuesday.openHour
            Today.closeHour = Tuesday.closeHour
            checkIfOpen()
        case 4:
            Today.openHour = Wednesday.openHour
            Today.closeHour = Wednesday.closeHour
            checkIfOpen()
        case 5:
            Today.openHour = Thursday.openHour
            Today.closeHour = Thursday.closeHour
            checkIfOpen()
        case 6:
            Today.openHour = Friday.openHour
            Today.closeHour = Friday.closeHour
            checkIfOpen()
        case 7:
            // Saturday closed all day
            Today.openHour = Saturday.openHour
            Today.closeHour = Saturday.closeHour
            iPhoneYesNoLbl.text = "NO"
            iPadYesNoLbl.text = "NO"
            storeIsOpen = false
        default:
            iPhoneYesNoLbl.text = "a"
            iPadYesNoLbl.text = "a"
            storeIsOpen = true
        }
    }
    
    func checkIfOpen() {
        if currentHour > Today.closeHour && currentHour < Today.openHour {
            iPhoneYesNoLbl.text = "NO"
            iPadYesNoLbl.text = "NO"
            storeIsOpen = false
        } else {
            iPhoneYesNoLbl.text = "YES"
            iPadYesNoLbl.text = "YES"
            storeIsOpen = true
        }
        calculateTimeUntilOpen()
    }
    
    func calculateTimeUntilOpen() {
        timeUntilOpen = Today.openHour - currentHour
        timeUntilClose = Today.closeHour - currentHour
        if storeIsOpen == false {
            iPhoneHoursLbl.text = String("Opening in \(timeUntilOpen) hours")
            iPadHoursLbl.text = String("Opening in \(timeUntilOpen) hours")
        } else {
            iPhoneHoursLbl.text = "Closing in \(timeUntilClose) hours"
            iPadHoursLbl.text = "Closing in \(timeUntilClose) hours"
        }
    }
}

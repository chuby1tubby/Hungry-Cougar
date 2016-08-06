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
    var hoursUntilOpen: Int = 0
    var hoursUntilClose: Int = 0
    var minutesLeft: Int = 0
    var minutesUntilClose: Int = 0
    
    // IBOutlets
    @IBOutlet weak var iPhoneYesNoLbl: UILabel!
    @IBOutlet weak var iPhoneHoursLbl: UILabel!
    @IBOutlet weak var iPadYesNoLbl: UILabel!
    @IBOutlet weak var iPadHoursLbl: UILabel!
    @IBOutlet weak var landscapeYesNoLbl: UILabel!
    @IBOutlet weak var landscapeHoursLbl: UILabel!
    
    // New outlets
    
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
    
    func loadDateTime() {
        
    }

    func loadCurrentDateTime() {
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .weekday], from: date as Date)
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
            iPhoneYesNoLbl.text = "NO"
            iPadYesNoLbl.text = "NO"
            landscapeYesNoLbl.text = "NO"
            storeIsOpen = false
        default:
            iPhoneYesNoLbl.text = "ERR"
            iPadYesNoLbl.text = "ERR"
            landscapeYesNoLbl.text = "ERR"
            storeIsOpen = true
        }
    }
    
    func checkIfOpen() {
        if currentHour > Today.closeHour || currentHour < Today.openHour {
            iPhoneYesNoLbl.text = "NO"
            iPadYesNoLbl.text = "NO"
            landscapeYesNoLbl.text = "NO"
            storeIsOpen = false
        } else {
            iPhoneYesNoLbl.text = "YES"
            iPadYesNoLbl.text = "YES"
            landscapeYesNoLbl.text = "YES"
            storeIsOpen = true
        }
        calculateTimeUntilOpen()
    }
    
    func calculateTimeUntilOpen() {
        hoursUntilOpen = Today.openHour - currentHour - 1
        hoursUntilClose = Today.closeHour - currentHour - 1
        
        minutesLeft = 60 - currentMinute
        
        if storeIsOpen == false {
            if hoursUntilOpen > 0 {
                iPhoneHoursLbl.text = "Opening in \(hoursUntilOpen) hours \(minutesLeft) minutes"
                iPadHoursLbl.text = "Opening in \(hoursUntilOpen) hours \(minutesLeft) minutes"
                landscapeHoursLbl.text = "Opening in \(hoursUntilOpen) hours \(minutesLeft) minutes"
            } else if hoursUntilOpen <= 0 {
                iPhoneHoursLbl.text = "Opening in \(minutesLeft) minutes"
                iPadHoursLbl.text = "Opening in \(minutesLeft) minutes"
                landscapeHoursLbl.text = "Opening in \(minutesLeft) minutes"
            }
        } else {
            if hoursUntilClose > 0 {
                iPhoneHoursLbl.text = "Closing in \(hoursUntilClose) hours \(minutesLeft) minutes"
                iPadHoursLbl.text = "Closing in \(hoursUntilClose) hours \(minutesLeft) minutes"
                landscapeHoursLbl.text = "Closing in \(hoursUntilClose) hours \(minutesLeft) minutes"
            } else if hoursUntilClose <= 0 {
                iPhoneHoursLbl.text = "Closing in \(minutesLeft) minutes"
                iPadHoursLbl.text = "Closing in \(minutesLeft) minutes"
                landscapeHoursLbl.text = "Closing in \(minutesLeft) minutes"
            }
        }
    }
}

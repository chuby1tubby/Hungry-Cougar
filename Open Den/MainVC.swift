//
//  ViewController.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Foundation

public var restaurantChoice = ""

class ViewController: UIViewController {
    // Base values
    var currentHour: Double = 0
    var currentMinute: Int = 0
    
    var storeIsOpen: Bool = false
    
    var hoursUntilOpen: Double = 0
    var hoursUntilClose: Double = 0
    var minutesLeft: Int = 0
    var minutesUntilClose: Int = 0
    
    // IBOutlets
    @IBOutlet weak var yesNoLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    
    // Loads when view appears
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = restaurantChoice
    }
    
    // Loads right before view appears
    override func viewWillAppear(_ animated: Bool) {
        setHours()
        loadCurrentDateTime()
    }
    
    func loadCurrentDateTime() {
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .weekday], from: date as Date)
        let weekday = components.weekday
        let hour = components.hour
        let minute = components.minute
        currentHour = Double(hour!)
        currentMinute = minute!
        
        // Set current day hours
        switch weekday! {
        case 1:
            Today.openHour = Sunday.openHour
            Today.closeHour = Sunday.closeHour
            Tomorrow = Monday
            checkIfOpen()
        case 2:
            Today.openHour = Monday.openHour
            Today.closeHour = Monday.closeHour
            Tomorrow = Tuesday
            checkIfOpen()
        case 3:
            Today.openHour = Tuesday.openHour
            Today.closeHour = Tuesday.closeHour
            Tomorrow = Wednesday
            checkIfOpen()
        case 4:
            Today.openHour = Wednesday.openHour
            Today.closeHour = Wednesday.closeHour
            Tomorrow = Thursday
            checkIfOpen()
        case 5:
            Today.openHour = Thursday.openHour
            Today.closeHour = Thursday.closeHour
            Tomorrow = Friday
            checkIfOpen()
        case 6:
            Today.openHour = Friday.openHour
            Today.closeHour = Friday.closeHour
            Tomorrow = Saturday
            checkIfOpen()
        case 7:
            Today.openHour = Saturday.openHour
            Today.closeHour = Saturday.closeHour
            Tomorrow = Sunday
            checkIfOpen()
        default:
            yesNoLbl.text = "ERR"
            storeIsOpen = true
        }
    }
    
    func checkIfOpen() {
        if Today.closeHour >= 1.0 && Today.closeHour <= 3.0 {
            // If open past midnight (coffeehouse)
            if currentHour >= Today.closeHour && currentHour < Today.openHour{
                // Store is CLOSED
                yesNoLbl.text = "CLOSED"
                storeIsOpen = false
            } else {
                // Store is OPEN
                yesNoLbl.text = "OPEN"
                storeIsOpen = true
            }
        } else {
            // If not open past midnight
            if !(floor(Today.closeHour) == Today.closeHour) || !(floor(Today.openHour) == Today.openHour) {
                // If closing hour isn't a whole number
                if (currentHour >= Today.closeHour && minutesLeft <= 30) || (currentHour <= Today.openHour  && minutesLeft < 30) {
                    yesNoLbl.text = "CLOSED"
                    storeIsOpen = false
                } else {
                    yesNoLbl.text = "OPEN"
                    storeIsOpen = true
                }
            } else {
                // If closeHour or openHour is a whole number
                if currentHour >= Today.closeHour || currentHour <= Today.openHour {
                    yesNoLbl.text = "CLOSED"
                    storeIsOpen = false
                } else {
                    yesNoLbl.text = "OPEN"
                    storeIsOpen = true
                }
            }
        }
        calculateTimeUntilOpen()
    }
    
    func calculateTimeUntilOpen() {
        if storeIsOpen == false {
            if currentHour > Today.closeHour && currentHour < 24 {
                hoursUntilOpen = (23 - currentHour) + (Tomorrow.openHour)
                hoursUntilClose = 0
            } else {
                hoursUntilOpen = Today.openHour - currentHour - 1
                hoursUntilClose = 0
            }
        } else if storeIsOpen == true {
            if Today.closeHour == 1 {       // If store closes at exactly 1am
                hoursUntilClose = 25 - currentHour - 1
                hoursUntilOpen = 0
            } else /* If store closes before midnight */ {
                hoursUntilClose = Today.closeHour - currentHour - 1
                hoursUntilOpen = 0
            }
        }
        
        minutesLeft = 60 - currentMinute
        
        if storeIsOpen == false {
            if Tomorrow.openHour == 0  || Today.openHour == 0 || Today.closeHour == 0 {     // Tomorrow closed all day
                hoursLbl.text = "Closed for the weekend"
                if Tomorrow.openHour > 0 {
                    if hoursUntilOpen > 1 {
                        hoursLbl.text = "Opening in \(Int(hoursUntilOpen)) hours \(minutesLeft) minutes"
                    } else if hoursUntilOpen <= 0 {
                        hoursLbl.text = "Opening in \(minutesLeft) minutes"
                    }
                }
                if restaurantChoice == "Cougar Walk Café" {
                    hoursLbl.text = "Restaurant hours unavailable"
                }
            } else /* If the store is open tomorrow */ {
                if hoursUntilOpen > 1 {
                    hoursLbl.text = "Opening in \(Int(hoursUntilOpen)) hours \(minutesLeft) minutes"
                } else if hoursUntilOpen <= 0 {
                    hoursLbl.text = "Opening in \(minutesLeft) minutes"
                }
            }
        } else /* If store is closed */ {
            if hoursUntilClose > 1 {
                hoursLbl.text = "Closing in \(Int(hoursUntilClose)) hours \(minutesLeft) minutes"
            } else {
                hoursLbl.text = "Closing in \(minutesLeft) minutes"
            }
        }
    }
}

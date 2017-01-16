//
//  HoursVC.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
//import Foundation

public var restaurantChoice = ""

class HoursVC: UIViewController {
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
        checkIfOpen()
        calculateTimeUntilOpen()
    }
    
    // Set the date manualy to test the calculator
    func manuallySetDay(_ mm: Int, dd: Int, yyyy: Int, wday: Int, hr: Int, min: Int) {
        month = mm
        day = dd
        year = yyyy
        weekday = wday
        hour = hr
        minute = min
    }
    
    func loadCurrentDateTime() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .weekday], from: date as Date)
        let weekday = components.weekday
        let hour = components.hour
        let minute = components.minute
        
        // Manually set current date and time
//        manuallySetDay(9, dd: 17, yyyy: 2016, wday: 7, hr: 17, min: 23)
        
        currentHour = Double(hour!)
        currentMinute = minute!
        
        // Set current day hours
        switch weekday! {
        case 1:
            Yesterday = Saturday
            Today = Sunday
            Tomorrow = Monday
        case 2:
            Yesterday = Sunday
            Today = Monday
            Tomorrow = Tuesday
        case 3:
            Yesterday = Monday
            Today = Tuesday
            Tomorrow = Wednesday
        case 4:
            Yesterday = Tuesday
            Today = Wednesday
            Tomorrow = Thursday
        case 5:
            Yesterday = Wednesday
            Today = Thursday
            Tomorrow = Friday
        case 6:
            Yesterday = Thursday
            Today = Friday
            Tomorrow = Saturday
        case 7:
            Yesterday = Friday
            Today = Saturday
            Tomorrow = Sunday
        default:
            yesNoLbl.text = "ERR"
            storeIsOpen = true
        }
    }
    
    func checkIfOpen() {
        yesNoLbl.text = "OPEN"
        storeIsOpen = true
        
        /*
            I need to make sure this logic is correct. Something seems wrong here.
        */
        
        // If open past midnight (coffeehouse)
        if Today.closeHour >= 1.0 && Today.closeHour <= 3.0 {
            if currentHour >= Today.closeHour && currentHour < Today.openHour{
                yesNoLbl.text = "CLOSED"
                storeIsOpen = false
            }
        }
            // If not open past midnight
        else {
            if !(floor(Today.closeHour) == Today.closeHour) || !(floor(Today.openHour) == Today.openHour) {
                // If closing hour isn't a whole number
                if (currentHour >= Today.closeHour && minutesLeft <= 30) || (currentHour <= Today.openHour  && minutesLeft < 30) {
                    yesNoLbl.text = "CLOSED"
                    storeIsOpen = false
                }
            } else {
                // If closeHour or openHour is a whole number
                if currentHour >= Today.closeHour || currentHour <= Today.openHour {
                    yesNoLbl.text = "CLOSED"
                    storeIsOpen = false
                }
            }
        }
    }
    
    func calculateTimeUntilOpen() {
        // If the store is CLOSED
        if storeIsOpen == false {
            if currentHour >= Today.closeHour {
                hoursUntilOpen = (23 - currentHour) + (Tomorrow.openHour)
                hoursUntilClose = 0
            } else {
                hoursUntilOpen = Today.openHour - currentHour - 1
                hoursUntilClose = 0
            }
        }
            
            // If the store is OPEN
        else {
            if Today.closeHour == 1 {       // If store closes at exactly 1am
                hoursUntilClose = 25 - currentHour - 1
                hoursUntilOpen = 0
            } else /* If store closes before 1am */ {
                hoursUntilClose = Today.closeHour - currentHour - 1
                hoursUntilOpen = 0
            }
        }
        
        // Calculate minutes until the next hour
        minutesLeft = 60 - currentMinute
        
        // If the store is CLOSED
        if storeIsOpen == false {
            if Today.openHour == 0 && Today.closeHour == 0 {
                hoursLbl.text = "Closed all day today"
                
                if Tomorrow.openHour == 0 && Tomorrow.closeHour == 0 {
                hoursLbl.text = "Closed until Monday"
                }
            }
                
            else {
                // Calculate hours until open only if store is opening soon
                if hoursUntilOpen <= 0 {
                    hoursLbl.text = "Opening in \(minutesLeft) minutes"
                }
                
                else {
                    if currentHour < Today.openHour {    // Between midnight and open time
                        if Today.openHour == 1 {
                            hoursLbl.text = "Opening at 1am"
                        } else {
                            if Today.openHour <= 12 {
                                hoursLbl.text = "Opening at \(Int(Today.openHour))am"
                            } else if Today.openHour > 12 {
                                hoursLbl.text = "Opening at \(Int(Today.openHour)-12)pm"
                            }
                        }
                    } else if currentHour >= Today.closeHour {   // *** PRETTY SURE THIS LOGIC IS INCORRECT ***
                        if Tomorrow.openHour == 1 {
                            hoursLbl.text = "Opening at 1am"
                        } else {
                            if Tomorrow.openHour < 12 {
                                hoursLbl.text = "Opening at \(Int(Tomorrow.openHour))am"
                            } else if Today.openHour >= 12 {
                                if Today.openHour == 12 {
                                    hoursLbl.text = "Opening at 12pm"
                                } else {
                                    hoursLbl.text = "Opening at \(Int(Tomorrow.openHour)-12)pm"
                                }
                            }
                        }
                    }
                    
                    // If openHour is a half hour
                    if !(floor(Today.openHour) == Today.openHour) {
                        if Today.openHour <= 12 {
                            hoursLbl.text = "Opening at \(Int(Today.openHour)):30am"
                        } else if Today.openHour > 12 {
                            hoursLbl.text = "Opening at \(Int(Today.openHour)-12):30pm"
                        }
                    }
                }
            }
        }
            
        // If the store is OPEN
        else {
            if hoursUntilClose <= 0 {
                hoursLbl.text = "Closing in \(minutesLeft) minutes"
            } else {
                if Today.closeHour == 24 {
                    hoursLbl.text = "Closing at 12am"
                } else if Today.closeHour == 1 {
                    hoursLbl.text = "Closing at 1am"
                } else {
                    hoursLbl.text = "Closing at \(Int(Today.closeHour)-12)pm"
                }
            }
        }
        
        if restaurantChoice == "Cougar BBQ" {
            hoursLbl.text = "Hours unavailable"
        } else if restaurantChoice == "The Den" {
            hoursLbl.text = "Closed for renovation"
        }
    }
}

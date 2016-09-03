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
        // If the store is CLOSED
        if storeIsOpen == false {
            if currentHour >= Today.closeHour && currentHour < 24 {
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
                } else {
                    if currentHour < 24 && currentHour != 0 {  // If not yet midnight
                        if Today.openHour == 1 {
                            hoursLbl.text = "Opening at 1am"
                        } else {
                            if Today.openHour <= 12 {
                                hoursLbl.text = "Opening at \(Int(Today.openHour))am"
                            } else if Today.openHour > 12 {
                                hoursLbl.text = "Opening at \(Int(Today.openHour)-12)pm"
                            }
                        }
                    } else if currentHour == 24 || currentHour >= 0 {   // *** PRETTY SURE THIS LOGIC IS INCORRECT ***
                        if Tomorrow.openHour == 1 {
                            hoursLbl.text = "Opening at 1am"
                        } else {
                            if Tomorrow.openHour <= 12 {
                                hoursLbl.text = "Opening at \(Int(Tomorrow.openHour))am"
                            } else if Today.openHour > 12 {
                                hoursLbl.text = "Opening at \(Int(Tomorrow.openHour)-12)pm"      // I switched all Tomorrows with Todays
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
                
                if restaurantChoice == "Cougar BBQ" {
                    hoursLbl.text = "Hours unavailable"
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
            
            if restaurantChoice == "Cougar BBQ" {
                hoursLbl.text = "Hours unavailable"
            }
        }
    }
}

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
//        manuallySetDay(1, dd: 18, yyyy: 2017, wday: 4, hr: 7, min: 37)
        
        currentHour = Double(hour!)
//        currentHour = 7               // Set manual hour
        currentMinute = minute!
//        currentMinute = 29            // Set manual minute
        
        // Calculate minutes until the next hour
        minutesLeft = 60 - currentMinute
        
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
        // Default values
        yesNoLbl.text = "OPEN"
        storeIsOpen = true
        
        /*
            I need to make sure this logic is correct. Something seems wrong here.
        */
        
        // If currently between midnight and open hours (0 to 7 roughly)
        if currentHour < floor(Today.openTime) {
            // If yesterday closed at midnight or 1am or 2am (Exactly 0 or 1 or 2)
            if Yesterday.closeTime == 0 || Yesterday.closeTime == 1 || Yesterday.closeTime == 2 {
                // If time has past yesterday closeTime
                if currentHour >= Yesterday.closeTime {
                    storeIsOpen = false
                    print("KYLE: BOOLEAN #1")
                }
            }
            // Else for half-number close hours
            else if Yesterday.closeTime >= 0 && Yesterday.closeTime <= 2 && (floor(Yesterday.closeTime) != Yesterday.closeTime) {
                let minutesFloorVal = (Yesterday.closeTime - floor(Yesterday.closeTime)) * 60   // Convert 0.5 hours to 30 minutes
                if currentHour >= Yesterday.closeTime {
                    if currentHour == Yesterday.closeTime {
                        if minutesLeft >= Int(minutesFloorVal) {
                            storeIsOpen = false
                            print("KYLE: BOOLEAN #2")
                        }
                    } else {
                        storeIsOpen = false
                        print("KYLE: BOOLEAN #3")
                    }
                }
            }
            // Else if yesterday closed before midnight
            else {
                storeIsOpen = false
                print("KYLE: BOOLEAN #4")
            }
        }
        // If currently between roughly 7am and midnight (7 to 23 roughly) AND store does not close after midnight
        else if currentHour >= Today.openTime && !(Today.closeTime >= 0 && Today.closeTime <= 3){
            // For whole-number close hours
            if floor(Today.closeTime) == Today.closeTime {
                if currentHour >= Today.closeTime {
                    storeIsOpen = false
                    print("KYLE: BOOLEAN #5")
                }
            }
            // Else for half-number close hours
            else {
                let minutesFloorVal = (Today.closeTime - floor(Today.closeTime)) * 60   // Convert 0.5 hours to 30 minutes
                if currentHour >= Today.closeTime {
                    if currentHour == Today.closeTime {
                        if minutesLeft >= Int(minutesFloorVal) {
                            storeIsOpen = false
                            print("KYLE: BOOLEAN #6")
                        }
                    } else {
                        storeIsOpen = false
                        print("KYLE: BOOLEAN #7")
                    }
                }
            }
        } else {
            print("KYLE: Made it to the else.")
            
        }
        
        if Today.hasNoHours {
            storeIsOpen = false
        }
        
        // Set yesNoLabel
        if storeIsOpen {
            yesNoLbl.text = "OPEN"
        } else {
            yesNoLbl.text = "CLOSED"
        }
    }
    
    func calculateTimeUntilOpen() {
        // If the store is CLOSED
        if storeIsOpen == false {
            if currentHour >= Today.closeTime && Today.closeTime != 0 {
                hoursUntilOpen = (23 - currentHour) + Tomorrow.openTime
                hoursUntilClose = 0
            } else {
                hoursUntilOpen = Today.openTime - currentHour - 1
                hoursUntilClose = 0
            }
        }
            
        // If the store is OPEN
        else {
            // If store closes between 0 and 1am
            if floor(Today.closeTime) == 0 {
                hoursUntilClose = 24 - currentHour
                hoursUntilOpen = 0
            } else if floor(Today.closeTime) == 1 {
                hoursUntilClose = 25 - currentHour
                hoursUntilOpen = 0
            }
            // Else if store closes at normal hours
            else {
                hoursUntilClose = Today.closeTime - currentHour - 1
                hoursUntilOpen = 0
            }
        }
        
        // If the store is CLOSED
        if storeIsOpen == false {
            if Today.hasNoHours {
                hoursLbl.text = "Closed all day today"
                if Tomorrow.hasNoHours {
                    hoursLbl.text = "Closed until Monday"
                }
            }
            else {
                // Calculate hours until open only if store is opening soon
                if hoursUntilOpen == 0 {
                    hoursLbl.text = "Opening in \(minutesLeft) minutes"
                }
                else {
                    // If currently between midnight and open hours (0 to 7 roughly)
                    if currentHour < Today.openTime {
                        // If yesterday closed at midnight or 1am or 2am (Exactly 0 or 1 or 2)
                        if Yesterday.closeTime == 0 || Yesterday.closeTime == 1 || Yesterday.closeTime == 2 {
                            // If time has past yesterday closeTime
                            if currentHour >= Yesterday.closeTime {
                                if Today.openTime <= 12 {
                                    hoursLbl.text = "Opening at \(Int(Today.openTime))am"
                                } else if Today.openTime > 12 {
                                    hoursLbl.text = "Opening at \(Int(Today.openTime)-12)pm"
                                }
                                print("KYLE: TWO BOOLEAN #1")
                            }
                        }
                            // Else for half-number close hours
                        else if Yesterday.closeTime >= 0 && Yesterday.closeTime <= 2 && (floor(Yesterday.closeTime) != Yesterday.closeTime) {
                            let minutesFloorVal = (Yesterday.closeTime - floor(Yesterday.closeTime)) * 60   // Convert 0.5 hours to 30 minutes
                            if currentHour >= Yesterday.closeTime {
                                if currentHour == Yesterday.closeTime {
                                    if minutesLeft >= Int(minutesFloorVal) {
                                        if Today.openTime <= 12 {
                                            hoursLbl.text = "Opening at \(Int(Today.openTime)):30am"
                                        } else if Today.openTime > 12 {
                                            hoursLbl.text = "Opening at \(Int(Today.openTime)-12):30pm"
                                        }
                                        print("KYLE: TWO BOOLEAN #3")
                                    }
                                } else {
                                    if Today.openTime <= 12 {
                                        hoursLbl.text = "Opening at \(Int(Today.openTime)):30am"
                                    } else if Today.openTime > 12 {
                                        hoursLbl.text = "Opening at \(Int(Today.openTime)-12):30pm"
                                    }
                                    print("KYLE: TWO BOOLEAN #4")
                                }
                            }
                        }
                        // Else if yesterday closed at normal hours
                        else {
                            if Today.openTime <= 12 {
                                hoursLbl.text = "Opening at \(Int(Today.openTime))am"
                            } else if Today.openTime > 12 {
                                hoursLbl.text = "Opening at \(Int(Today.openTime)-12)pm"
                            }
                            print("KYLE: TWO BOOLEAN #5")
                        }
                    }
                    // If currently between roughly 7am and midnight (7 to 23 roughly) AND store does not close after midnight
                    else if currentHour >= Today.openTime && !(Today.closeTime >= 0 && Today.closeTime <= 3) {
                        // For whole-number close hours
                        if floor(Today.closeTime) == Today.closeTime {
                            if currentHour >= Today.closeTime {
                                if Today.openTime <= 12 {
                                    hoursLbl.text = "Opening at \(Int(Today.openTime))am"
                                } else if Today.openTime > 12 {
                                    hoursLbl.text = "Opening at \(Int(Today.openTime)-12)pm"
                                }
                                print("KYLE: TWO BOOLEAN #6")
                            }
                        }
                        // Else for half-number close hours
                        else {
                            let minutesFloorVal = (Today.closeTime - floor(Today.closeTime)) * 60   // Convert 0.5 hours to 30 minutes
                            if currentHour >= Today.closeTime {
                                if currentHour == Today.closeTime {
                                    if minutesLeft >= Int(minutesFloorVal) {
                                        if Today.openTime <= 12 {
                                            hoursLbl.text = "Opening at \(Int(Today.openTime)):30am"
                                        } else if Today.openTime > 12 {
                                            hoursLbl.text = "Opening at \(Int(Today.openTime)-12):30pm"
                                        }
                                        print("KYLE: TWO BOOLEAN #8")
                                    }
                                } else {
                                    if Today.openTime <= 12 {
                                        hoursLbl.text = "Opening at \(Int(Today.openTime)):30am"
                                    } else if Today.openTime > 12 {
                                        hoursLbl.text = "Opening at \(Int(Today.openTime)-12):30pm"
                                    }
                                    print("KYLE: TWO BOOLEAN #9")
                                }
                            }

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
                if Today.closeTime == 0 {
                    hoursLbl.text = "Closing at 12am"
                } else if Today.closeTime == 1 {
                    hoursLbl.text = "Closing at 1am"
                } else {
                    hoursLbl.text = "Closing at \(Int(Today.closeTime)-12)pm"
                }
            }
        }
        
        if restaurantChoice == "Cougar BBQ" {
            hoursLbl.text = "Hours unavailable"
        }
    }
}

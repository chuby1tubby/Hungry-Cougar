//
//  RestaurantHours.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/6/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import Foundation
import UIKit

class RestaurantHours {
    var restaurantSelection = ""
    
    func setHours() {
        // Initialized Days
        var Sunday: Day = Day(openingHour: 0, closingHour: 0)
        var Monday: Day = Day(openingHour: 0, closingHour: 0)
        var Tuesday: Day = Day(openingHour: 0, closingHour: 0)
        var Wednesday: Day = Day(openingHour: 0, closingHour: 0)
        var Thursday: Day = Day(openingHour: 0, closingHour: 0)
        var Friday: Day = Day(openingHour: 0, closingHour: 0)
        var Saturday: Day = Day(openingHour: 0, closingHour: 0)
        var Today: Day = Day(openingHour: 0, closingHour: 0)
        var Tomorrow: Day = Day(openingHour: 0, closingHour: 0)
        
        if restaurantSelection == "Cougar's Den Café" {
            Sunday.openHour = 17; Sunday.closeHour = 24
            Monday.openHour = 11; Monday.closeHour = 24
            Tuesday.openHour = 11; Tuesday.closeHour = 24
            Wednesday.openHour = 11; Wednesday.closeHour = 24
            Thursday.openHour = 11; Thursday.closeHour = 24
            Friday.openHour = 11; Friday.closeHour = 19
            Saturday.openHour = 0; Saturday.closeHour = 0
        }
    }
}

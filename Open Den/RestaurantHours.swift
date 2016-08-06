//
//  RestaurantHours.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/6/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import Foundation
import UIKit

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

func setHours() {
    if restaurantChoice == "1899 Dining Hall" {
        Sunday.openHour = 17; Sunday.closeHour = 24
        Monday.openHour = 11; Monday.closeHour = 24
        Tuesday.openHour = 11; Tuesday.closeHour = 24
        Wednesday.openHour = 11; Wednesday.closeHour = 24
        Thursday.openHour = 11; Thursday.closeHour = 24
        Friday.openHour = 11; Friday.closeHour = 19
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "Cougar's Den Café" {
        Sunday.openHour = 17; Sunday.closeHour = 24
        Monday.openHour = 11; Monday.closeHour = 24
        Tuesday.openHour = 11; Tuesday.closeHour = 24
        Wednesday.openHour = 11; Wednesday.closeHour = 24
        Thursday.openHour = 11; Thursday.closeHour = 24
        Friday.openHour = 11; Friday.closeHour = 19
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else if restaurantChoice == "" {
        
    } else {
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 0; Monday.closeHour = 0
        Tuesday.openHour = 0; Tuesday.closeHour = 0
        Wednesday.openHour = 0; Wednesday.closeHour = 0
        Thursday.openHour = 0; Thursday.closeHour = 0
        Friday.openHour = 0; Friday.closeHour = 0
        Saturday.openHour = 0; Saturday.closeHour = 0
    }
}

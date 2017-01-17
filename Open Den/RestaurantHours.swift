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
var Sunday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Monday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Tuesday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Wednesday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Thursday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Friday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Saturday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Yesterday: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Today: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var Tomorrow: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)
var ZeroDay: Day = Day(openingHour: 0, closingHour: 0, hasNoHours: false)

var daysOfTheWeek = [Day]()

func setHours() {
    if restaurantChoice == "Dining Hall" { // Need to add transition closed hours
        setupDay(day: Sunday, open: 8, close: 19.5)
        setupDay(day: Monday, open: 6.5, close: 19.5)
        setupDay(day: Tuesday, open: 6.5, close: 19.5)
        setupDay(day: Wednesday, open: 6.5, close: 19.5)
        setupDay(day: Thursday, open: 6.5, close: 19.5)
        setupDay(day: Friday, open: 6.5, close: 19.5)
        setupDay(day: Saturday, open: 8, close: 19.5)
    } else if restaurantChoice == "Coffeehouse" {
        setupDay(day: Sunday, open: 18, close: 0)
        setupDay(day: Monday, open: 6.5, close: 1)
        setupDay(day: Tuesday, open: 6.5, close: 1)
        setupDay(day: Wednesday, open: 6.5, close: 1)
        setupDay(day: Thursday, open: 6.5, close: 1)
        setupDay(day: Friday, open: 6.5, close: 17)
        setupDay(day: Saturday, open: 10, close: 16)
    } else if restaurantChoice == "The Den" {
        // Hours unavailable
        setupDay(day: Sunday, open: 17, close: 0)
        setupDay(day: Monday, open: 8, close: 0)
        setupDay(day: Tuesday, open: 8, close: 0)
        setupDay(day: Wednesday, open: 8, close: 0)
        setupDay(day: Thursday, open: 8, close: 0)
        setupDay(day: Friday, open: 8, close: 19)
        setupDay(day: Saturday, open: 11, close: 19)
    } else if restaurantChoice == "Cougar BBQ" {
        /*
         *
         * Hours unavailable
         *
         */
    } else if restaurantChoice == "Cali Grill" {
        setupDay(day: Sunday, open: 17, close: 0)
        setupDay(day: Monday, open: 8, close: 0)
        setupDay(day: Tuesday, open: 8, close: 0)
        setupDay(day: Wednesday, open: 8, close: 0)
        setupDay(day: Thursday, open: 8, close: 0)
        setupDay(day: Friday, open: 8, close: 19)
        setupDay(day: Saturday, open: 11, close: 19)
    } else if restaurantChoice == "Pause 'n Go" {
        setupDay(day: Sunday, open: 16, close: 24)
        setupDay(day: Monday, open: 7.5, close: 1)
        setupDay(day: Tuesday, open: 7.5, close: 1)
        setupDay(day: Wednesday, open: 7.5, close: 1)
        setupDay(day: Thursday, open: 7.5, close: 1)
        setupDay(day: Friday, open: 7.5, close: 1)
        setupDay(day: Saturday, open: 12, close: 19)
    } else if restaurantChoice == "Fusion Grill" {  // Need to add transition closed hours
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 7, close: 20)
        setupDay(day: Tuesday, open: 7, close: 20)
        setupDay(day: Wednesday, open: 7, close: 20)
        setupDay(day: Thursday, open: 7, close: 20)
        setupDay(day: Friday, open: 7, close: 16)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "Fresh Grounds" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 6.5, close: 20)
        setupDay(day: Tuesday, open: 6.5, close: 20)
        setupDay(day: Wednesday, open: 6.5, close: 20)
        setupDay(day: Thursday, open: 6.5, close: 20)
        setupDay(day: Friday, open: 6.5, close: 16)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "West Market" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 7, close: 20)
        setupDay(day: Tuesday, open: 7, close: 20)
        setupDay(day: Wednesday, open: 7, close: 20)
        setupDay(day: Thursday, open: 7, close: 20)
        setupDay(day: Friday, open: 7, close: 16)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "Tam's Subs" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 9, close: 20)
        setupDay(day: Tuesday, open: 9, close: 20)
        setupDay(day: Wednesday, open: 9, close: 20)
        setupDay(day: Thursday, open: 9, close: 20)
        setupDay(day: Friday, open: 9, close: 16)
        setupDay(day: Saturday, open: 10, close: 15)
    } else if restaurantChoice == "Tasti Sushi" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 11, close: 20)
        setupDay(day: Tuesday, open: 11, close: 20)
        setupDay(day: Wednesday, open: 11, close: 20)
        setupDay(day: Thursday, open: 11, close: 20)
        setupDay(day: Friday, open: 11, close: 15)
        setupDay(day: Saturday, open: 0, close: 0)
    }
    
    daysOfTheWeek = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
    
    for day in daysOfTheWeek {
        if day.openHour == 0 && day.closeHour == 0 {
            day.hasNoHours = true
        }
    }
}

func setupDay(day: Day, open: Double, close: Double) {
    day.openHour = open
    day.closeHour = close
}

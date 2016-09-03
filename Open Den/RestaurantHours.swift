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
var ZeroDay: Day = Day(openingHour: 0, closingHour: 0)

func setHours() {
    if restaurantChoice == "Dining Hall" {
        Sunday.openHour = 8.0; Sunday.closeHour = 19.5;
        Monday.openHour = 6.5; Monday.closeHour = 19.5
        Tuesday.openHour = 6.5; Tuesday.closeHour = 19.5
        Wednesday.openHour = 6.5; Wednesday.closeHour = 19.5
        Thursday.openHour = 6.5; Thursday.closeHour = 19.5
        Friday.openHour = 6.5; Friday.closeHour = 19.5
        Saturday.openHour = 8.0; Saturday.closeHour = 19.5
    } else if restaurantChoice == "Coffeehouse" {
        Sunday.openHour = 18; Sunday.closeHour = 24.0
        Monday.openHour = 6.5; Monday.closeHour = 1.0
        Tuesday.openHour = 6.5; Tuesday.closeHour = 1.0
        Wednesday.openHour = 6.5; Wednesday.closeHour = 1.0
        Thursday.openHour = 6.5; Thursday.closeHour = 1.0
        Friday.openHour = 6.5; Friday.closeHour = 17.0
        Saturday.openHour = 10; Saturday.closeHour = 16.0
    } else if restaurantChoice == "The Den" {
        Sunday.openHour = 17; Sunday.closeHour = 24
        Monday.openHour = 11; Monday.closeHour = 24
        Tuesday.openHour = 11; Tuesday.closeHour = 24
        Wednesday.openHour = 11; Wednesday.closeHour = 24
        Thursday.openHour = 11; Thursday.closeHour = 24
        Friday.openHour = 11; Friday.closeHour = 19
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "Cougar BBQ" {  // Hours unavailable
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 0; Monday.closeHour = 0
        Tuesday.openHour = 0; Tuesday.closeHour = 0
        Wednesday.openHour = 0; Wednesday.closeHour = 0
        Thursday.openHour = 0; Thursday.closeHour = 0
        Friday.openHour = 0; Friday.closeHour = 0
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "Cali Grill" {
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 8; Monday.closeHour = 20
        Tuesday.openHour = 8; Tuesday.closeHour = 20
        Wednesday.openHour = 8; Wednesday.closeHour = 20
        Thursday.openHour = 8; Thursday.closeHour = 20
        Friday.openHour = 8; Friday.closeHour = 19
        Saturday.openHour = 11; Saturday.closeHour = 19
    } else if restaurantChoice == "Pause 'n Go" {
        Sunday.openHour = 16.0; Sunday.closeHour = 24.0
        Monday.openHour = 7.5; Monday.closeHour = 1.0
        Tuesday.openHour = 7.5; Tuesday.closeHour = 1.0
        Wednesday.openHour = 7.5; Wednesday.closeHour = 1.0
        Thursday.openHour = 7.5; Thursday.closeHour = 1.0
        Friday.openHour = 7.5; Friday.closeHour = 19.0
        Saturday.openHour = 12.0; Saturday.closeHour = 19.0
    } else if restaurantChoice == "Fusion Grill" {  // Need to add transition closed hours
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 7.0; Monday.closeHour = 20.0
        Tuesday.openHour = 7.0; Tuesday.closeHour = 20.0
        Wednesday.openHour = 7.0; Wednesday.closeHour = 20.0
        Thursday.openHour = 7.0; Thursday.closeHour = 20.0
        Friday.openHour = 7.0; Friday.closeHour = 15.0
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "Fresh Grounds" {
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 6.5; Monday.closeHour = 20.0
        Tuesday.openHour = 6.5; Tuesday.closeHour = 20.0
        Wednesday.openHour = 6.5; Wednesday.closeHour = 20.0
        Thursday.openHour = 6.5; Thursday.closeHour = 20.0
        Friday.openHour = 6.5; Friday.closeHour = 16.0
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "West Market" {
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 7.0; Monday.closeHour = 20.0
        Tuesday.openHour = 7.0; Tuesday.closeHour = 20.0
        Wednesday.openHour = 7.0; Wednesday.closeHour = 20.0
        Thursday.openHour = 7.0; Thursday.closeHour = 20.0
        Friday.openHour = 7.0; Friday.closeHour = 16.0
        Saturday.openHour = 0; Saturday.closeHour = 0
    } else if restaurantChoice == "Tam's Subs" {
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 9.0; Monday.closeHour = 20.0
        Tuesday.openHour = 9.0; Tuesday.closeHour = 20.0
        Wednesday.openHour = 9.0; Wednesday.closeHour = 20.0
        Thursday.openHour = 9.0; Thursday.closeHour = 20.0
        Friday.openHour = 9.0; Friday.closeHour = 16.0
        Saturday.openHour = 10.0; Saturday.closeHour = 15.0
    } else if restaurantChoice == "Tasti Sushi" {
        Sunday.openHour = 0; Sunday.closeHour = 0
        Monday.openHour = 11.0; Monday.closeHour = 20.0
        Tuesday.openHour = 11.0; Tuesday.closeHour = 20.0
        Wednesday.openHour = 11.0; Wednesday.closeHour = 20.0
        Thursday.openHour = 11.0; Thursday.closeHour = 20.0
        Friday.openHour = 11.0; Friday.closeHour = 15.0
        Saturday.openHour = 0; Saturday.closeHour = 0
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

//
//  Day.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import Foundation

class Day {
    // Base variables
    private var _openHour: Double = 24
    private var _closeHour: Double = 24
    
    // Getters
    var openHour: Double {
        get {
            return _openHour
        }
        set(value) {
            _openHour = value
        }
    }
    var closeHour: Double {
        get {
            return _closeHour
        }
        set(value) {
            _closeHour = value
        }
    }
    
    // Initializer
    init(openingHour: Double, closingHour: Double) {
        self._openHour = openingHour
        self._closeHour = closingHour
    }
}


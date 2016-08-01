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
    private var _openHour: Int = 24
    private var _closeHour: Int = 24
    
    // Getters
    var openHour: Int {
        get {
            return _openHour
        }
        set(value) {
            _openHour = value
        }
    }
    var closeHour: Int {
        get {
            return _closeHour
        }
        set(value) {
            _closeHour = value
        }
    }
    
    // Initializer
    init(openingHour: Int, closingHour: Int) {
        self._openHour = openingHour
        self._closeHour = closingHour
    }
}


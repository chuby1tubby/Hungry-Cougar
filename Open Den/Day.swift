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
    fileprivate var _openHour: Double = 0
    fileprivate var _closeHour: Double = 0
    fileprivate var _hasNoHours: Bool = false
    
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
    var hasNoHours: Bool {
        get {
            return _hasNoHours
        }
        set(value) {
            _hasNoHours = value
        }
    }
    
    // Initializer
    init(openingHour: Double, closingHour: Double, hasNoHours: Bool) {
        self._openHour = openingHour
        self._closeHour = closingHour
        self._hasNoHours = hasNoHours
    }
}


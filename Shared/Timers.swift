//
//  Timers.swift
//  Nag
//
//  Created by Ohad Ravid on 12/04/2018.
//  Copyright © 2018 Ravid Ventures. All rights reserved.
//

import Foundation

class NGTimer: NSObject {
    var title: String
    var duration: TimeInterval
    
    init(title: String, duration: TimeInterval) {
        self.title = title
        self.duration = duration
    }
    
    static func allTimers() -> [NGTimer] {
        return [
            NGTimer(title: "Green Tea", duration: TimeInterval(3 * 1)),
            NGTimer(title: "Black Tea", duration: TimeInterval(5 * 1)),
        ]
    }
}

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
    var time: Int32
    
    init(title: String, time: Int32) {
        self.title = title
        self.time = time
    }
    
    static func allTimers() -> [NGTimer] {
        return [NGTimer(title: "Black Tea", time: 3), NGTimer(title: "Green Tea", time: 5)]
    }
}

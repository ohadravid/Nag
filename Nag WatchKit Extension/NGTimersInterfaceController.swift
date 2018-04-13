//
//  NGTimersInterfaceController.swift
//  Nag WatchKit Extension
//
//  Created by Ohad Ravid on 13/04/2018.
//  Copyright © 2018 Ravid Ventures. All rights reserved.
//

import WatchKit
import Foundation



class NGTimersInterfaceController: WKInterfaceController {
    @IBOutlet var customTimerButton: WKInterfaceButton!
    @IBOutlet var timersTable: WKInterfaceTable!
    
    var timers = NGTimer.allTimers()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        timersTable.setNumberOfRows(timers.count, withRowType: "TimerRow")
        for index in 0..<timersTable.numberOfRows {
            guard let controller = timersTable.rowController(at: index) as? NGTimerRowController else { continue }
            
            controller.timer = timers[index]
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let timer = timers[rowIndex]
        presentController(withName: "SingleTimer", context: timer)
    }
}

//
//  NGSingleTimerInterfaceController.swift
//  Nag WatchKit Extension
//
//  Created by Ohad Ravid on 13/04/2018.
//  Copyright © 2018 Ravid Ventures. All rights reserved.
//

import WatchKit
import Foundation


class NGSingleTimerInterfaceController: WKInterfaceController {
    @IBOutlet var timerName: WKInterfaceLabel!
    @IBOutlet var timerTimeRemaining: WKInterfaceTimer!
    
    var duration: TimeInterval = 0
    
    var timer: NGTimer? {
        didSet {
            guard let timer = timer else { return }
            
            timerName.setText(timer.title)
            
            duration = TimeInterval(timer.time)
            
            timerTimeRemaining.setDate(Date(timeIntervalSinceNow: duration ))
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if let timer = context as? NGTimer {
            self.timer = timer
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

}

//
//  NGSingleTimerInterfaceController.swift
//  Nag WatchKit Extension
//
//  Created by Ohad Ravid on 13/04/2018.
//  Copyright © 2018 Ravid Ventures. All rights reserved.
//

import WatchKit
import Foundation
import SwiftDate

extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else {
            return "\(seconds)s"
        }
    }
}

class NGSingleTimerInterfaceController: WKInterfaceController {
    @IBOutlet var timerName: WKInterfaceLabel!
    @IBOutlet var timerTimeRemaining: WKInterfaceLabel!
    @IBOutlet var timerButton: WKInterfaceButton!
    @IBOutlet var timerButtonBackground: WKInterfaceGroup!

    var timer: NGTimer? {
        didSet {
            guard let timer = timer else { return }
            
            timerName.setText(timer.title)

            let diff = timer.duration.in([.minute,.second])
            timerTimeRemaining.setText("\( diff[.minute] ?? 0)m \(diff[.second] ?? 0)s")
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

    func buttonClicked() {
        pauseResumePressed()
    }
    
    var internalTimer : Timer?  //internal timer to keep track
    var isPaused = true //flag to determine if it is paused or not
    var elapsedTime : TimeInterval = 0.0 //time that has passed between pause/resume
    var startTime = DateInRegion()
    
    let RUNNING_COLOR = UIColor(red:0.00, green:0.72, blue:1.00, alpha:1.0)
    let PAUSED_COLOR = UIColor(red:0.58, green:0.65, blue:0.65, alpha:1.0)
    let OVERTIME_COLOR = UIColor(red:1.00, green:0.68, blue:0.00, alpha:1.0)
    
    @IBAction func pauseResumePressed() {
        guard let timer = timer else { return }
        
        // timer is paused. so unpause it and resume countdown
        if isPaused {
            isPaused = false
            internalTimer = Timer.scheduledTimer(
                timeInterval: 0.1,
                target: self,
                selector: #selector(NGSingleTimerInterfaceController.timerTick),
                userInfo: nil,
                repeats: true
            )
            
            startTime = DateInRegion()
            
            updateTimerText()
            timerButtonBackground.setBackgroundColor(RUNNING_COLOR)
        } else {
            isPaused = true
            
            // Get how much time has passed before they paused it.
            let paused = DateInRegion()
            elapsedTime = paused - startTime

            // Stop the the internal timer.
            internalTimer!.invalidate()
            
            timerButtonBackground.setBackgroundColor(PAUSED_COLOR)
        }
    }
    
    func updateTimerText() {
        guard let timer = timer else { return }
        elapsedTime = DateInRegion() - startTime
        
        let diff = (timer.duration - elapsedTime).in([.minute,.second])
        
        if ((diff[.minute] ?? 0) < 0) || (diff[.second] ?? 0) < 0 {
            timerButtonBackground.setBackgroundColor(OVERTIME_COLOR)
            timerTimeRemaining.setText("-\(abs(diff[.minute] ?? 0))m \(abs(diff[.second] ?? 0))s")
        } else {
            timerTimeRemaining.setText("\( diff[.minute] ?? 0)m \(diff[.second] ?? 0)s")
        }
    }
    
    @objc func timerTick(){
        updateTimerText()
    }
}

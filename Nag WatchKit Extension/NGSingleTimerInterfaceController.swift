//
//  NGSingleTimerInterfaceController.swift
//  Nag WatchKit Extension
//
//  Created by Ohad Ravid on 13/04/2018.
//  Copyright © 2018 Ravid Ventures. All rights reserved.
//

import WatchKit
import Foundation

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
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}

class NGSingleTimerInterfaceController: WKInterfaceController {
    @IBOutlet var timerName: WKInterfaceLabel!
    @IBOutlet var timerTimeRemaining: WKInterfaceLabel!
    @IBOutlet var timerButton: WKInterfaceButton!

    var timer: NGTimer? {
        didSet {
            guard let timer = timer else { return }
            
            timerName.setText(timer.title)
            timerTimeRemaining.setText(timer.duration.stringTime)
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
    var startTime = Date()
    
    @IBAction func pauseResumePressed() {
        guard let timer = timer else { return }
        
        // timer is paused. so unpause it and resume countdown
        if isPaused {
            isPaused = false
            internalTimer = Timer.scheduledTimer(
                timeInterval: timer.duration - elapsedTime,
                target: self,
                selector: #selector(NGSingleTimerInterfaceController.timerDone),
                userInfo: nil, repeats: false
            )

            timerTimeRemaining.setText("Running!")
            
            startTime = Date()
        } else {
            isPaused = true
            
            // Get how much time has passed before they paused it.
            let paused = Date()
            elapsedTime += paused.timeIntervalSince(startTime)

            // Stop the the internal timer.
            internalTimer!.invalidate()
            
            timerTimeRemaining.setText("Paused!")
        }
    }
    
    @objc func timerDone(){
        // Timer done counting down.
    }
}

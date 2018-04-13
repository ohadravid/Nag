//
//  NGTimerRowController.swift
//  Nag WatchKit Extension
//
//  Created by Ohad Ravid on 13/04/2018.
//  Copyright © 2018 Ravid Ventures. All rights reserved.
//

import WatchKit

class NGTimerRowController: NSObject {
    @IBOutlet var button: WKInterfaceButton!
    
    var timer: NGTimer? {
        didSet {
            guard let timer = timer else { return }

            button.setTitle(timer.title)
        }
    }
}

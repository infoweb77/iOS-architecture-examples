//
//  Throttle.swift
//  MVC
//
//  Created by alex on 17/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

class Throttle {
    private var workItem = DispatchWorkItem(block: {})
    private var previousRun = Date.distantPast
    private let queue: DispatchQueue
    private let delay: TimeInterval
    
    init(minimumDelay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.queue = queue
        delay = minimumDelay
    }
    
    func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()
        
        workItem = DispatchWorkItem() { [weak self] in
            self?.previousRun = Date()
            block()
        }
        
        let deltaDelay = previousRun.timeIntervalSinceNow > delay ? 0 : delay
        queue.asyncAfter(deadline: .now() + Double(deltaDelay), execute: workItem)
    }
}

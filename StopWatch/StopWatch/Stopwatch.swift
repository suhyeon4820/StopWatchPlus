//
//  Stopwatch.swift
//  StopWatch
//
//  Created by suhyeon on 2021/01/28.
//

import Foundation

class Stopwatch {
    
    var timer: Timer
    var count: Int
    
    init() {
        self.timer = Timer()
        self.count = 0
    }
}

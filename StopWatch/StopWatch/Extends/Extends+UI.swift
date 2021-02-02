//
//  Extends+UI.swift
//  StopWatch
//
//  Created by suhyeon on 2021/01/29.
//

import Foundation
import UIKit
import Lottie

extension UIButton {

    func applyStartButtonDesign() {
        self.setTitle("Start", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.7764705882, blue: 0.6862745098, alpha: 1)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    func applyPauseButtonDesign() {
        self.setTitle("Pause", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.9843137255, blue: 0.7843137255, alpha: 1)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }

    func applyLapButtonDesign() {
        self.setTitle("Lap", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.backgroundColor = .systemPink
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5

    }

    func applyResetButtonDesign() {
        self.setTitle("Reset", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.backgroundColor = #colorLiteral(red: 0.6274509804, green: 0.8705882353, blue: 0.8745098039, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}


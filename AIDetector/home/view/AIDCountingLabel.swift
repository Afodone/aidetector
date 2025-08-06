//
//  CountingLabel.swift
//  AIDetector
//
//  Created by yong on 2025/8/4.
//
import UIKit

class AIDCountingLabel: UILabel {
    
    private var displayLink: CADisplayLink?
    private var startValue: Double = 0
    private var endValue: Double = 0
    private var animationDuration: Double = 2.0
    private var animationStartDate = Date()
    private var numberFormatter: NumberFormatter?
    
    func count(from startValue: Double, to endValue: Double, duration: Double = 2.0) {
        self.startValue = startValue
        self.endValue = endValue
        self.animationDuration = duration
        self.animationStartDate = Date()

        displayLink?.invalidate()
        

        self.text = formatNumber(startValue)
        
        displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func setNumberFormatter(_ formatter: NumberFormatter) {
        self.numberFormatter = formatter
    }
    
    @objc private func handleDisplayLink() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {

            displayLink?.invalidate()
            displayLink = nil
            text = formatNumber(endValue)
        } else {
          
            let percentage = elapsedTime / animationDuration
            let currentValue = startValue + percentage * (endValue - startValue)
            text = formatNumber(currentValue)
        }
    }
    
    private func formatNumber(_ number: Double) -> String {
        if let formatter = numberFormatter {
            return formatter.string(from: NSNumber(value: number)) ?? ""
        }
        
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(number))% AI"
        } else {
            return String(format: "%.0f%% AI", number)
        }
    }
}

//
//  CountdownView.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate {
    func countdownReached(forCell cell: TimerTableViewCell?)
    func updateCountdownTimer(forCell cell: TimerTableViewCell?, withTimerValue seconds: Int)
}

class CountdownView: UIView {
    
    private var shapeLayer = CAShapeLayer()
    private var timerValue = TimerConstants.TimerDuration
    private var label = UILabel()
    var countdownTimer = Timer()
    
    var delegate: CountdownViewDelegate?
    weak var tableCell: TimerTableViewCell?
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.createLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createLabel()
        
    }
    
    private func createLabel() {
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        self.label.font = UIFont(name: self.label.font.fontName, size: 15)
        self.label.textColor = UIColor.red
        self.label.textAlignment = .center
        
        self.addSubview(self.label)
    }
    
    private func updateLabel(value: Int) {
        self.setLabelText(value: value)
        self.shapeLayer.removeFromSuperlayer()
        self.drawCircle()
    }
    
    private func drawCircle() {
        let angleAlreadyCovered = Double.pi * 2 * Double(TimerConstants.TimerDuration - timerValue)/Double(TimerConstants.TimerDuration)
        if angleAlreadyCovered != 0 {
            addCircle(startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(-Double.pi/2 + angleAlreadyCovered))
        }
        addCircle(startAngle: CGFloat(-Double.pi/2 + angleAlreadyCovered), endAngle: CGFloat(2*Double.pi-Double.pi/2))
    }
    
    private func addCircle(startAngle: CGFloat, endAngle: CGFloat) {
        
        shapeLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 30, y: 30), radius: 20, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        self.shapeLayer.path = circlePath.cgPath
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.red.cgColor
        self.shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(self.shapeLayer)
    }
    
    private func setLabelText(value: Int) {
        self.label.text = String(describing: value)
    }
    
    func setTimer(value: Int) {
        self.timerValue = value
        self.updateLabel(value: value)
    }
    
    func startClockTimer() {
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CountdownView.countdown), userInfo: nil, repeats: true)
        self.startAnimation()
    }
    
    @objc private func countdown() {
        self.timerValue -= 1
        if self.timerValue < 0 {
            self.countdownTimer.invalidate()
            self.delegate?.countdownReached(forCell: tableCell)
        }
        else {
            self.setLabelText(value: self.timerValue)
            self.delegate?.updateCountdownTimer(forCell: tableCell, withTimerValue: self.timerValue)
        }
    }
    
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(self.timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = true
        self.shapeLayer.add(animation, forKey: "ani")
    }
}

//
//  Pulsing.swift
//  TicTacToe
//
//  Created by David T Judd on 4/2/17.
//  Copyright © 2017 Tracer Tech. All rights reserved.
//

import UIKit

class Pulsing: CALayer {

    var animationGroup = CAAnimationGroup()
    
    var InitialPulseScale:Float = 0
    var nextPulseAfter:TimeInterval = 0
    var andimationDuration:TimeInterval = 1.5
    var radius:CGFloat = 200
    var numberOfPulses:Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(numberOfPulses:Float = Float.infinity, radius:CGFloat, position:CGPoint) {
        super.init()
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimaitonGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func createScaleAnimation () -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.ey")
        scaleAnimation.fromValue = NSNumber(value: InitialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = andimationDuration
        
        return scaleAnimation
    }
    
    func CreateOpacityAnimation () -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = andimationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0.0, 0.2, 1]
        
        return opacityAnimation
    }
    
    func setupAnimaitonGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = andimationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [createScaleAnimation(), CreateOpacityAnimation()]
        
    }
    
}

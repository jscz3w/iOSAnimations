//
//  FlyAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/29.
//

import UIKit

class FlyAnimation: CALayer {
    var layers = [String: CALayer]()
    var bezierPath = UIBezierPath()
    var plainLayer = CALayer()
    func setupLayers(){
       
                
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        self.addSublayer(pathLayer)
        plainLayer.frame = CGRect(x: 0, y: 0, width: 530, height: 530)
        plainLayer.position = CGPoint(x: 30, y: self.frame.height)
        plainLayer.contents = UIImage(named: "balloon")?.cgImage
        plainLayer.opacity = 0
        self.addSublayer(plainLayer)
        
    }
    
    //MARK: - Animation Setup
    
    func addAnimation(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.timeOffset = CFTimeInterval(0.1)
        animation.speed = 0.5
        animation.duration = 3.0
        animation.path = linePath().cgPath
        animation.rotationMode = CAAnimationRotationMode.rotateAuto
        animation.isRemovedOnCompletion = false
        animation.beginTime = 1
        self.add(animation, forKey: nil)
        
        let fadeInAnimation = CABasicAnimation.init(keyPath: "opacity")
        fadeInAnimation.duration = 0.2 // aLayer.endTime - aLayer.beginTime
        fadeInAnimation.fromValue = NSNumber(value: 0)
        fadeInAnimation.toValue = NSNumber(value: 1)
        fadeInAnimation.isRemovedOnCompletion = false
        fadeInAnimation.beginTime =  1.05
        fadeInAnimation.fillMode = CAMediaTimingFillMode.forwards
        plainLayer.add(fadeInAnimation, forKey: "opacityIN")
         
    }
    func linePath() ->UIBezierPath {
        let linePathPath = UIBezierPath()
        
        linePathPath.move(to: CGPoint(x: 30, y: self.frame.height))
                //计算上下两个点
        let point1: CGPoint = CGPoint(x: (self.frame.width-60)/4.0, y: 0)
        let point2: CGPoint = CGPoint(x: (self.frame.width-60)*3/4.0, y: 300)
        linePathPath.addCurve(to: CGPoint(x: self.frame.width-30, y: self.frame.height), controlPoint1: point1, controlPoint2: point2)
        return linePathPath
    }

}

//
//  FillAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/16.
//

import UIKit

class FillAnimation: CALayer, CAAnimationDelegate {
    
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = false
    
    var cloudColor : UIColor?
    var lineColor : UIColor!
 
    var aFrame:CGRect!
    
    
    func setupProperties(){
        if let color = cloudColor {
            self.cloudColor = color
        }else{
            self.cloudColor = UIColor(red: 1.000, green: 0.580, blue: 0.804, alpha: 0.400)
        }
       // self.cloudColor = UIColor(red: 1.000, green: 0.580, blue: 0.804, alpha: 1.000)   // UIColor(red:0.435, green: 0.796, blue:0.945, alpha:1)
        self.lineColor =  UIColor.white
    }
    
    func setupLayers(frame:CGRect){

        
        let cloud4 = CAShapeLayer()
        cloud4.frame       = frame
        cloud4.lineJoin    = .round
        cloud4.fillColor   = nil
        cloud4.strokeColor = self.cloudColor?.cgColor
        cloud4.lineWidth   = 70
        cloud4.strokeEnd   = 0
        cloud4.path        = pathColor().cgPath
        self.addSublayer(cloud4)
        layers["cloud4"] = cloud4
    }
    
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 5
            completionAnim.delegate = self
            completionAnim.setValue("old", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            self.add(completionAnim, forKey:"old")
            if let anim = self.animation(forKey: "old"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : CAMediaTimingFillMode = .forwards
        

        
        ////Cloud4 animation
        let cloud4StrokeEndAnim            = CABasicAnimation(keyPath:"strokeEnd")
        cloud4StrokeEndAnim.fromValue      = 0;
        cloud4StrokeEndAnim.toValue        = 1;
        cloud4StrokeEndAnim.duration       = 1.8
        cloud4StrokeEndAnim.timingFunction = CAMediaTimingFunction(name:.easeIn)
        
//        let cloud4FillColorAnim            = CABasicAnimation(keyPath:"fillColor")
//        cloud4FillColorAnim.fromValue      = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:0.0).cgColor;
//        cloud4FillColorAnim.toValue        = self.cloudColor?.cgColor;
//        cloud4FillColorAnim.duration       = 2
//        cloud4FillColorAnim.beginTime      = 1.24
//        cloud4FillColorAnim.timingFunction = CAMediaTimingFunction(name:.default)
//
//        let cloud4ShadowColorAnim              = CAKeyframeAnimation(keyPath:"shadowColor")
//        cloud4ShadowColorAnim.values           = [UIColor.black.cgColor,
//            UIColor.black.cgColor,
//            UIColor(red:0.526, green: 0.526, blue:0.526, alpha:1).cgColor]
//        cloud4ShadowColorAnim.duration         = 1.62
//        cloud4ShadowColorAnim.beginTime        = 2.8
//        cloud4ShadowColorAnim.timingFunction   = CAMediaTimingFunction(name:.easeOut)
//        let cloud4ShadowOpacityAnim            = CAKeyframeAnimation(keyPath:"shadowOpacity")
//        cloud4ShadowOpacityAnim.values         = [0.216, 0.34, 0.601]
//        cloud4ShadowOpacityAnim.duration       = 1.62
//        cloud4ShadowOpacityAnim.beginTime      = 2.8
//        cloud4ShadowOpacityAnim.timingFunction = CAMediaTimingFunction(name:.easeOut)
//        let cloud4ShadowOffsetAnim             = CAKeyframeAnimation(keyPath:"shadowOffset")
//        cloud4ShadowOffsetAnim.values          = [NSValue(cgSize: CGSize(width: 0, height: 3)),
//            NSValue(cgSize: CGSize(width: 0, height: 10)),
//            NSValue(cgSize: CGSize(width: 8, height: 12))]
//        cloud4ShadowOffsetAnim.duration        = 1.62
//        cloud4ShadowOffsetAnim.beginTime       = 2.8
//        cloud4ShadowOffsetAnim.timingFunction  = CAMediaTimingFunction(name:.easeOut)
        
        
        let cloud4OldAnim : CAAnimationGroup = QCMethod.group(animations: [cloud4StrokeEndAnim], fillMode:fillMode)
//        let cloud4OldAnim : CAAnimationGroup = QCMethod.group(animations: [cloud4StrokeEndAnim, cloud4FillColorAnim, cloud4ShadowColorAnim, cloud4ShadowOpacityAnim, cloud4ShadowOffsetAnim], fillMode:fillMode)
        //cloud4OldAnim.beginTime = 1.0
        layers["cloud4"]?.add(cloud4OldAnim, forKey:"cloud4OldAnim")
 
        self.addSublayer(layers["cloud4"]!)
    }
    
    
    func addOldAnimation(aLayer:CALayer,completionBlock: ((_ finished: Bool) -> Void)? = nil){
         
        
        let fillMode : CAMediaTimingFillMode = .forwards
        

        
        ////Cloud4 animation
        let cloud4StrokeEndAnim            = CABasicAnimation(keyPath:"strokeEnd")
        cloud4StrokeEndAnim.fromValue      = 0;
        cloud4StrokeEndAnim.toValue        = 1;
        cloud4StrokeEndAnim.duration       = 1.8
        cloud4StrokeEndAnim.timingFunction = CAMediaTimingFunction(name:.easeIn)
        
        let cloud4FillColorAnim            = CABasicAnimation(keyPath:"fillColor")
        cloud4FillColorAnim.fromValue      = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:0.0).cgColor;
        cloud4FillColorAnim.toValue        =  UIColor.clear.cgColor   //self.cloudColor.cgColor;
        cloud4FillColorAnim.duration       = 2
        cloud4FillColorAnim.beginTime      = 1.24
        cloud4FillColorAnim.timingFunction = CAMediaTimingFunction(name:.default)
        
        let cloud4ShadowColorAnim              = CAKeyframeAnimation(keyPath:"shadowColor")
        cloud4ShadowColorAnim.values           = [UIColor.black.cgColor,
            UIColor.black.cgColor,
            UIColor(red:0.526, green: 0.526, blue:0.526, alpha:1).cgColor]
        cloud4ShadowColorAnim.duration         = 1.62
        cloud4ShadowColorAnim.beginTime        = 2.8
        cloud4ShadowColorAnim.timingFunction   = CAMediaTimingFunction(name:.easeOut)
        let cloud4ShadowOpacityAnim            = CAKeyframeAnimation(keyPath:"shadowOpacity")
        cloud4ShadowOpacityAnim.values         = [0.216, 0.34, 0.601]
        cloud4ShadowOpacityAnim.duration       = 1.62
        cloud4ShadowOpacityAnim.beginTime      = 2.8
        cloud4ShadowOpacityAnim.timingFunction = CAMediaTimingFunction(name:.easeOut)
        let cloud4ShadowOffsetAnim             = CAKeyframeAnimation(keyPath:"shadowOffset")
        cloud4ShadowOffsetAnim.values          = [NSValue(cgSize: CGSize(width: 0, height: 3)),
            NSValue(cgSize: CGSize(width: 0, height: 10)),
            NSValue(cgSize: CGSize(width: 8, height: 12))]
        cloud4ShadowOffsetAnim.duration        = 1.62
        cloud4ShadowOffsetAnim.beginTime       = 2.8
        cloud4ShadowOffsetAnim.timingFunction  = CAMediaTimingFunction(name:.easeOut)
        
       
        
        let cloud4OldAnim : CAAnimationGroup = QCMethod.group(animations: [cloud4StrokeEndAnim, cloud4FillColorAnim, cloud4ShadowColorAnim, cloud4ShadowOpacityAnim, cloud4ShadowOffsetAnim], fillMode:fillMode)
        //cloud4OldAnim.beginTime = 1.0
        //layers["cloud4"]?.add(cloud4OldAnim, forKey:"cloud4OldAnim")
 
        aLayer.add(cloud4OldAnim, forKey:"cloud4OldAnim")
    }
    
    
    //MARK: - Animation Cleanup
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValue(forKey: anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
                updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
                removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValues(forAnimationId identifier: String){
        if identifier == "old"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["cloud"]!.animation(forKey: "cloudOldAnim"), theLayer:layers["cloud"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["cloud2"]!.animation(forKey: "cloud2OldAnim"), theLayer:layers["cloud2"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["cloud3"]!.animation(forKey: "cloud3OldAnim"), theLayer:layers["cloud3"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["cloud4"]!.animation(forKey: "cloud4OldAnim"), theLayer:layers["cloud4"]!)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "old"{
            layers["cloud"]?.removeAnimation(forKey: "cloudOldAnim")
            layers["cloud2"]?.removeAnimation(forKey: "cloud2OldAnim")
            layers["cloud3"]?.removeAnimation(forKey: "cloud3OldAnim")
            layers["cloud4"]?.removeAnimation(forKey: "cloud4OldAnim")
        }
    }
    
//    func removeAllAnimations(){
//        for layer in layers.values{
//            layer.removeAllAnimations()
//        }
//    }
    
    //MARK: - Bezier Path
    
    func cloudPath2() -> UIBezierPath{
        
        return  UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: aFrame.width, height: aFrame.height))
    }
    
    func cloudPath() -> UIBezierPath{
        
        return UIBezierPath(rect: CGRect(x: 0, y: 0, width: aFrame.width, height: aFrame.height))
    }
    
    func pathColor()-> UIBezierPath{
        let gradientColor = UIColor(red: 0.224, green: 0.877, blue: 0.356, alpha: 1.000)
        
        let path13Path = UIBezierPath()
        path13Path.move(to: CGPoint(x: 0, y: 53.53))
        path13Path.addCurve(to: CGPoint(x: 77.55, y: 27.4), controlPoint1: CGPoint(x: 26.47, y: 14.43), controlPoint2: CGPoint(x: 52.32, y: 5.72))
        path13Path.addCurve(to: CGPoint(x: 181.36, y: 10.2), controlPoint1: CGPoint(x: 102.78, y: 49.08), controlPoint2: CGPoint(x: 137.38, y: 43.35))
        path13Path.addCurve(to: CGPoint(x: 262, y: 66), controlPoint1: CGPoint(x: 215.68, y: -13.9), controlPoint2: CGPoint(x: 242.56, y: 4.7))
        gradientColor.setStroke()
        path13Path.lineWidth = 9
        path13Path.miterLimit = 4
        path13Path.lineCapStyle = .round
        path13Path.lineJoinStyle = .bevel
        path13Path.stroke()

      
   
//        let path13Path = UIBezierPath()
//        path13Path.move(to: CGPoint(x: 18.5, y: 84.03))
//        path13Path.addCurve(to: CGPoint(x: 96.05, y: 57.9), controlPoint1: CGPoint(x: 44.97, y: 44.93), controlPoint2: CGPoint(x: 70.82, y: 36.22))
//        path13Path.addCurve(to: CGPoint(x: 199.86, y: 40.7), controlPoint1: CGPoint(x: 121.28, y: 79.58), controlPoint2: CGPoint(x: 155.88, y: 73.85))
//        path13Path.addCurve(to: CGPoint(x: 280.5, y: 96.5), controlPoint1: CGPoint(x: 234.18, y: 16.6), controlPoint2: CGPoint(x: 261.06, y: 35.2))
//
        
        return path13Path
        
    }
    
    
    
}


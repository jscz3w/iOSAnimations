//
//  CloudAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/11.
//


import UIKit


class CloudAnimation: CALayer, CAAnimationDelegate {
    
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = false
    
    var cloudColor : UIColor!
    var lineColor : UIColor!
    
    //MARK: - Life Cycle
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupProperties()
//        setupLayers()
//    }
//
//    required init?(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)
//        setupProperties()
//        setupLayers()
//    }
    
    
    
    func setupProperties(){
        self.cloudColor = UIColor(red: 1.000, green: 0.314, blue: 0.945, alpha: 1.000)   // UIColor(red:0.435, green: 0.796, blue:0.945, alpha:1)
        self.lineColor =  UIColor(red: 1.000, green: 0.835, blue: 0.306, alpha: 1.000)
    }
    
    func setupLayers(){
    //    self.backgroundColor = UIColor.white
        
//        let cloud = CAShapeLayer()
//        cloud.anchorPoint   = CGPoint(x: 0.6, y: 0.5)
//        cloud.frame         = CGRect(x: 12.32, y: 40.62, width: 160, height: 111.48)
//        cloud.fillColor     = nil
//        cloud.strokeColor   = self.lineColor.cgColor
//        cloud.lineWidth     = 3
//        cloud.strokeEnd     = 0
//        cloud.lineDashPhase = 1.5
//        cloud.path          = cloudPath().cgPath
//        self.addSublayer(cloud)
//        layers["cloud"] = cloud
//
//        let cloud2 = CAShapeLayer()
//        cloud2.anchorPoint   = CGPoint(x: 0.6, y: 0.5)
//        cloud2.frame         = CGRect(x: 12.32, y: 40.62, width: 160, height: 111.48)
//        cloud2.fillColor     = nil
//        cloud2.strokeColor   = self.lineColor.cgColor
//        cloud2.lineWidth     = 3
//        cloud2.strokeStart   = 1
//        cloud2.shadowColor   = UIColor(red:0, green: 0, blue:0, alpha:0.333).cgColor
//        cloud2.shadowOpacity = 0.33
//        cloud2.shadowOffset  = CGSize(width: 4, height: 4)
//        cloud2.shadowRadius  = 5
//        cloud2.path          = cloud2Path().cgPath
//        self.addSublayer(cloud2)
//        layers["cloud2"] = cloud2
        
//        let cloud3 = CAShapeLayer()
//        cloud3.frame       = CGRect(x: 47.67, y: 67.9, width: 160, height: 111.48)
//        cloud3.fillColor   = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor
//        cloud3.strokeColor = self.lineColor.cgColor
//        cloud3.lineWidth   = 3
//        cloud3.strokeStart = 1
//        cloud3.path        = cloud3Path().cgPath
//        self.addSublayer(cloud3)
//        layers["cloud3"] = cloud3
        
        let cloud4 = CAShapeLayer()
        cloud4.frame       = CGRect(x: 0, y: 0, width: 160, height: 150)
        cloud4.lineJoin    = .round
        cloud4.fillColor   = nil
        cloud4.strokeColor = self.lineColor.cgColor
        cloud4.lineWidth   = 30
        cloud4.strokeEnd   = 0
        cloud4.path        = pathColor().cgPath
        self.addSublayer(cloud4)
        layers["cloud4"] = cloud4
    }
    
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 4.416
            completionAnim.delegate = self
            completionAnim.setValue("old", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            self.add(completionAnim, forKey:"old")
            if let anim = self.animation(forKey: "old"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : CAMediaTimingFillMode = .forwards
        
//        ////Cloud animation
//        let cloudStrokeEndAnim            = CABasicAnimation(keyPath:"strokeEnd")
//        cloudStrokeEndAnim.fromValue      = 0;
//        cloudStrokeEndAnim.toValue        = 1;
//        cloudStrokeEndAnim.duration       = 2
//        cloudStrokeEndAnim.beginTime      = 1.68
//        cloudStrokeEndAnim.timingFunction = CAMediaTimingFunction(name:.default)
//
//        let cloudOldAnim : CAAnimationGroup = QCMethod.group(animations: [cloudStrokeEndAnim], fillMode:fillMode)
//        layers["cloud"]?.add(cloudOldAnim, forKey:"cloudOldAnim")
//
//        ////Cloud2 animation
//        let cloud2StrokeStartAnim            = CABasicAnimation(keyPath:"strokeStart")
//        cloud2StrokeStartAnim.fromValue      = 0.7;
//        cloud2StrokeStartAnim.toValue        = 0;
//        cloud2StrokeStartAnim.duration       = 2
//        cloud2StrokeStartAnim.beginTime      = 1.56
//        cloud2StrokeStartAnim.timingFunction = CAMediaTimingFunction(name:.default)
//
//        let cloud2FillColorAnim            = CABasicAnimation(keyPath:"fillColor")
//        cloud2FillColorAnim.fromValue      = UIColor(red:0.153, green: 0.216, blue:0.933, alpha:0).cgColor;
//        cloud2FillColorAnim.toValue        = self.cloudColor.cgColor;
//        cloud2FillColorAnim.duration       = 0.778
//        cloud2FillColorAnim.beginTime      = 2.54
//        cloud2FillColorAnim.timingFunction = CAMediaTimingFunction(name:.default)
//
//        let cloud2StrokeColorAnim       = CAKeyframeAnimation(keyPath:"strokeColor")
//        cloud2StrokeColorAnim.values    = [self.lineColor.cgColor,
//             self.lineColor.cgColor]
//        cloud2StrokeColorAnim.keyTimes  = [0, 1]
//        cloud2StrokeColorAnim.duration  = 1
//        cloud2StrokeColorAnim.beginTime = 3.31
//
//        let cloud2OpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
//        cloud2OpacityAnim.values    = [1, 1]
//        cloud2OpacityAnim.keyTimes  = [0, 1]
//        cloud2OpacityAnim.duration  = 1
//        cloud2OpacityAnim.beginTime = 3.31
//
//        let cloud2OldAnim : CAAnimationGroup = QCMethod.group(animations: [cloud2StrokeStartAnim, cloud2FillColorAnim, cloud2StrokeColorAnim, cloud2OpacityAnim], fillMode:fillMode)
//        layers["cloud2"]?.add(cloud2OldAnim, forKey:"cloud2OldAnim")
//
//        ////Cloud3 animation
//        let cloud3StrokeStartAnim            = CABasicAnimation(keyPath:"strokeStart")
//        cloud3StrokeStartAnim.fromValue      = 1;
//        cloud3StrokeStartAnim.toValue        = 0;
//        cloud3StrokeStartAnim.duration       = 1.8
//        cloud3StrokeStartAnim.timingFunction = CAMediaTimingFunction(name:.easeIn)
//
//        let cloud3OldAnim : CAAnimationGroup = QCMethod.group(animations: [cloud3StrokeStartAnim], fillMode:fillMode)
//        layers["cloud3"]?.add(cloud3OldAnim, forKey:"cloud3OldAnim")
        
        ////Cloud4 animation
        let cloud4StrokeEndAnim            = CABasicAnimation(keyPath:"strokeEnd")
        cloud4StrokeEndAnim.fromValue      = 0;
        cloud4StrokeEndAnim.toValue        = 1;
        cloud4StrokeEndAnim.duration       = 1.8
        cloud4StrokeEndAnim.timingFunction = CAMediaTimingFunction(name:.easeIn)
        
        let cloud4FillColorAnim            = CABasicAnimation(keyPath:"fillColor")
        cloud4FillColorAnim.fromValue      = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:0.0).cgColor;
        cloud4FillColorAnim.toValue        = self.cloudColor.cgColor;
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
        cloud4OldAnim.beginTime = 1.0
        layers["cloud4"]?.add(cloud4OldAnim, forKey:"cloud4OldAnim")
//        self.addSublayer(layers["cloud"]!)
//        self.addSublayer(layers["cloud2"]!)
//        self.addSublayer(layers["cloud3"]!)
        self.addSublayer(layers["cloud4"]!)
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
    
    func cloudPath() -> UIBezierPath{
        let cloudPath = UIBezierPath()
        cloudPath.move(to: CGPoint(x: 139.84, y: 50.2))
        cloudPath.addLine(to: CGPoint(x: 139.84, y: 48.6))
        cloudPath.addCurve(to: CGPoint(x: 139.84, y: 41.08), controlPoint1:CGPoint(x: 139.84, y: 48.6), controlPoint2:CGPoint(x: 139.84, y: 48.28))
        cloudPath.addCurve(to: CGPoint(x: 101.44, y: 0.6), controlPoint1:CGPoint(x: 139.84, y: 33.88), controlPoint2:CGPoint(x: 136, y: 5.4))
        cloudPath.addCurve(to: CGPoint(x: 55.52, y: 23), controlPoint1:CGPoint(x: 71.04, y: -3.56), controlPoint2:CGPoint(x: 57.92, y: 15))
        cloudPath.addCurve(to: CGPoint(x: 19.52, y: 54.68), controlPoint1:CGPoint(x: 55.52, y: 23), controlPoint2:CGPoint(x: 17.6, y: 16.28))
        cloudPath.addCurve(to: CGPoint(x: 0, y: 82.2), controlPoint1:CGPoint(x: 19.52, y: 54.68), controlPoint2:CGPoint(x: 0, y: 64.28))
        cloudPath.addCurve(to: CGPoint(x: 27.68, y: 111.48), controlPoint1:CGPoint(x: 0, y: 100.28), controlPoint2:CGPoint(x: 12.32, y: 111.48))
        cloudPath.addCurve(to: CGPoint(x: 136, y: 111.48), controlPoint1:CGPoint(x: 43.04, y: 111.48), controlPoint2:CGPoint(x: 128.8, y: 111.48))
        cloudPath.addCurve(to: CGPoint(x: 160, y: 82.68), controlPoint1:CGPoint(x: 143.2, y: 111.48), controlPoint2:CGPoint(x: 160, y: 100.28))
        cloudPath.addCurve(to: CGPoint(x: 139.84, y: 50.2), controlPoint1:CGPoint(x: 160, y: 65.08), controlPoint2:CGPoint(x: 148.64, y: 55))
        cloudPath.close()
        cloudPath.move(to: CGPoint(x: 139.84, y: 50.2))
        
        return cloudPath
    }
    
    func cloud2Path() -> UIBezierPath{
        let cloud2Path = UIBezierPath()
        cloud2Path.move(to: CGPoint(x: 139.84, y: 50.2))
        cloud2Path.addLine(to: CGPoint(x: 139.84, y: 48.6))
        cloud2Path.addCurve(to: CGPoint(x: 139.84, y: 41.08), controlPoint1:CGPoint(x: 139.84, y: 48.6), controlPoint2:CGPoint(x: 139.84, y: 48.28))
        cloud2Path.addCurve(to: CGPoint(x: 101.44, y: 0.6), controlPoint1:CGPoint(x: 139.84, y: 33.88), controlPoint2:CGPoint(x: 136, y: 5.4))
        cloud2Path.addCurve(to: CGPoint(x: 55.52, y: 23), controlPoint1:CGPoint(x: 71.04, y: -3.56), controlPoint2:CGPoint(x: 57.92, y: 15))
        cloud2Path.addCurve(to: CGPoint(x: 19.52, y: 54.68), controlPoint1:CGPoint(x: 55.52, y: 23), controlPoint2:CGPoint(x: 17.6, y: 16.28))
        cloud2Path.addCurve(to: CGPoint(x: 0, y: 82.2), controlPoint1:CGPoint(x: 19.52, y: 54.68), controlPoint2:CGPoint(x: 0, y: 64.28))
        cloud2Path.addCurve(to: CGPoint(x: 27.68, y: 111.48), controlPoint1:CGPoint(x: 0, y: 100.28), controlPoint2:CGPoint(x: 12.32, y: 111.48))
        cloud2Path.addCurve(to: CGPoint(x: 136, y: 111.48), controlPoint1:CGPoint(x: 43.04, y: 111.48), controlPoint2:CGPoint(x: 128.8, y: 111.48))
        cloud2Path.addCurve(to: CGPoint(x: 160, y: 82.68), controlPoint1:CGPoint(x: 143.2, y: 111.48), controlPoint2:CGPoint(x: 160, y: 100.28))
        cloud2Path.addCurve(to: CGPoint(x: 139.84, y: 50.2), controlPoint1:CGPoint(x: 160, y: 65.08), controlPoint2:CGPoint(x: 148.64, y: 55))
        cloud2Path.close()
        cloud2Path.move(to: CGPoint(x: 139.84, y: 50.2))
        
        return cloud2Path
    }
    
    func cloud3Path() -> UIBezierPath{
        let cloud3Path = UIBezierPath()
        cloud3Path.move(to: CGPoint(x: 20.16, y: 50.2))
        cloud3Path.addLine(to: CGPoint(x: 20.16, y: 48.6))
        cloud3Path.addCurve(to: CGPoint(x: 20.16, y: 41.08), controlPoint1:CGPoint(x: 20.16, y: 48.6), controlPoint2:CGPoint(x: 20.16, y: 48.28))
        cloud3Path.addCurve(to: CGPoint(x: 58.56, y: 0.6), controlPoint1:CGPoint(x: 20.16, y: 33.88), controlPoint2:CGPoint(x: 24, y: 5.4))
        cloud3Path.addCurve(to: CGPoint(x: 104.48, y: 23), controlPoint1:CGPoint(x: 88.96, y: -3.56), controlPoint2:CGPoint(x: 102.08, y: 15))
        cloud3Path.addCurve(to: CGPoint(x: 140.48, y: 54.68), controlPoint1:CGPoint(x: 104.48, y: 23), controlPoint2:CGPoint(x: 142.4, y: 16.28))
        cloud3Path.addCurve(to: CGPoint(x: 160, y: 82.2), controlPoint1:CGPoint(x: 140.48, y: 54.68), controlPoint2:CGPoint(x: 160, y: 64.28))
        cloud3Path.addCurve(to: CGPoint(x: 132.32, y: 111.48), controlPoint1:CGPoint(x: 160, y: 100.28), controlPoint2:CGPoint(x: 147.68, y: 111.48))
        cloud3Path.addCurve(to: CGPoint(x: 24, y: 111.48), controlPoint1:CGPoint(x: 116.96, y: 111.48), controlPoint2:CGPoint(x: 31.2, y: 111.48))
        cloud3Path.addCurve(to: CGPoint(x: 0, y: 82.68), controlPoint1:CGPoint(x: 16.8, y: 111.48), controlPoint2:CGPoint(x: 0, y: 100.28))
        cloud3Path.addCurve(to: CGPoint(x: 20.16, y: 50.2), controlPoint1:CGPoint(x: 0, y: 65.08), controlPoint2:CGPoint(x: 11.36, y: 55))
        cloud3Path.close()
        cloud3Path.move(to: CGPoint(x: 20.16, y: 50.2))
        
        return cloud3Path
    }
    
    func cloud4Path2() -> UIBezierPath{
        let cloud4Path = UIBezierPath()
        cloud4Path.move(to: CGPoint(x: 20.16, y: 50.2))
        cloud4Path.addLine(to: CGPoint(x: 20.16, y: 48.6))
        cloud4Path.addCurve(to: CGPoint(x: 20.16, y: 41.08), controlPoint1:CGPoint(x: 20.16, y: 48.6), controlPoint2:CGPoint(x: 20.16, y: 48.28))
        cloud4Path.addCurve(to: CGPoint(x: 58.56, y: 0.6), controlPoint1:CGPoint(x: 20.16, y: 33.88), controlPoint2:CGPoint(x: 24, y: 5.4))
        cloud4Path.addCurve(to: CGPoint(x: 104.48, y: 23), controlPoint1:CGPoint(x: 88.96, y: -3.56), controlPoint2:CGPoint(x: 102.08, y: 15))
        cloud4Path.addCurve(to: CGPoint(x: 140.48, y: 54.68), controlPoint1:CGPoint(x: 104.48, y: 23), controlPoint2:CGPoint(x: 142.4, y: 16.28))
        cloud4Path.addCurve(to: CGPoint(x: 160, y: 82.2), controlPoint1:CGPoint(x: 140.48, y: 54.68), controlPoint2:CGPoint(x: 160, y: 64.28))
        cloud4Path.addCurve(to: CGPoint(x: 132.32, y: 111.48), controlPoint1:CGPoint(x: 160, y: 100.28), controlPoint2:CGPoint(x: 147.68, y: 111.48))
        cloud4Path.addCurve(to: CGPoint(x: 24, y: 111.48), controlPoint1:CGPoint(x: 116.96, y: 111.48), controlPoint2:CGPoint(x: 31.2, y: 111.48))
        cloud4Path.addCurve(to: CGPoint(x: 0, y: 82.68), controlPoint1:CGPoint(x: 16.8, y: 111.48), controlPoint2:CGPoint(x: 0, y: 100.28))
        cloud4Path.addCurve(to: CGPoint(x: 20.16, y: 50.2), controlPoint1:CGPoint(x: 0, y: 65.08), controlPoint2:CGPoint(x: 11.36, y: 55))
        cloud4Path.close()
        cloud4Path.move(to: CGPoint(x: 20.16, y: 50.2))
        
        return cloud4Path
    }
    
    func cloud4Path() -> UIBezierPath{
        //// General Declarations
         

        //// Color Declarations
        let gradientColor = UIColor(red: 0.800, green: 0.271, blue: 1.000, alpha: 1.000)
        let gradientColor2 = UIColor(red: 1.000, green: 0.580, blue: 0.804, alpha: 1.000)

        //// Gradient Declarations
        let linearGradient1 = CGGradient(colorsSpace: nil, colors: [gradientColor.cgColor, gradientColor2.cgColor] as CFArray, locations: [0, 1])!

        //// topframe
        //// Path Drawing
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: 0, y: 259))
        pathPath.addLine(to: CGPoint(x: 720, y: 259))
        pathPath.addLine(to: CGPoint(x: 720, y: 124.64))
        pathPath.addCurve(to: CGPoint(x: 600.36, y: 41.54), controlPoint1: CGPoint(x: 720, y: 124.64), controlPoint2: CGPoint(x: 663.08, y: 37.43))
        pathPath.addCurve(to: CGPoint(x: 353.51, y: 169.87), controlPoint1: CGPoint(x: 510.72, y: 47.41), controlPoint2: CGPoint(x: 462.73, y: 155.89))
        pathPath.addCurve(to: CGPoint(x: 110.96, y: 22.68), controlPoint1: CGPoint(x: 244.26, y: 183.86), controlPoint2: CGPoint(x: 171.78, y: 76.33))
        pathPath.addCurve(to: CGPoint(x: 0.1, y: 10.79), controlPoint1: CGPoint(x: 62.47, y: -20.11), controlPoint2: CGPoint(x: 0.1, y: 10.79))
        pathPath.addLine(to: CGPoint(x: 0, y: 259))
        pathPath.close()
        pathPath.move(to: CGPoint(x: 0, y: 259))
       // context.saveGState()
       // pathPath.addClip()
        //context.drawLinearGradient(linearGradient1,
//            start: CGPoint(x: 360, y: 97.19),
//            end: CGPoint(x: 360, y: -60.26),
//            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
//        context.restoreGState()
        return pathPath
    }
    
    func pathColor()-> UIBezierPath{
        
        
        //// General Declarations
       // let context = UIGraphicsGetCurrentContext()!

        //// Color Declarations
        let gradientColor = UIColor(red: 1.000, green: 0.314, blue: 0.945, alpha: 1.000)
        let gradientColor2 = UIColor(red: 1.000, green: 0.835, blue: 0.306, alpha: 1.000)

        //// Gradient Declarations
        let linearGradient1 = CGGradient(colorsSpace: nil, colors: [gradientColor.cgColor, gradientColor2.cgColor] as CFArray, locations: [0, 1])!

        //// Page-7
        //// 12.9″-iPad-Pro
        //// pathColor Drawing
        let pathColorPath = UIBezierPath()
        pathColorPath.move(to: CGPoint(x: 2, y: 91.75))
        pathColorPath.addCurve(to: CGPoint(x: 218.75, y: 18.28), controlPoint1: CGPoint(x: 18.36, y: 49.5), controlPoint2: CGPoint(x: 132.69, y: -4.24))
        pathColorPath.addCurve(to: CGPoint(x: 490.02, y: 40.8), controlPoint1: CGPoint(x: 304.82, y: 40.8), controlPoint2: CGPoint(x: 375.49, y: 90.81))
        pathColorPath.addCurve(to: CGPoint(x: 895.99, y: 100.97), controlPoint1: CGPoint(x: 604.55, y: -9.2), controlPoint2: CGPoint(x: 895.99, y: -35.36))
        pathColorPath.addCurve(to: CGPoint(x: 582.67, y: 205), controlPoint1: CGPoint(x: 895.99, y: 191.86), controlPoint2: CGPoint(x: 791.55, y: 226.53))
        pathColorPath.addLine(to: CGPoint(x: 92.84, y: 177.62))
        pathColorPath.addCurve(to: CGPoint(x: 2, y: 91.75), controlPoint1: CGPoint(x: 21.37, y: 148.54), controlPoint2: CGPoint(x: -8.91, y: 119.92))
        pathColorPath.close()
        pathColorPath.usesEvenOddFillRule = true
       // context.saveGState()
        pathColorPath.addClip()
//        context.drawLinearGradient(linearGradient1,
//            start: CGPoint(x: 447.91, y: 0.42),
//            end: CGPoint(x: 447.91, y: 211.19),
//            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
//        context.restoreGState()
        
        return pathColorPath
        
    }
    
    
}


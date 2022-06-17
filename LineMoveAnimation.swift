//
//  LineMoveAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/16.
//

import UIKit

class LineMoveAnimation: CALayer, CAAnimationDelegate {
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = true
    
    
    var scale = 1.0
    
    
    
    func setupProperties(){
        
    }
    
    func setupLayers(){
//        self.backgroundColor = UIColor.white
        
        let heartPath = CAShapeLayer()
        heartPath.isHidden    = true
        heartPath.frame       = CGRect(x: 40, y: 40, width: self.frame.width, height: self.frame.height)
        heartPath.setValue(-360 * CGFloat.pi/180, forKeyPath:"transform.rotation")
        heartPath.fillColor   = UIColor(red:1.00, green: 0.15, blue:0.20, alpha:1.0).cgColor
        heartPath.strokeColor = UIColor.black.cgColor
        heartPath.path        = linePath().cgPath
        self.addSublayer(heartPath)
        layers["heartPath"] = heartPath
        
        let emitter = CAEmitterLayer()
        emitter.frame                    = CGRect(x: 20, y: 20, width: 175 * scale, height: 65.29 * scale)
        emitter.emitterPosition          = CGPoint(x: 230, y: defaultSize.height - 200)
        emitter.emitterSize              = CGSize(width: 10 * scale , height: 10 * scale)
        emitter.emitterShape             = .circle
        emitter.emitterMode              = .points
        emitter.renderMode               = .additive
        
        let emitter2Cell                = CAEmitterCell()
        emitter2Cell.name              = "emitter2Cell"
        emitter2Cell.contents          = UIImage(named:"ball4")?.cgImage
        emitter2Cell.birthRate         = 2
        emitter2Cell.lifetime          = 5
        emitter2Cell.emissionLongitude = 3
        emitter2Cell.emissionRange     = 3.14
        emitter2Cell.velocity          = 60
        emitter2Cell.velocityRange     = 1
        emitter2Cell.xAcceleration     = 5
        emitter2Cell.yAcceleration     = 40
        emitter2Cell.scale             = 0.8
        emitter2Cell.scaleRange        = 0.9
        emitter2Cell.spin              = 0.2
        emitter2Cell.redRange          = 0.26
        emitter2Cell.greenRange        = 0.8
        emitter2Cell.blueRange         = 0.65
        emitter2Cell.alphaRange = 0.10   //随机透明度
        emitter2Cell.alphaSpeed =  0.50  //逐渐消失
        
        let emitter2Cell3               = CAEmitterCell()
        emitter2Cell3.name              = "emitter2Cell3"
        emitter2Cell3.contents          = UIImage(named:"ball3")?.cgImage
        emitter2Cell3.birthRate         = 1
        emitter2Cell3.lifetime          = 5
        emitter2Cell3.lifetimeRange     = 1
        emitter2Cell3.emissionLatitude  = 21
        emitter2Cell3.emissionLongitude = 3
        emitter2Cell3.emissionRange     = 3.14
        emitter2Cell3.velocity          = 10
        emitter2Cell3.velocityRange     = 11
        emitter2Cell3.xAcceleration     = 3
        emitter2Cell3.yAcceleration     = -2
        emitter2Cell3.scale             = 0.9
        emitter2Cell3.scaleRange        = 0.8
        emitter2Cell3.spin              = 1
        emitter2Cell3.redRange          = 0.7
        emitter2Cell3.greenRange        = 0.94
        emitter2Cell3.blueRange         = 0.98
        
        emitter.emitterCells             = [emitter2Cell, emitter2Cell3]
        self.addSublayer(emitter)
        layers["emitter"] = emitter
    }
    
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(){
        let fillMode : CAMediaTimingFillMode = .forwards
        
        ////An infinity animation
        
        ////Emitter animation
        let emitterEmitterPositionAnim         = CAKeyframeAnimation(keyPath:"emitterPosition")
        emitterEmitterPositionAnim.path        = linePath().cgPath
        emitterEmitterPositionAnim.calculationMode = CAAnimationCalculationMode.cubicPaced
        emitterEmitterPositionAnim.duration    = 2
        emitterEmitterPositionAnim.repeatCount = Float.infinity
        
        let emitterOldAnim : CAAnimationGroup = QCMethod.group(animations: [emitterEmitterPositionAnim], fillMode:fillMode)
        emitterOldAnim.beginTime = 1.0
        layers["emitter"]?.add(emitterOldAnim, forKey:"emitterOldAnim")
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
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["emitter"]!.animation(forKey: "emitterOldAnim"), theLayer:layers["emitter"]!)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "old"{
            layers["emitter"]?.removeAnimation(forKey: "emitterOldAnim")
        }
    }
    
//    func removeAllAnimations(){
//        for layer in layers.values{
//            layer.removeAllAnimations()
//        }
//    }
    
    //MARK: - Bezier Path
    
    func heartPathPath2() -> UIBezierPath{
        let heartPathPath = UIBezierPath()
        heartPathPath.move(to: CGPoint(x: 471.632, y: 0))
        heartPathPath.addCurve(to: CGPoint(x: 315.08, y: 73.667), controlPoint1:CGPoint(x: 357.418, y: 0), controlPoint2:CGPoint(x: 315.08, y: 73.667))
        heartPathPath.addLine(to: CGPoint(x: 314.095, y: 74.649))
        heartPathPath.addLine(to: CGPoint(x: 314.095, y: 73.667))
        heartPathPath.addCurve(to: CGPoint(x: 157.543, y: 0), controlPoint1:CGPoint(x: 314.095, y: 73.667), controlPoint2:CGPoint(x: 271.757, y: 0))
        heartPathPath.addCurve(to: CGPoint(x: 314.095, y: 557.905), controlPoint1:CGPoint(x: 20.683, y: -0), controlPoint2:CGPoint(x: -177.223, y: 269.13))
        heartPathPath.addLine(to: CGPoint(x: 314.095, y: 556.923))
        heartPathPath.addLine(to: CGPoint(x: 315.08, y: 557.905))
        heartPathPath.addCurve(to: CGPoint(x: 471.632, y: 0), controlPoint1:CGPoint(x: 807.383, y: 269.13), controlPoint2:CGPoint(x: 608.492, y: 0))
        heartPathPath.close()
        heartPathPath.move(to: CGPoint(x: 471.632, y: 0))
        
        return heartPathPath
    }
    
    func heartPathPath() ->UIBezierPath {
        let shapePath = UIBezierPath()
        shapePath.move(to: CGPoint(x: 342.79, y: 0))
        shapePath.addCurve(to: CGPoint(x: 297.29, y: 10.84), controlPoint1: CGPoint(x: 326.96, y: -0.01), controlPoint2: CGPoint(x: 311.36, y: 3.71))
        shapePath.addCurve(to: CGPoint(x: 0, y: 366.4), controlPoint1: CGPoint(x: 207.91, y: 56.23), controlPoint2: CGPoint(x: 0, y: 181.73))
        shapePath.addCurve(to: CGPoint(x: 192.94, y: 570), controlPoint1: CGPoint(x: 0, y: 478.66), controlPoint2: CGPoint(x: 86.55, y: 570))
        shapePath.addCurve(to: CGPoint(x: 342.5, y: 494.96), controlPoint1: CGPoint(x: 251.38, y: 570), controlPoint2: CGPoint(x: 306.2, y: 541.92))
        shapePath.addCurve(to: CGPoint(x: 492.06, y: 570), controlPoint1: CGPoint(x: 378.8, y: 541.92), controlPoint2: CGPoint(x: 433.62, y: 570))
        shapePath.addCurve(to: CGPoint(x: 685, y: 366.39), controlPoint1: CGPoint(x: 598.45, y: 570), controlPoint2: CGPoint(x: 685, y: 478.66))
        shapePath.addCurve(to: CGPoint(x: 387.73, y: 10.57), controlPoint1: CGPoint(x: 685, y: 179.49), controlPoint2: CGPoint(x: 477.11, y: 55.29))
        shapePath.addCurve(to: CGPoint(x: 342.79, y: 0), controlPoint1: CGPoint(x: 373.81, y: 3.61), controlPoint2: CGPoint(x: 358.41, y: -0.01))
        shapePath.close()
        shapePath.move(to: CGPoint(x: 192.94, y: 528.54))
        shapePath.addCurve(to: CGPoint(x: 42.15, y: 366.4), controlPoint1: CGPoint(x: 109.79, y: 528.54), controlPoint2: CGPoint(x: 42.15, y: 455.8))
        shapePath.addCurve(to: CGPoint(x: 147.21, y: 163.51), controlPoint1: CGPoint(x: 42.15, y: 297.14), controlPoint2: CGPoint(x: 77.5, y: 228.88))
        shapePath.addCurve(to: CGPoint(x: 316.63, y: 47.68), controlPoint1: CGPoint(x: 207.49, y: 106.97), controlPoint2: CGPoint(x: 279.23, y: 66.67))
        shapePath.addCurve(to: CGPoint(x: 368.62, y: 47.52), controlPoint1: CGPoint(x: 332.93, y: 39.42), controlPoint2: CGPoint(x: 352.27, y: 39.36))
        shapePath.addCurve(to: CGPoint(x: 537.91, y: 162.39), controlPoint1: CGPoint(x: 406, y: 66.22), controlPoint2: CGPoint(x: 477.7, y: 106.02))
        shapePath.addCurve(to: CGPoint(x: 642.85, y: 366.4), controlPoint1: CGPoint(x: 607.54, y: 227.59), controlPoint2: CGPoint(x: 642.85, y: 296.23))
        shapePath.addCurve(to: CGPoint(x: 492.06, y: 528.55), controlPoint1: CGPoint(x: 642.85, y: 455.8), controlPoint2: CGPoint(x: 575.21, y: 528.55))
        shapePath.addCurve(to: CGPoint(x: 361.17, y: 446.82), controlPoint1: CGPoint(x: 438.18, y: 528.55), controlPoint2: CGPoint(x: 388.03, y: 497.23))
        shapePath.addCurve(to: CGPoint(x: 342.5, y: 435.71), controlPoint1: CGPoint(x: 357.53, y: 439.99), controlPoint2: CGPoint(x: 350.34, y: 435.71))
        shapePath.addCurve(to: CGPoint(x: 323.83, y: 446.82), controlPoint1: CGPoint(x: 334.66, y: 435.71), controlPoint2: CGPoint(x: 327.47, y: 439.99))
        shapePath.addCurve(to: CGPoint(x: 192.94, y: 528.54), controlPoint1: CGPoint(x: 296.97, y: 497.23), controlPoint2: CGPoint(x: 246.81, y: 528.54))
        shapePath.close()
        shapePath.move(to: CGPoint(x: 342.79, y: 0))
        return shapePath

    }
    
    func linePath() ->UIBezierPath {
        let linePathPath = UIBezierPath()
        let width = defaultSize.width
        let height: CGFloat = defaultSize.height
        linePathPath.move(to: CGPoint(x: 230, y: height - 200))
                //计算上下两个点
                let point1: CGPoint = CGPoint(x: (width-60)/4.0, y: 0)
                let point2: CGPoint = CGPoint(x: (width-60)*3/4.0, y: 900)
        linePathPath.addCurve(to: CGPoint(x: width-30, y: height), controlPoint1: point1, controlPoint2: point2)
                
        
        return linePathPath
    }
    
    
    func linePath2() ->UIBezierPath {
        let linePathPath = UIBezierPath()
        linePathPath.move(to: CGPoint(x: 75.05 * scale, y: 0 * scale))
        linePathPath.addCurve(to: CGPoint(x: 47.11 * scale, y: 32.14 * scale), controlPoint1: CGPoint(x: 65.73 * scale, y: 10.47 * scale), controlPoint2: CGPoint(x: 55.64 * scale, y: 20.68 * scale))
        linePathPath.addCurve(to: CGPoint(x: 28.99 * scale, y: 61.49 * scale), controlPoint1: CGPoint(x: 40.24 * scale, y: 41.36 * scale), controlPoint2: CGPoint(x: 34.37 * scale, y: 51.33 *  scale))
        linePathPath.addCurve(to: CGPoint(x: 60.32 * scale, y: 140.71 * scale), controlPoint1: CGPoint(x: 10.61 * scale, y: 96.24 * scale), controlPoint2: CGPoint(x: 26.93 * scale, y: 126.22 * scale))
        linePathPath.addCurve(to: CGPoint(x: 95.74 * scale, y: 153.24 * scale), controlPoint1: CGPoint(x: 71.81 * scale, y: 145.69 * scale), controlPoint2: CGPoint(x: 83.7 * scale, y: 149.78 * scale))
        linePathPath.addCurve(to: CGPoint(x: 192.24 * scale, y: 222.2 * scale), controlPoint1: CGPoint(x: 137.19 * scale, y: 165.15 * scale), controlPoint2: CGPoint(x: 198.58 * scale, y: 163.76 * scale))
        linePathPath.addCurve(to: CGPoint(x: 137.92 * scale, y: 263.83 * scale), controlPoint1: CGPoint(x: 189.49 * scale, y: 247.44 * scale), controlPoint2: CGPoint(x: 158.84 * scale, y: 257.94 * scale))
        linePathPath.addCurve(to: CGPoint(x: 0.63 * scale, y: 339.57 * scale), controlPoint1: CGPoint(x: 85.09 * scale, y: 278.7 * scale), controlPoint2: CGPoint(x: 24.19 * scale, y: 282.11 * scale))
        linePathPath.addCurve(to: CGPoint(x: -0.26 * scale, y: 349.56 * scale), controlPoint1: CGPoint(x: -0.63 * scale, y: 342.67 * scale), controlPoint2: CGPoint(x: -0.61 * scale, y: 346.24 * scale))
        linePathPath.addCurve(to: CGPoint(x: 2.85 * scale, y: 360.32 * scale), controlPoint1: CGPoint(x: 0.14 * scale, y: 353.27 * scale), controlPoint2: CGPoint(x: 2.27 * scale, y: 356.63 * scale))
        linePathPath.addCurve(to: CGPoint(x: 4.33 * scale, y: 378.76 * scale), controlPoint1: CGPoint(x: 3.8 * scale, y: 366.41 * scale), controlPoint2: CGPoint(x: 3.09 * scale, y: 372.72 * scale))
        linePathPath.addCurve(to: CGPoint(x: 128.8 * scale, y: 424 * scale), controlPoint1: CGPoint(x: 14.51 * scale, y: 428.24 * scale), controlPoint2: CGPoint(x: 90.3 * scale, y: 426.23 * scale))
        linePathPath.addCurve(to: CGPoint(x: 195.73 * scale, y: 456.36 * scale), controlPoint1: CGPoint(x: 159.42 * scale, y: 422.23 * scale), controlPoint2: CGPoint(x: 197.13 * scale, y: 413.84 * scale))
//        strokeColor.setStroke()
        
        return linePathPath
    }
    
}

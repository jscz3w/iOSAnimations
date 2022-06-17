//
//  CustomView.swift
//
//  Code generated using QuartzCode 1.66.7 on 2022/5/10.
//  www.quartzcodeapp.com
//

import UIKit


class HeartAnimation: CALayer, CAAnimationDelegate {
    
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = true
    
    
    
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
        
    }
    
    func setupLayers(){
//        self.backgroundColor = UIColor.white
        
        let heartPath = CAShapeLayer()
        heartPath.isHidden    = true
        heartPath.frame       = CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height)
        heartPath.setValue(-360 * CGFloat.pi/180, forKeyPath:"transform.rotation")
        heartPath.fillColor   = UIColor(red:1.00, green: 0.15, blue:0.20, alpha:1.0).cgColor
        heartPath.strokeColor = UIColor.black.cgColor
        heartPath.path        = heartPathPath().cgPath
        self.addSublayer(heartPath)
        layers["heartPath"] = heartPath
        
        let emitter = CAEmitterLayer()
        emitter.frame                    = CGRect(x: 17.32, y: 320, width: 175, height: 65.29)
        emitter.emitterPosition          = CGPoint(x: 79, y: 65.295)
        emitter.emitterSize              = CGSize(width: 70, height: 70)
        emitter.emitterShape             = .circle
        emitter.emitterMode              = .points
        emitter.renderMode               = .additive
        
        let emitter2Cell                = CAEmitterCell()
        emitter2Cell.name              = "emitter2Cell"
        emitter2Cell.contents          = UIImage(named:"light")?.cgImage
        emitter2Cell.birthRate         = 1680
        emitter2Cell.lifetime          = 1.2
        emitter2Cell.emissionLongitude = 3
        emitter2Cell.emissionRange     = 3.14
        emitter2Cell.velocity          = 60
        emitter2Cell.velocityRange     = 1
        emitter2Cell.xAcceleration     = 5
        emitter2Cell.yAcceleration     = 40
        emitter2Cell.scale             = 0.11
        emitter2Cell.scaleRange        = 0.5
        emitter2Cell.spin              = 1
        emitter2Cell.redRange          = 0.26
        emitter2Cell.greenRange        = 0.8
        emitter2Cell.blueRange         = 0.65
        
        let emitter2Cell3               = CAEmitterCell()
        emitter2Cell3.name              = "emitter2Cell3"
        emitter2Cell3.contents          = UIImage(named:"heart")?.cgImage
        emitter2Cell3.birthRate         = 3000
        emitter2Cell3.lifetime          = 1.2
        emitter2Cell3.lifetimeRange     = 1
        emitter2Cell3.emissionLatitude  = 21
        emitter2Cell3.emissionLongitude = 3
        emitter2Cell3.emissionRange     = 3.14
        emitter2Cell3.velocity          = 10
        emitter2Cell3.velocityRange     = 11
        emitter2Cell3.xAcceleration     = 3
        emitter2Cell3.yAcceleration     = -2
        emitter2Cell3.scale             = 0.61
        emitter2Cell3.scaleRange        = 0.5
        emitter2Cell3.spin              = 5
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
        emitterEmitterPositionAnim.path        = heartPathPath().cgPath
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
        shapePath.move(to: CGPoint(x: 550.47, y: 940))
        shapePath.addCurve(to: CGPoint(x: 477.4, y: 922.12), controlPoint1: CGPoint(x: 525.05, y: 940.02), controlPoint2: CGPoint(x: 499.99, y: 933.88))
        shapePath.addCurve(to: CGPoint(x: 0, y: 335.77), controlPoint1: CGPoint(x: 333.87, y: 847.27), controlPoint2: CGPoint(x: -0, y: 640.3))
        shapePath.addCurve(to: CGPoint(x: 309.83, y: -0), controlPoint1: CGPoint(x: 0, y: 150.63), controlPoint2: CGPoint(x: 138.99, y: -0))
        shapePath.addCurve(to: CGPoint(x: 550, y: 123.74), controlPoint1: CGPoint(x: 403.68, y: -0), controlPoint2: CGPoint(x: 491.71, y: 46.3))
        shapePath.addCurve(to: CGPoint(x: 790.17, y: -0), controlPoint1: CGPoint(x: 608.29, y: 46.3), controlPoint2: CGPoint(x: 696.32, y: -0))
        shapePath.addCurve(to: CGPoint(x: 1100, y: 335.78), controlPoint1: CGPoint(x: 961.01, y: -0), controlPoint2: CGPoint(x: 1100, y: 150.63))
        shapePath.addCurve(to: CGPoint(x: 622.63, y: 922.57), controlPoint1: CGPoint(x: 1100, y: 644), controlPoint2: CGPoint(x: 766.17, y: 848.82))
        shapePath.addCurve(to: CGPoint(x: 550.47, y: 940), controlPoint1: CGPoint(x: 600.27, y: 934.04), controlPoint2: CGPoint(x: 575.54, y: 940.01))
        shapePath.close()
        shapePath.move(to: CGPoint(x: 309.83, y: 68.37))
        shapePath.addCurve(to: CGPoint(x: 67.69, y: 335.77), controlPoint1: CGPoint(x: 176.31, y: 68.37), controlPoint2: CGPoint(x: 67.69, y: 188.33))
        shapePath.addCurve(to: CGPoint(x: 236.39, y: 670.36), controlPoint1: CGPoint(x: 67.69, y: 449.97), controlPoint2: CGPoint(x: 124.45, y: 562.54))
        shapePath.addCurve(to: CGPoint(x: 508.46, y: 861.37), controlPoint1: CGPoint(x: 333.19, y: 763.6), controlPoint2: CGPoint(x: 448.4, y: 830.06))
        shapePath.addCurve(to: CGPoint(x: 591.94, y: 861.64), controlPoint1: CGPoint(x: 534.63, y: 874.99), controlPoint2: CGPoint(x: 565.69, y: 875.09))
        shapePath.addCurve(to: CGPoint(x: 863.8, y: 672.19), controlPoint1: CGPoint(x: 651.97, y: 830.8), controlPoint2: CGPoint(x: 767.11, y: 765.17))
        shapePath.addCurve(to: CGPoint(x: 1032.31, y: 335.77), controlPoint1: CGPoint(x: 975.62, y: 564.67), controlPoint2: CGPoint(x: 1032.31, y: 451.48))
        shapePath.addCurve(to: CGPoint(x: 790.17, y: 68.36), controlPoint1: CGPoint(x: 1032.31, y: 188.33), controlPoint2: CGPoint(x: 923.69, y: 68.36))
        shapePath.addCurve(to: CGPoint(x: 579.98, y: 203.14), controlPoint1: CGPoint(x: 703.65, y: 68.36), controlPoint2: CGPoint(x: 623.11, y: 120))
        shapePath.addCurve(to: CGPoint(x: 550, y: 221.45), controlPoint1: CGPoint(x: 574.14, y: 214.4), controlPoint2: CGPoint(x: 562.59, y: 221.45))
        shapePath.addCurve(to: CGPoint(x: 520.02, y: 203.14), controlPoint1: CGPoint(x: 537.41, y: 221.45), controlPoint2: CGPoint(x: 525.86, y: 214.4))
        shapePath.addCurve(to: CGPoint(x: 309.83, y: 68.37), controlPoint1: CGPoint(x: 476.88, y: 120.01), controlPoint2: CGPoint(x: 396.34, y: 68.37))
        shapePath.close()

        return shapePath

    }
    
    func linePath() ->UIBezierPath {
        let linePathPath = UIBezierPath()
        linePathPath.move(to: CGPoint(x: 75.05, y: -0.37))
        linePathPath.addCurve(to: CGPoint(x: 47.11, y: 32.14), controlPoint1: CGPoint(x: 65.73, y: 10.47), controlPoint2: CGPoint(x: 55.64, y: 20.68))
        linePathPath.addCurve(to: CGPoint(x: 28.99, y: 61.49), controlPoint1: CGPoint(x: 40.24, y: 41.36), controlPoint2: CGPoint(x: 34.37, y: 51.33))
        linePathPath.addCurve(to: CGPoint(x: 60.32, y: 140.71), controlPoint1: CGPoint(x: 10.61, y: 96.24), controlPoint2: CGPoint(x: 26.93, y: 126.22))
        linePathPath.addCurve(to: CGPoint(x: 95.74, y: 153.24), controlPoint1: CGPoint(x: 71.81, y: 145.69), controlPoint2: CGPoint(x: 83.7, y: 149.78))
        linePathPath.addCurve(to: CGPoint(x: 192.24, y: 222.2), controlPoint1: CGPoint(x: 137.19, y: 165.15), controlPoint2: CGPoint(x: 198.58, y: 163.76))
        linePathPath.addCurve(to: CGPoint(x: 137.92, y: 263.83), controlPoint1: CGPoint(x: 189.49, y: 247.44), controlPoint2: CGPoint(x: 158.84, y: 257.94))
        linePathPath.addCurve(to: CGPoint(x: 0.63, y: 339.57), controlPoint1: CGPoint(x: 85.09, y: 278.7), controlPoint2: CGPoint(x: 24.19, y: 282.11))
        linePathPath.addCurve(to: CGPoint(x: -0.26, y: 349.56), controlPoint1: CGPoint(x: -0.63, y: 342.67), controlPoint2: CGPoint(x: -0.61, y: 346.24))
        linePathPath.addCurve(to: CGPoint(x: 2.85, y: 360.32), controlPoint1: CGPoint(x: 0.14, y: 353.27), controlPoint2: CGPoint(x: 2.27, y: 356.63))
        linePathPath.addCurve(to: CGPoint(x: 4.33, y: 378.76), controlPoint1: CGPoint(x: 3.8, y: 366.41), controlPoint2: CGPoint(x: 3.09, y: 372.72))
        linePathPath.addCurve(to: CGPoint(x: 128.8, y: 424), controlPoint1: CGPoint(x: 14.51, y: 428.24), controlPoint2: CGPoint(x: 90.3, y: 426.23))
        linePathPath.addCurve(to: CGPoint(x: 195.73, y: 456.36), controlPoint1: CGPoint(x: 159.42, y: 422.23), controlPoint2: CGPoint(x: 197.13, y: 413.84))
//        strokeColor.setStroke()
        
        return linePathPath
    }
    
    
}

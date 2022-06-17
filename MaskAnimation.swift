//
//  MaskAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/17.
//

import UIKit

class MaskAnimation: CALayer ,CAAnimationDelegate {
    
    var updateLayerValueForCompletedAnimation : Bool = false
    var animationAdded : Bool = false
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var layers = [String: CALayer]()
    var iWidth = 0.0
    var iHeight = 0.0
    
    
    //MARK: - Life Cycle
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupProperties()
//        setupLayers()
//    }
    
//    required init?(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)
//        setupProperties()
//        setupLayers()
//    }
    
    var oldAnimProgress: CGFloat = 0{
        didSet{
            if(!self.animationAdded){
                removeAllAnimations()
                addOldAnimation()
                self.animationAdded = true
                self.speed = 0
                self.timeOffset = 0
            }
            else{
                let totalDuration : CGFloat = 1.96
                let offset = oldAnimProgress * totalDuration
                self.timeOffset = CFTimeInterval(offset)
            }
        }
    }
    
    func setupProperties(){
        
    }
    
    func setupLayers(){
        //self.backgroundColor = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0)
        
        let text = CATextLayer()
        text.frame           = CGRect(x: -4.8, y: 10.11, width: 304.3, height: 79.78)
        text.contentsScale   = UIScreen.main.scale
        text.string          = "QuartzCode"
        text.font            = "ChalkboardSE-Bold" as CFTypeRef
        text.fontSize        = 51
        text.alignmentMode   = .center;
        text.foregroundColor = UIColor(red:0.319, green: 0, blue:1, alpha:1).cgColor
        self.addSublayer(text)
        layers["text"] = text
        let oval = CAShapeLayer()
        oval.frame         = CGRect(x: -127.06, y: 17.25, width: 55, height: 55)
        oval.fillRule      = .evenOdd
        oval.fillColor     = UIColor.white.cgColor
        oval.strokeColor   = UIColor(red:0.404, green: 0.404, blue:0.404, alpha:1).cgColor
        oval.shadowOpacity = 1
        oval.shadowOffset  = CGSize(width: 4, height: 4)
        oval.path          = ovalPath().cgPath
        text.mask = oval
        layers["oval"] = oval
    }
    
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1.956
            completionAnim.delegate = self
            completionAnim.setValue("old", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            self.add(completionAnim, forKey:"old")
            if let anim = self.animation(forKey: "old"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        self.speed = 1
        self.animationAdded = false
        
        let fillMode : CAMediaTimingFillMode = .forwards
        
        ////Oval animation
        let ovalTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        ovalTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
             NSValue(caTransform3D: CATransform3DMakeTranslation(381, 0, 0)),
             NSValue(caTransform3D: CATransform3DMakeTranslation(244, 0, 0)),
             NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(10, 2, 1), CATransform3DMakeTranslation(244, 0, 0)))]
        ovalTransformAnim.keyTimes = [0, 0.294, 0.648, 1]
        ovalTransformAnim.duration = 1.96
        
        let ovalOldAnim : CAAnimationGroup = QCMethod.group(animations: [ovalTransformAnim], fillMode:fillMode)
        layers["oval"]?.add(ovalOldAnim, forKey:"ovalOldAnim")
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
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["oval"]!.animation(forKey: "ovalOldAnim"), theLayer:layers["oval"]!)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "old"{
            layers["oval"]?.removeAnimation(forKey: "ovalOldAnim")
        }
        self.speed = 1
    }
    
    override func removeAllAnimations(){
        for layer in layers.values{
            layer.removeAllAnimations()
        }
        self.speed = 1
    }
    
    //MARK: - Bezier Path
    
    func ovalPath() -> UIBezierPath{
        let ovalPath = UIBezierPath()
        ovalPath.move(to: CGPoint(x: -304.305, y: -79.777))
        ovalPath.addLine(to: CGPoint(x: 608.609, y: -79.777))
        ovalPath.addLine(to: CGPoint(x: 608.609, y: 159.555))
        ovalPath.addLine(to: CGPoint(x: -304.305, y: 159.555))
        ovalPath.close()
        ovalPath.move(to: CGPoint(x: 27.5, y: 55))
        ovalPath.addCurve(to: CGPoint(x: 0, y: 27.5), controlPoint1:CGPoint(x: 12.312, y: 55), controlPoint2:CGPoint(x: 0, y: 42.688))
        ovalPath.addCurve(to: CGPoint(x: 27.5, y: 0), controlPoint1:CGPoint(x: 0, y: 12.312), controlPoint2:CGPoint(x: 12.312, y: 0))
        ovalPath.addCurve(to: CGPoint(x: 55, y: 27.5), controlPoint1:CGPoint(x: 42.688, y: 0), controlPoint2:CGPoint(x: 55, y: 12.312))
        ovalPath.addCurve(to: CGPoint(x: 27.5, y: 55), controlPoint1:CGPoint(x: 55, y: 42.688), controlPoint2:CGPoint(x: 42.688, y: 55))
        
        return ovalPath
    }
    
    
}

//
//  Small2BigAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/11.
//


import UIKit


class Small2BigAnimation: UIView, CAAnimationDelegate {
    
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = false
    
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
    }
    
    
    
    func setupProperties(){
        
    }
    
    func setupLayers(){
        self.backgroundColor = UIColor.white
        
        let flower = CALayer()
        flower.anchorPoint = CGPoint(x: 0.5, y: 0)
        flower.frame       = CGRect(x: 31.69, y: 0, width: 256.61, height: 168.42)
        flower.contents    = UIImage(named:"flower.jpg")?.cgImage
        self.layer.addSublayer(flower)
        layers["flower"] = flower
        let oval = CAShapeLayer()
        oval.frame       = CGRect(x: 72.83, y: 28.74, width: 110.95, height: 110.95)
        oval.fillColor   = UIColor.white.cgColor
        oval.strokeColor = UIColor(red:0.404, green: 0.404, blue:0.404, alpha:1).cgColor
        oval.path        = ovalPath().cgPath
        flower.mask = oval
        layers["oval"] = oval
    }
    
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0.783
            completionAnim.delegate = self
            completionAnim.setValue("old", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"old")
            if let anim = layer.animation(forKey: "old"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : CAMediaTimingFillMode = .forwards
        
        ////Flower animation
        let flowerTransformAnim            = CABasicAnimation(keyPath:"transform")
        flowerTransformAnim.fromValue      = NSValue(caTransform3D: CATransform3DIdentity);
        flowerTransformAnim.toValue        = NSValue(caTransform3D: CATransform3DMakeScale(1.8, 1.8, 1));
        flowerTransformAnim.duration       = 0.783
        flowerTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.636, 1.65)
        
        let flowerOldAnim : CAAnimationGroup = QCMethod.group(animations: [flowerTransformAnim], fillMode:fillMode)
        layers["flower"]?.add(flowerOldAnim, forKey:"flowerOldAnim")
        
        ////Oval animation
        let ovalTransformAnim            = CABasicAnimation(keyPath:"transform")
        ovalTransformAnim.fromValue      = NSValue(caTransform3D: CATransform3DIdentity);
        ovalTransformAnim.toValue        = NSValue(caTransform3D: CATransform3DMakeScale(3, 2.4, 1));
        ovalTransformAnim.duration       = 0.777
        ovalTransformAnim.timingFunction = CAMediaTimingFunction(name:.easeInEaseOut)
        
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
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["flower"]!.animation(forKey: "flowerOldAnim"), theLayer:layers["flower"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["oval"]!.animation(forKey: "ovalOldAnim"), theLayer:layers["oval"]!)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "old"{
            layers["flower"]?.removeAnimation(forKey: "flowerOldAnim")
            layers["oval"]?.removeAnimation(forKey: "ovalOldAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            layer.removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func ovalPath() -> UIBezierPath{
        let ovalPath = UIBezierPath(ovalIn:CGRect(x: 0, y: 0, width: 111, height: 111))
        return ovalPath
    }
    
    
}


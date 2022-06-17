//
//  WaterAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/16.
//

import UIKit

class WaterAnimation: CALayer, CAAnimationDelegate {
    
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
                let totalDuration : CGFloat = 2.41
                let offset = oldAnimProgress * totalDuration
                self.timeOffset = CFTimeInterval(offset)
            }
        }
    }
    
    func setupProperties(){
        
    }
    
    func setupLayers(frame:CGRect){
            self.frame = frame
            iWidth = frame.width
            iHeight = frame.height
            
            let water = CALayer()
            water.anchorPoint     = CGPoint(x: 0.5, y: 1)
            water.frame           = CGRect(x: 0, y: iHeight, width: iWidth, height: 1.14)
            water.backgroundColor = UIColor(red:0.437, green: 0.823, blue:0.925, alpha:1).cgColor
            self.addSublayer(water)
            layers["water"] = water
            let path = CAShapeLayer()
            path.frame       = CGRect(x: 0.01, y: -36.5, width: iWidth, height: 38.21)
            path.fillColor   = UIColor(red:0.437, green: 0.823, blue:0.925, alpha:1).cgColor
            path.strokeColor = UIColor.black.cgColor
            path.lineWidth   = 0
            path.path        = pathPath().cgPath
            water.addSublayer(path)
            layers["path"] = path
            let path2 = CAShapeLayer()
            path2.isHidden    = true
            path2.frame       = CGRect(x: 0, y: 38.53, width: iWidth, height: 40.48)
            path2.fillColor   = UIColor(red:0.296, green: 0.65, blue:0.775, alpha:1).cgColor
            path2.strokeColor = UIColor.black.cgColor
            path2.lineWidth   = 0
            path2.path        = path2Path().cgPath
            water.addSublayer(path2)
            layers["path2"] = path2
            let path3 = CAShapeLayer()
            path3.isHidden    = true
            path3.frame       = CGRect(x: -81.05, y: 7.62, width: iWidth, height: 47.36)
            path3.fillColor   = UIColor(red:0.296, green: 0.65, blue:0.775, alpha:1).cgColor
            path3.strokeColor = UIColor.black.cgColor
            path3.lineWidth   = 0
            path3.path        = path3Path().cgPath
            water.addSublayer(path3)
            layers["path3"] = path3
            
            let rectangle = CAShapeLayer()
            rectangle.frame       = CGRect(x: 1, y: -1, width: iWidth, height: 180)
            rectangle.fillColor   = nil
            rectangle.strokeColor = UIColor(red:0.404, green: 0.404, blue:0.404, alpha:1).cgColor
            rectangle.lineWidth   = 2
            rectangle.path        = rectanglePath().cgPath
            self.addSublayer(rectangle)
            layers["rectangle"] = rectangle
        }
        
        
        
        //MARK: - Animation Setup
        
        func addOldAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
            if completionBlock != nil{
                let completionAnim = CABasicAnimation(keyPath:"completionAnim")
                completionAnim.duration = 2.63
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
            
            ////Water animation
            let waterBoundsAnim       = CABasicAnimation(keyPath:"bounds")
            waterBoundsAnim.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: iWidth, height: 1));
            waterBoundsAnim.toValue   = NSValue(cgRect: CGRect(x: 0, y: 0, width: iWidth, height: iHeight - 20));
            waterBoundsAnim.duration  = 2.06
            
            let waterOldAnim : CAAnimationGroup = QCMethod.group(animations: [waterBoundsAnim], fillMode:fillMode)
            layers["water"]?.add(waterOldAnim, forKey:"waterOldAnim")
            
            ////Path animation
            let pathPathAnim          = CAKeyframeAnimation(keyPath:"path")
            pathPathAnim.values       = [QCMethod.alignToBottomPath(path: pathPath(), layer:layers["path"]!).cgPath, QCMethod.alignToBottomPath(path: path2Path(), layer:layers["path"]!).cgPath, QCMethod.alignToBottomPath(path: path3Path(), layer:layers["path"]!).cgPath]
            pathPathAnim.keyTimes     = [0, 0.486, 1]
            pathPathAnim.duration     = 0.438
            pathPathAnim.repeatCount  = 3
            pathPathAnim.autoreverses = true
            
            let pathTransformAnim          = CAKeyframeAnimation(keyPath:"transform")
            pathTransformAnim.values       = [NSValue(caTransform3D: CATransform3DIdentity),
                 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeTranslation(2, 12, 0), CATransform3DMakeRotation(9 * CGFloat.pi/180, 0, -0, 1))),
                 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeTranslation(-3, 14, 0), CATransform3DMakeRotation(-7 * CGFloat.pi/180, -0, 0, 1)))]
            pathTransformAnim.keyTimes     = [0, 0.478, 1]
            pathTransformAnim.duration     = 0.788
            pathTransformAnim.beginTime    = 0.43
            pathTransformAnim.autoreverses = true
            
            let pathPositionAnim       = CABasicAnimation(keyPath:"position")
            pathPositionAnim.fromValue = NSValue(cgPoint: CGPoint(x: 75.351, y: -17.391));
            pathPositionAnim.toValue   = NSValue(cgPoint: CGPoint(x: 76.351, y: 60));
            pathPositionAnim.duration  = 1.19
            pathPositionAnim.beginTime = 1.22
            
            let pathOldAnim : CAAnimationGroup = QCMethod.group(animations: [pathPathAnim, pathTransformAnim, pathPositionAnim], fillMode:fillMode)
            layers["path"]?.add(pathOldAnim, forKey:"pathOldAnim")
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
                QCMethod.updateValueFromPresentationLayer(forAnimation: layers["water"]!.animation(forKey: "waterOldAnim"), theLayer:layers["water"]!)
                QCMethod.updateValueFromPresentationLayer(forAnimation: layers["path"]!.animation(forKey: "pathOldAnim"), theLayer:layers["path"]!)
            }
        }
        
        func removeAnimations(forAnimationId identifier: String){
            if identifier == "old"{
                layers["water"]?.removeAnimation(forKey: "waterOldAnim")
                layers["path"]?.removeAnimation(forKey: "pathOldAnim")
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
        
        func pathPath() -> UIBezierPath{
            let pathPath = UIBezierPath()
            pathPath.move(to: CGPoint(x: 1.326, y: 37.628))
            pathPath.addCurve(to: CGPoint(x: 3.239, y: 5.332), controlPoint1:CGPoint(x: -0.931, y: 24.693), controlPoint2:CGPoint(x: -0.315, y: 6.703))
            pathPath.addCurve(to: CGPoint(x: 38.084, y: 5.332), controlPoint1:CGPoint(x: 6.793, y: 3.962), controlPoint2:CGPoint(x: 16.214, y: -5.948))
            pathPath.addCurve(to: CGPoint(x: 73.297, y: 3.961), controlPoint1:CGPoint(x: 62.279, y: 17.812), controlPoint2:CGPoint(x: 35.93, y: 13.03))
            pathPath.addCurve(to: CGPoint(x: 113.518, y: 5.036), controlPoint1:CGPoint(x: 110.664, y: -5.108), controlPoint2:CGPoint(x: 102.33, y: 17.089))
            pathPath.addCurve(to: CGPoint(x: 142.677, y: 17.72), controlPoint1:CGPoint(x: 119.149, y: -1.029), controlPoint2:CGPoint(x: 132.805, y: 0.211))
            pathPath.addCurve(to: CGPoint(x: iWidth, y: 38.209), controlPoint1:CGPoint(x: iWidth, y: 31.471), controlPoint2:CGPoint(x: iWidth, y: -3.265))
            
            return pathPath
        }
        
        func path2Path() -> UIBezierPath{
            let path2Path = UIBezierPath()
            path2Path.move(to: CGPoint(x: 1.326, y: 39.817))
            path2Path.addCurve(to: CGPoint(x: 3.239, y: 3.063), controlPoint1:CGPoint(x: -0.931, y: 25.096), controlPoint2:CGPoint(x: -0.315, y: 4.623))
            path2Path.addCurve(to: CGPoint(x: 38.084, y: 3.063), controlPoint1:CGPoint(x: 6.793, y: 1.503), controlPoint2:CGPoint(x: 16.586, y: 14.454))
            path2Path.addCurve(to: CGPoint(x: 78.11, y: 6.161), controlPoint1:CGPoint(x: 59.581, y: -8.328), controlPoint2:CGPoint(x: 40.743, y: 16.482))
            path2Path.addCurve(to: CGPoint(x: 113.823, y: 3.063), controlPoint1:CGPoint(x: 115.476, y: -4.16), controlPoint2:CGPoint(x: 88.008, y: 11.294))
            path2Path.addCurve(to: CGPoint(x: 139.719, y: 6.161), controlPoint1:CGPoint(x: 121.792, y: 0.522), controlPoint2:CGPoint(x: 120.544, y: 13.025))
            path2Path.addCurve(to: CGPoint(x: iWidth, y: 40.479), controlPoint1:CGPoint(x: iWidth, y: 3.052), controlPoint2:CGPoint(x: iWidth, y: -6.722))
            
            return path2Path
        }
        
        func path3Path() -> UIBezierPath{
            let path3Path = UIBezierPath()
            path3Path.move(to: CGPoint(x: 1.326, y: 46.694))
            path3Path.addCurve(to: CGPoint(x: 3.239, y: 9.94), controlPoint1:CGPoint(x: -0.931, y: 31.974), controlPoint2:CGPoint(x: -0.315, y: 11.5))
            path3Path.addCurve(to: CGPoint(x: 39.599, y: 18.509), controlPoint1:CGPoint(x: 6.793, y: 8.38), controlPoint2:CGPoint(x: 18.102, y: 29.901))
            path3Path.addCurve(to: CGPoint(x: 82.193, y: 18.509), controlPoint1:CGPoint(x: 61.097, y: 7.118), controlPoint2:CGPoint(x: 44.826, y: 28.831))
            path3Path.addCurve(to: CGPoint(x: 121.831, y: 3.587), controlPoint1:CGPoint(x: 119.56, y: 8.188), controlPoint2:CGPoint(x: 96.016, y: 11.819))
            path3Path.addCurve(to: CGPoint(x: 141.943, y: 0.92), controlPoint1:CGPoint(x: 129.8, y: 1.046), controlPoint2:CGPoint(x: 122.768, y: 7.784))
            path3Path.addCurve(to: CGPoint(x: iWidth, y: 47.356), controlPoint1:CGPoint(x: iWidth, y: -2.189), controlPoint2:CGPoint(x: iWidth, y: 0.156))
            
            return path3Path
        }
        
        func rectanglePath() -> UIBezierPath{
            let rectanglePath = UIBezierPath(rect:CGRect(x: 0, y: 0, width: iWidth, height: iHeight))
            return rectanglePath
        }

    
    
}

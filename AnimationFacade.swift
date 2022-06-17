//
//  AnimationFacade.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/18.
//

import UIKit

class AnimationFacade: NSObject {
    func setViewMainAnimation(iType:Int,aLayer:CALayer,scale:Double = 1.0 ) -> CALayer? {
        print(#function)
         
        switch iType {
        case 60800:
            let bLayer = CALayer()
            bLayer.frame = CGRect(x: 25, y: 25, width: defaultSize.width * scale - 50 , height: defaultSize.height * scale - 50 )

            let ballAnim = LineMoveAnimation()
            ballAnim.frame = aLayer.frame
            ballAnim.setupLayers()
            ballAnim.addOldAnimation()
            bLayer.addSublayer(ballAnim)
            aLayer.addSublayer(bLayer)
        case 60801:
            let bLayer = CALayer()
            bLayer.frame = CGRect(x: 25, y: 25, width: (defaultSize.width) * scale - 50 , height: defaultSize.height * scale / 2 )
            
            let flyAnim = FlyAnimation()
            flyAnim.frame = aLayer.frame
            flyAnim.setupLayers()
            flyAnim.addAnimation()
            bLayer.addSublayer(flyAnim)
            aLayer.addSublayer(bLayer)
        case 60802:
            let bLayer = CALayer()
            //aLayer.borderColor = UIColor.red.cgColor
            //aLayer.borderWidth = 100
            bLayer.frame = CGRect(x: (defaultSize.width - 1100 ) * scale / 2, y: 0, width: 1100 * scale , height: 940  * scale)
    
            let heart = HeartAnimation()
            heart.frame = CGRect(x: 0, y: -100, width: 1100 * scale , height: 940 * scale)
            heart.setupLayers()
            heart.addOldAnimation()
    
            bLayer.addSublayer(heart)
            aLayer.addSublayer(bLayer)
            break
        case 60803:
            let fillMode : CAMediaTimingFillMode = .forwards
            let aLayerTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
                    aLayerTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                         NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeTranslation(0, 30, 0), CATransform3DMakeRotation(-30 * CGFloat.pi/180, -0, 0, 1)))]
                    aLayerTransformAnim.keyTimes = [0, 1]
                    aLayerTransformAnim.duration = 2.08
                    
                    let aLayerBoundsAnim       = CAKeyframeAnimation(keyPath:"bounds")
                    aLayerBoundsAnim.values    = [NSValue(cgRect: CGRect(x: 0, y: 0, width: defaultSize.width , height: defaultSize.height  )), NSValue(cgRect: CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height))]
                    aLayerBoundsAnim.keyTimes  = [0, 1]
                    aLayerBoundsAnim.duration  = 3.1
                    aLayerBoundsAnim.beginTime = 0.831
                    
                    let aLayerOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
                    aLayerOpacityAnim.values   = [0.2, 1]
                    aLayerOpacityAnim.keyTimes = [0, 1]
                    aLayerOpacityAnim.duration = 3.94
                    
                    let aLayerShadowColorAnim         = CAKeyframeAnimation(keyPath:"shadowColor")
                    aLayerShadowColorAnim.values      = [UIColor.black.cgColor,
                                                         UIColor.white.cgColor]
                    aLayerShadowColorAnim.duration    = 1.94
                    aLayerShadowColorAnim.beginTime   = 2
                    let aLayerShadowOpacityAnim       = CAKeyframeAnimation(keyPath:"shadowOpacity")
                    aLayerShadowOpacityAnim.values    = [0.33, 0.423]
                    aLayerShadowOpacityAnim.duration  = 1.94
                    aLayerShadowOpacityAnim.beginTime = 2
                    let aLayerShadowOffsetAnim        = CAKeyframeAnimation(keyPath:"shadowOffset")
                    aLayerShadowOffsetAnim.values     = [NSValue(cgSize: CGSize(width: 0, height: 3)),
                        NSValue(cgSize: CGSize(width: -5, height: -4))]
                    aLayerShadowOffsetAnim.duration   = 1.94
                    aLayerShadowOffsetAnim.beginTime  = 2
                    let aLayerShadowRadiusAnim        = CAKeyframeAnimation(keyPath:"shadowRadius")
                    aLayerShadowRadiusAnim.values     = [3, 2]
                    aLayerShadowRadiusAnim.duration   = 1.94
                    aLayerShadowRadiusAnim.beginTime  = 2
                    
                    let aLayerBorderColorAnim      = CAKeyframeAnimation(keyPath:"borderColor")
                    aLayerBorderColorAnim.values   = [UIColor(red:0.163, green: 0.263, blue:0.268, alpha:1).cgColor,
                                                      UIColor.white.cgColor]
                    aLayerBorderColorAnim.keyTimes = [0, 1]
                    aLayerBorderColorAnim.duration = 3.94
                    
                    let aLayerBorderWidthAnim       = CAKeyframeAnimation(keyPath:"borderWidth")
                    aLayerBorderWidthAnim.values    = [0, 40]
                    aLayerBorderWidthAnim.keyTimes  = [0, 1]
                    aLayerBorderWidthAnim.duration  = 3.25
                    aLayerBorderWidthAnim.beginTime = 0.681
                    
                    let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerTransformAnim, aLayerBoundsAnim, aLayerOpacityAnim, aLayerShadowColorAnim, aLayerShadowOpacityAnim, aLayerShadowOffsetAnim, aLayerShadowRadiusAnim, aLayerBorderColorAnim, aLayerBorderWidthAnim], fillMode:fillMode)
                    
                   aLayerUntitled1Anim.beginTime = 1 //insertTime.seconds == 0 ? 0.05: insertTime.seconds
                   aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
              break
 
        default:
            break
            
        }
        
        return aLayer
        
    }
    
    func setViewAnimation(iType:Int,aLayer:CALayer,usedBeginTime:Bool = false,beginTime:Double = 0.05 ) -> CALayer? {
        print(#function)
        print("Anim ID",iType,beginTime)
        print("Anim BeginTime",beginTime)
        var fireTime = 0.05
        if beginTime >= 0.05{
           fireTime = beginTime
        }
        switch iType {

        case 60051: //Animation 1
         
             
            
            let fillMode : CAMediaTimingFillMode = .forwards
            
            ////ALayer animation
            let aLayerOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
            aLayerOpacityAnim.values   = [0, 1]
            aLayerOpacityAnim.keyTimes = [0, 2]
            aLayerOpacityAnim.duration = 2
            
            let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerOpacityAnim], fillMode:fillMode)
            if usedBeginTime {
                aLayerUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
             aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
            break
        case 60052: //Animation 2
         
             
            let _diametr: CGFloat = 150
            let boundingRect = CGRect(x: -_diametr/2, y: -_diametr/2, width: _diametr, height: _diametr)
            let orbit = CAKeyframeAnimation()
            orbit.keyPath = "position"
       
            orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
            orbit.duration = 0.5
            orbit.isAdditive = true
            orbit.calculationMode = CAAnimationCalculationMode.paced
            orbit.rotationMode = CAAnimationRotationMode.rotateAuto
            //orbit.beginTime = insertTime.seconds == 0 ? 0.05: insertTime.seconds
            orbit.isRemovedOnCompletion = false
            if usedBeginTime {
                orbit.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(orbit, forKey: "redbox")
             
            break
        case 60053: //Animation 2
         
            
            let animation = CABasicAnimation.init(keyPath: "transform.scale")
            animation.toValue = NSNumber.init(value: 1.2)
            animation.duration = 1.0
                 //保持动画结束时候的状态
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
           // animation.beginTime = insertTime.seconds == 0 ? 0.05: insertTime.seconds
            if usedBeginTime {
                animation.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(animation, forKey: "scale")
             
            break
        case 60054: //Animation 4
         
            let animation = CAKeyframeAnimation.init(keyPath: "transform.rotation")
            let value1 = NSNumber.init(value: -Double.pi/180*15)
            let value2 = NSNumber.init(value: Double.pi/180*15)
            let value3 = NSNumber.init(value: -Double.pi/180*15)
            animation.values = [value1,value2,value3]
            animation.repeatCount = 3
            //animation.beginTime = insertTime.seconds == 0 ? 0.05: insertTime.seconds
             
            if usedBeginTime {
                animation.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(animation, forKey: "doudong")
             
            break
        case 60055: //Animation 5
         
            let fillMode : CAMediaTimingFillMode = .forwards
            let centerPoint = CGPoint(x: aLayer.frame.minX + aLayer.frame.width / 2, y: aLayer.frame.minY + aLayer.frame.height / 2)
                    ////ALayer animation
           let aLayerPositionAnim      = CAKeyframeAnimation(keyPath:"position")
            aLayerPositionAnim.values   = [NSValue(cgPoint: CGPoint(x: aLayer.frame.minX / 2 , y: -aLayer.frame.minY )), NSValue(cgPoint: centerPoint)]
           aLayerPositionAnim.keyTimes = [0, 1]
           aLayerPositionAnim.duration = 1
                    
           let aLayerOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
           aLayerOpacityAnim.values   = [0, 1]
           aLayerOpacityAnim.keyTimes = [0, 1]
            aLayerOpacityAnim.duration = 1.0
                    
            let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerPositionAnim, aLayerOpacityAnim], fillMode:fillMode)
           // aLayerUntitled1Anim.beginTime = 1
            if usedBeginTime {
                aLayerUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
             
             
            break
        
        case 60056://Anchor平移
            let fillMode : CAMediaTimingFillMode = .forwards
                    
            let aLayerAnchorPointAnim      = CAKeyframeAnimation(keyPath:"anchorPoint")
            aLayerAnchorPointAnim.values   = [NSValue(cgPoint: CGPoint(x: 1.5, y: 0.5)), NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))]
//            aLayerAnchorPointAnim.values   = [NSValue(cgPoint: CGPoint(x: -0.5, y: 0.5)), NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))]
            aLayerAnchorPointAnim.keyTimes = [0, 1]
            aLayerAnchorPointAnim.duration = 0.996
                    
            let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerAnchorPointAnim], fillMode:fillMode)
            if usedBeginTime {
                aLayerUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
             
           break
        
        
        case 60057://阴影
            let fillMode : CAMediaTimingFillMode = .forwards
                    
                    ////ALayer animation
            let aLayerShadowColorAnim        = CAKeyframeAnimation(keyPath:"shadowColor")
            aLayerShadowColorAnim.values     = [UIColor.black.cgColor,
                        UIColor(red:1.00, green: 0.00, blue:0.54, alpha:1.0).cgColor]
            aLayerShadowColorAnim.duration   = 1.9
            let aLayerShadowOpacityAnim      = CAKeyframeAnimation(keyPath:"shadowOpacity")
            aLayerShadowOpacityAnim.values   = [0.33, 0.8]
            aLayerShadowOpacityAnim.duration = 2
                    
            let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerShadowColorAnim, aLayerShadowOpacityAnim], fillMode:fillMode)
            if usedBeginTime {
                aLayerUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
             
            break
        case 60058://背景色
            let fillMode : CAMediaTimingFillMode = .forwards
                
                ////ALayer animation
            let aLayerBackgroundColorAnim      = CAKeyframeAnimation(keyPath:"backgroundColor")
            aLayerBackgroundColorAnim.values   = [aLayer.backgroundColor as Any,
                     UIColor(red:0.627, green: 0.0431, blue:0.925, alpha:1).cgColor]
            aLayerBackgroundColorAnim.keyTimes = [0, 1]
            aLayerBackgroundColorAnim.duration = 3.0
            
            let aLayerCornerRadiusAnim      = CAKeyframeAnimation(keyPath:"cornerRadius")
            aLayerCornerRadiusAnim.values   = [0, 50]
            aLayerCornerRadiusAnim.keyTimes = [0, 1]
            aLayerCornerRadiusAnim.duration = 2
                
            let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerBackgroundColorAnim,aLayerCornerRadiusAnim], fillMode:fillMode)
            if usedBeginTime {
                aLayerUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
             
            break
        case 60059://立起
            let fillMode : CAMediaTimingFillMode = .forwards
                    
                    ////Text animation
            let textTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.x")
            textTransformAnim.values   = [-100 * CGFloat.pi/180,
                         0]
            textTransformAnim.keyTimes = [0, 1]
            textTransformAnim.duration = 2
                    
            let textUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim], fillMode:fillMode)
            if usedBeginTime {
                textUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(textUntitled1Anim, forKey:"textUntitled1Anim")
        case 60060://圆角
            let fillMode : CAMediaTimingFillMode = .forwards

                    ////ALayer animation
            let aLayerCornerRadiusAnim      = CAKeyframeAnimation(keyPath:"cornerRadius")
            aLayerCornerRadiusAnim.values   = [0, aLayer.frame.width / 2]
            aLayerCornerRadiusAnim.keyTimes = [0, 1]
            aLayerCornerRadiusAnim.duration = 2

            
            
            
             
                    
                    ////ALayer animation
           let aLayerBorderWidthAnim      = CAKeyframeAnimation(keyPath:"borderWidth")
           aLayerBorderWidthAnim.values   = [0, aLayer.frame.width / 2]
           aLayerBorderWidthAnim.keyTimes = [0, 1]
           aLayerBorderWidthAnim.duration = 1
                    
           let aLayerBorderColorAnim      = CAKeyframeAnimation(keyPath:"borderColor")
            aLayerBorderColorAnim.values   = [aLayer.borderColor as Any,
                         UIColor.white.cgColor]
                    aLayerBorderColorAnim.keyTimes = [0, 1]
                    aLayerBorderColorAnim.duration = 1
                    
                    let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerBorderWidthAnim, aLayerBorderColorAnim,aLayerCornerRadiusAnim], fillMode:fillMode)
                if usedBeginTime {
                aLayerUntitled1Anim.beginTime = CFTimeInterval(fireTime)
               }
            aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
            
   
            
             
            break
//        case 60060://横向缩小到 1  , 5 ===> 0.1 可变为中心开花
//            let fillMode : CAMediaTimingFillMode = .forwards
//
//                    ////Text animation
//            let textTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
//            textTransformAnim.values   = [NSValue(caTransform3D: CATransform3DMakeScale(5, 1, 1)),
//                         NSValue(caTransform3D: CATransform3DIdentity)]
//            textTransformAnim.keyTimes = [0, 1]
//            textTransformAnim.duration = 0.4
//
//            let textUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim], fillMode:fillMode)
//            aLayer.add(textUntitled1Anim, forKey:"textUntitled1Anim")
//
//            break
            
        case 60061: //中心旋转
            let fillMode : CAMediaTimingFillMode = .forwards
                    
                    ////Text animation
            let textTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
            textTransformAnim.values   = [0,
                         -360 * CGFloat.pi/180]
            textTransformAnim.keyTimes = [0, 1]
            textTransformAnim.duration = 0.4
                    
            let textUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim], fillMode:fillMode)
            if usedBeginTime {
                textUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(textUntitled1Anim, forKey:"textUntitled1Anim")
             
            break
            
        case 60062://文字阴影
            
            let fillMode : CAMediaTimingFillMode = .forwards
            
            ////Text animation
            let textForegroundColorAnim       = CAKeyframeAnimation(keyPath:"foregroundColor")
            textForegroundColorAnim.values    = [UIColor.black.cgColor,
                 UIColor(red:0.276, green: 0.0881, blue:0.607, alpha:1).cgColor]
            textForegroundColorAnim.keyTimes  = [0, 1]
            textForegroundColorAnim.duration  = 1.8
            textForegroundColorAnim.beginTime = 0.2
            
            let textShadowOpacityAnim       = CAKeyframeAnimation(keyPath:"shadowOpacity")
            textShadowOpacityAnim.values    = [0.15, 0.75]
            textShadowOpacityAnim.duration  = 1.8
            textShadowOpacityAnim.beginTime = 0.23
            let textShadowOffsetAnim        = CAKeyframeAnimation(keyPath:"shadowOffset")
            textShadowOffsetAnim.values     = [NSValue(cgSize: CGSize(width: 0, height: 3)),
                NSValue(cgSize: CGSize(width: 3, height: 8))]
            textShadowOffsetAnim.duration   = 1.8
            textShadowOffsetAnim.beginTime  = 0.2
            
            let textUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [textForegroundColorAnim, textShadowOpacityAnim, textShadowOffsetAnim], fillMode:fillMode)
            if usedBeginTime {
                textUntitled1Anim.beginTime = CFTimeInterval(fireTime)
            }
            aLayer.add(textUntitled1Anim, forKey:"textUntitled1Anim")
             
            break
        default:
            print("")
          break
        }
        
        return aLayer
        
    }
    
    
    func makeTextAnimationLayer(str:String,frame:CGRect,font:UIFont,fontColor:UIColor,beginTime:Double = 0.05) -> TextOpacityAnimationLayer {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: fontColor,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: str, attributes: attributes)
        let size = attributedString.boundingRect(with: CGSize(width: frame.width, height: frame.height),
                                                 options: .usesLineFragmentOrigin,
                                                 context: nil).size
        let layer = TextOpacityAnimationLayer()
        layer.beginTime = beginTime
        layer.isGeometryFlipped = true
        layer.attributedText = attributedString
        layer.position = CGPoint(x: frame.width / 2 ,y: frame.height / 2)
        layer.bounds = CGRect(origin: CGPoint.zero, size: size )

        return layer
    }
    
     func bezierPathFrom(_ text: String,font:UIFont) -> UIBezierPath{
        let fontName = __CFStringMakeConstantString(font.fontName)
        let fontRef = CTFontCreateWithName(fontName!, (font.pointSize), nil)
        
        let attributedString = NSAttributedString(string: text, attributes: [.font : fontRef])
        let line = CTLineCreateWithAttributedString(attributedString as CFAttributedString)
        let allGlyphs = CTLineGetGlyphRuns(line)
        
        let paths = CGMutablePath()
        for glyphIndex in 0..<CFArrayGetCount(allGlyphs) {
            let singleGlyph = CFArrayGetValueAtIndex(allGlyphs, glyphIndex);
            let singleGlyphBits = unsafeBitCast(singleGlyph, to: CTRun.self)
            let ctFontName = unsafeBitCast(kCTFontAttributeName, to: UnsafeRawPointer.self)
            let runFont = CFDictionaryGetValue(CTRunGetAttributes(singleGlyphBits), ctFontName)
            let runFontBits = unsafeBitCast(runFont, to: CTFont.self)
            
            for i in 0..<CTRunGetGlyphCount(singleGlyphBits) {
                let range = CFRangeMake(i, 1)
                let glyph: UnsafeMutablePointer<CGGlyph> = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
                let position: UnsafeMutablePointer<CGPoint> = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
                glyph.initialize(to: 0)
                position.initialize(to: .zero)
                CTRunGetGlyphs(singleGlyphBits, range, glyph)
                CTRunGetPositions(singleGlyphBits, range, position);
 
                let path = CTFontCreatePathForGlyph(runFontBits, glyph.pointee, nil)
                if path != nil {
                    let transform = CGAffineTransform(translationX: position.pointee.x, y: position.pointee.y)
                    paths.addPath(path!, transform: transform)
                }
                
                glyph.deallocate()
                position.deallocate()
            }
        }
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.append(UIBezierPath(cgPath: paths))
        
        return bezierPath
    }
    
     

     func FlyAbc() ->CALayer {
         let aLayer = CALayer()
         aLayer.frame = CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height)
        
        // MARK: 矩形 动画部分
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 20, y: 300))       // 起点
        
        path.addLine(to: CGPoint(x: 40, y: 100))
        path.addLine(to: CGPoint(x: 80, y: 200))
        path.addLine(to: CGPoint(x: 150, y: 60))
        path.addLine(to: CGPoint(x: 200, y: 100))
        
        path.addLine(to: CGPoint(x: 340, y: 300))   // 右终点
        path.addLine(to: CGPoint(x: 20, y: 300))   // 闭圈
        
        let contentLayer = CALayer()
         contentLayer.frame = CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height)
        
        // 1: 画一个自下而上的渐变图
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.colors = [
            UIColor(red: 185 / 255.0, green: 185 / 255.0, blue: 200 / 255.0, alpha: 1).cgColor,
            UIColor(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0.01, 0.5]   // colors 元素的起点
        contentLayer.addSublayer(gradientLayer)
        
        // 2: 用贝塞尔构建的形状 贴住渐变图(图形以外不可见)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.green.cgColor
        contentLayer.mask = shapeLayer
        
       // aLayer.addSublayer(contentLayer)
        
        // Animation
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 1
        // toValue width 是 frame width的 2 倍，不然动画不完全 不知道为什么
        animation.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 680, height: 300))
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "bounds")
        
        
        // MARK: 滚动线条 部分
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: 20, y: 300))       // 起点
        linePath.addLine(to: CGPoint(x: 40, y: 100))
        
        linePath.addLine(to: CGPoint(x: 80, y: 200))
        linePath.addLine(to: CGPoint(x: 150, y: 60))
        linePath.addLine(to: CGPoint(x: 200, y: 100))
        linePath.addLine(to: CGPoint(x: 340, y: 300))   // 右终点
        
        let lineShapeLayer = CAShapeLayer()
        lineShapeLayer.path = linePath.cgPath
        lineShapeLayer.strokeColor = UIColor.red.cgColor
        lineShapeLayer.fillColor = nil
        lineShapeLayer.lineWidth = 1
       // aLayer.addSublayer(lineShapeLayer)
        
        // Animation
        let lineAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimation.duration = 1
        lineAnimation.fromValue = 0
        lineAnimation.toValue = 1
        lineAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        lineAnimation.fillMode = .forwards
        lineAnimation.autoreverses = false
        lineAnimation.isRemovedOnCompletion = false
        lineShapeLayer.add(lineAnimation, forKey: "strokeEnd")
        
        // MARK: 小圆点部分
        
        let circlePath = UIBezierPath()
        circlePath.move(to: CGPoint(x: 40, y: 100))
        circlePath.addArc(withCenter: CGPoint(x: 40, y: 100), radius: 10, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        circlePath.move(to: CGPoint(x: 80, y: 200))
        circlePath.addArc(withCenter: CGPoint(x: 80, y: 200), radius: 10, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        circlePath.move(to: CGPoint(x: 150, y: 60))
        circlePath.addArc(withCenter: CGPoint(x: 150, y: 60), radius: 10, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        circlePath.move(to: CGPoint(x: 200, y: 100))
        circlePath.addArc(withCenter: CGPoint(x: 200, y: 100), radius: 10, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        let circleShapeLayer = CAShapeLayer()
        circleShapeLayer.path = circlePath.cgPath
        circleShapeLayer.fillColor = UIColor(red: 185 / 255.0, green: 185 / 255.0, blue: 200 / 255.0, alpha: 1).cgColor
        circleShapeLayer.lineWidth = 1
       // aLayer.addSublayer(circleShapeLayer)
        
        // Animation
        let circleAnimation = CABasicAnimation(keyPath: "opacity")
        circleAnimation.duration = 1
        circleAnimation.fromValue = 0.3
        circleAnimation.toValue = 1
        circleAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        circleAnimation.fillMode = .forwards
        circleAnimation.autoreverses = false
        circleAnimation.isRemovedOnCompletion = false
        circleShapeLayer.add(circleAnimation, forKey: "opacity")

       // MARK: 小图标部分
         let carLayer: CALayer = CALayer()
        carLayer.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        carLayer.contents = UIImage.init(named: "Cupid")!.cgImage

        let carAnimation = CAKeyframeAnimation.init(keyPath: "position")
        carAnimation.path = linePath.cgPath
        carAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        carAnimation.duration = 6
        carAnimation.repeatCount = MAXFLOAT
        carAnimation.autoreverses = false
        carAnimation.calculationMode = .cubicPaced
        carAnimation.rotationMode = .rotateAuto
        aLayer.addSublayer(carLayer)
        carLayer.add(carAnimation, forKey: "carAnimation")
         
        return aLayer

    }
    
    
   
}

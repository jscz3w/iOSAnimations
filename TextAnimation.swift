//
//  TextAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/9.
//


import UIKit



class TextAnimation: CALayer, CAAnimationDelegate {
    
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = true
    var showText:String?
    var char_count: Int = 7
    
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
        
        let quartzcode = CALayer()
        quartzcode.frame = CGRect(x: 30, y: 30, width: 700, height: 100)
        self.addSublayer(quartzcode)
        layers["text"] = quartzcode
        
        let bPath = BezierPathFromString()
        
        
        var char_inx = 0.0
        var showChar = "Love"
        if let str = self.showText {
            showChar = str
        }
        //let str  = self.showText
        ///---遍历
        for character in showChar
        {
            print(character);
           // let quartzPath = bPath.transform(toBezierPath:  String(character)  )
            let quartzPath = bPath.transform(toBezierPath:  String(character)  )
            let quartz = CAShapeLayer()
            quartz.frame       = CGRect(x: 60 * char_inx, y: 22, width: 50, height: 71.8)
            quartz.fillColor   = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor
            quartz.strokeColor = UIColor(red:0.0571, green: 0.335, blue:0.495, alpha:1).cgColor
            quartz.lineWidth   = 2
            quartz.path        = quartzPath.cgPath
            quartzcode.addSublayer(quartz)
            layers["quartz\(char_inx)"] = quartz
            char_inx = char_inx + 1.0
        }
        
        
     
//        let quartz2 = CAShapeLayer()
//        quartz2.frame       = CGRect(x: 80 * char_inx, y: 22, width: 50, height: 40)
//        quartz2.fillColor   = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor
//        quartz2.strokeColor = UIColor(red:0.0571, green: 0.335, blue:0.495, alpha:1).cgColor
//        quartz2.lineWidth   = 2
//        quartz2.path        = quartz2Path().cgPath
//        quartzcode.addSublayer(quartz2)
//        layers["quartz2"] = quartz2
//        let quartz3 = CAShapeLayer()
//        quartz3.frame       = CGRect(x: 160, y: 22, width: 50, height: 40)
//        quartz3.fillColor   = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor
//        quartz3.strokeColor = UIColor(red:0.0571, green: 0.335, blue:0.495, alpha:1).cgColor
//        quartz3.lineWidth   = 2
//        quartz3.path        = quartz3Path().cgPath
//        quartzcode.addSublayer(quartz3)
//        layers["quartz3"] = quartz3
//        let quartz4 = CAShapeLayer()
//        quartz4.frame       = CGRect(x: 240, y: 22, width: 50, height: 40)
//        quartz4.fillColor   = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor
//        quartz4.strokeColor = UIColor(red:0.0571, green: 0.335, blue:0.495, alpha:1).cgColor
//        quartz4.lineWidth   = 2
//        quartz4.path        = quartz4Path().cgPath
//        quartzcode.addSublayer(quartz4)
//        layers["quartz4"] = quartz4
        
        

    }
    func setupLayers(txt:String){
    
       let text = CATextLayer()
       text.anchorPoint     = CGPoint(x: 0.5, y: 1)
       text.frame           = CGRect(x: 49.27, y: 95.61, width: 588.65, height: 176.05)
       text.opacity         = 0
       text.contentsScale   = UIScreen.main.scale
       text.string          = txt
       text.font            = "Helvetica" as CFTypeRef
       text.fontSize        = 62
       text.alignmentMode   = .center;
       text.foregroundColor = UIColor.black.cgColor
       text.isWrapped       = true
       self.addSublayer(text)
       layers["text"] = text
        
    }
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
                    let completionAnim = CABasicAnimation(keyPath:"completionAnim")
                    completionAnim.duration = 6.521
                    completionAnim.delegate = self
                    completionAnim.setValue("old", forKey:"animId")
                    completionAnim.setValue(false, forKey:"needEndAnim")
                    self.add(completionAnim, forKey:"old")
                    if let anim = self.animation(forKey: "old"){
                        completionBlocks[anim] = completionBlock
                    }
                }
                
                let fillMode : CAMediaTimingFillMode = .forwards
                
                ////Text animation
                let textStrokeEndAnim            = CABasicAnimation(keyPath:"strokeEnd")
                textStrokeEndAnim.fromValue      = 0;
                textStrokeEndAnim.toValue        = 1;
                textStrokeEndAnim.duration       = 1.08
                textStrokeEndAnim.timingFunction = CAMediaTimingFunction(name:.easeIn)
                textStrokeEndAnim.setValue(0.3, forKeyPath:"instanceDelay")
                textStrokeEndAnim.setValue(2, forKeyPath:"instanceOrder")
                
                let textFillColorAnim       = CABasicAnimation(keyPath:"fillColor")
                textFillColorAnim.fromValue = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor;
                textFillColorAnim.toValue   = UIColor(red:0.259, green: 0.663, blue:0.969, alpha:1).cgColor;
                textFillColorAnim.duration  = 1.51
                textFillColorAnim.beginTime = 1.08
                textFillColorAnim.setValue(0.1, forKeyPath:"instanceDelay")
                textFillColorAnim.setValue(2, forKeyPath:"instanceOrder")
                
                let textTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
                textTransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity),
                     NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.5, 1)),
                     NSValue(caTransform3D: CATransform3DMakeScale(0, 0, 1))]
                textTransformAnim.keyTimes       = [0, 0.428, 1]
                textTransformAnim.duration       = 1.51
                textTransformAnim.beginTime      = 2.6
                textTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.929, 1.66)
                textTransformAnim.autoreverses   = true
                textTransformAnim.setValue(0.1, forKeyPath:"instanceDelay")
                textTransformAnim.setValue(1, forKeyPath:"instanceOrder")
                
               let textOldAnim : CAAnimationGroup = QCMethod.group(animations: [textStrokeEndAnim, textFillColorAnim, textTransformAnim], fillMode:.both, forEffectLayer:true, sublayersCount:self.char_count)
               textOldAnim.beginTime = 0.2
               textOldAnim.repeatCount = Float.infinity
                QCMethod.addSublayersAnimation(anim: textOldAnim, key:"textOldAnim", layer:layers["text"]!)
        
              
              self.add(textOldAnim, forKey:"textOldAnim")
    }
    
    //MARK: - Animation Setup
        
        func addOldAnimationBig(completionBlock: ((_ finished: Bool) -> Void)? = nil){
            if completionBlock != nil{
                let completionAnim = CABasicAnimation(keyPath:"completionAnim")
                completionAnim.duration = 1.714
                completionAnim.delegate = self
                completionAnim.setValue("old", forKey:"animId")
                completionAnim.setValue(false, forKey:"needEndAnim")
                self.add(completionAnim, forKey:"old")
                if let anim = self.animation(forKey: "old"){
                    completionBlocks[anim] = completionBlock
                }
            }
            
            let fillMode : CAMediaTimingFillMode = .forwards
            
//            ////Text animation
//            let textTransformAnim            = CABasicAnimation(keyPath:"transform.scale.y")
//            textTransformAnim.fromValue      = 0;
//            textTransformAnim.toValue        = 1;
//            textTransformAnim.duration       = 0.971
//            textTransformAnim.beginTime      = 0.742
//            textTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.581, 1.28)
//
//            let textOpacityAnim       = CABasicAnimation(keyPath:"opacity")
//            textOpacityAnim.fromValue = 0;
//            textOpacityAnim.toValue   = 1;
//            textOpacityAnim.duration  = 0.685
//            textOpacityAnim.beginTime = 0.742
//
//            let textOldAnim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim, textOpacityAnim], fillMode:fillMode)
//            layers["text"]?.add(textOldAnim, forKey:"textOldAnim")
            
            ////Effect animation
             
            
           
            
            ////Text2 animation
//            let text2TransformAnim       = CABasicAnimation(keyPath:"transform")
//            text2TransformAnim.fromValue = NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(1, 0, 0), CATransform3DMakeRotation(180 * CGFloat.pi/180, 0, -0, 1)));
//            text2TransformAnim.toValue   = NSValue(caTransform3D: CATransform3DIdentity);
//            text2TransformAnim.duration  = 0.2
//            text2TransformAnim.setValue(0.1, forKeyPath:"instanceDelay")
//            text2TransformAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let text2OpacityAnim       = CABasicAnimation(keyPath:"opacity")
//            text2OpacityAnim.fromValue = 0;
//            text2OpacityAnim.toValue   = 1;
//            text2OpacityAnim.duration  = 0.2
//            text2OpacityAnim.setValue(0.1, forKeyPath:"instanceDelay")
//            text2OpacityAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let text2FillColorAnim       = CABasicAnimation(keyPath:"fillColor")
//            text2FillColorAnim.fromValue = UIColor.black.cgColor;
//            text2FillColorAnim.toValue   = UIColor(red:0.131, green: 0.826, blue:0.264, alpha:1).cgColor;
//            text2FillColorAnim.duration  = 0.2
//            text2FillColorAnim.beginTime = 0.272
//            text2FillColorAnim.setValue(0.08, forKeyPath:"instanceDelay")
//            text2FillColorAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let text2OldAnim : CAAnimationGroup = QCMethod.group(animations: [text2TransformAnim, text2OpacityAnim, text2FillColorAnim], fillMode:.both, forEffectLayer:true, sublayersCount:11)
//            QCMethod.addSublayersAnimation(anim: text2OldAnim, key:"text2OldAnim", layer:layers["text2"]!)
//
//            ////Effect2 animation
//            let effect2TransformAnim            = CABasicAnimation(keyPath:"transform")
//            effect2TransformAnim.fromValue      = NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.6, 1, 1), CATransform3DMakeTranslation(-20, 0, 0)));
//            effect2TransformAnim.toValue        = NSValue(caTransform3D: CATransform3DIdentity);
//            effect2TransformAnim.duration       = 0.3
//            effect2TransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.993, 1.72)
//            effect2TransformAnim.setValue(0.05, forKeyPath:"instanceDelay")
//            effect2TransformAnim.setValue(0, forKeyPath:"instanceOrder")
            
//            let effect2OldAnim : CAAnimationGroup = QCMethod.group(animations: [effect2TransformAnim], fillMode:.both, forEffectLayer:true, sublayersCount:14)
//            QCMethod.addSublayersAnimation(anim: effect2OldAnim, key:"effect2OldAnim", layer:layers["effect2"]!)
            
            ////Bigger animation
            let biggerTransformAnim            = CABasicAnimation(keyPath:"transform.scale.y")
            biggerTransformAnim.fromValue      = 1;
            biggerTransformAnim.toValue        = 3;
            biggerTransformAnim.duration       = 0.2
            biggerTransformAnim.timingFunction = CAMediaTimingFunction(name:.easeInEaseOut)
            biggerTransformAnim.repeatCount    = 3
            biggerTransformAnim.autoreverses   = true
            biggerTransformAnim.setValue(0.05, forKeyPath:"instanceDelay")
            biggerTransformAnim.setValue(2, forKeyPath:"instanceOrder")
            
            let biggerOldAnim : CAAnimationGroup = QCMethod.group(animations: [biggerTransformAnim], fillMode:.both, forEffectLayer:true, sublayersCount:self.char_count)
            biggerOldAnim.beginTime = 1.0
           // biggerOldAnim.repeatCount = Float.infinity
            
            QCMethod.addSublayersAnimation(anim: biggerOldAnim, key:"biggerOldAnim", layer:layers["text"]!)
            self.add(biggerOldAnim, forKey:"biggerOldAnim")
        }
        
    
    //MARK: - Animation Setup
        
        func addOldAnimationEffect(completionBlock: ((_ finished: Bool) -> Void)? = nil){
            if completionBlock != nil{
                let completionAnim = CABasicAnimation(keyPath:"completionAnim")
                completionAnim.duration = 1.714
                completionAnim.delegate = self
                completionAnim.setValue("old", forKey:"animId")
                completionAnim.setValue(false, forKey:"needEndAnim")
                self.add(completionAnim, forKey:"old")
                if let anim = self.animation(forKey: "old"){
                    completionBlocks[anim] = completionBlock
                }
            }
            
            let fillMode : CAMediaTimingFillMode = .forwards
            
//            ////Text animation
//            let textTransformAnim            = CABasicAnimation(keyPath:"transform.scale.y")
//            textTransformAnim.fromValue      = 0;
//            textTransformAnim.toValue        = 1;
//            textTransformAnim.duration       = 0.971
//            textTransformAnim.beginTime      = 0.742
//            textTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.581, 1.28)
//
//            let textOpacityAnim       = CABasicAnimation(keyPath:"opacity")
//            textOpacityAnim.fromValue = 0;
//            textOpacityAnim.toValue   = 1;
//            textOpacityAnim.duration  = 0.685
//            textOpacityAnim.beginTime = 0.742
//
//            let textOldAnim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim, textOpacityAnim], fillMode:fillMode)
//            layers["text"]?.add(textOldAnim, forKey:"textOldAnim")
//
//            ////Effect animation
//            let effectTransformAnim       = CABasicAnimation(keyPath:"transform")
//            effectTransformAnim.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(0.5, 0, 1));
//            effectTransformAnim.toValue   = NSValue(caTransform3D: CATransform3DIdentity);
//            effectTransformAnim.duration  = 0.3
//            effectTransformAnim.beginTime = 0.0903
//            effectTransformAnim.setValue(0.1, forKeyPath:"instanceDelay")
//            effectTransformAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let effectOldAnim : CAAnimationGroup = QCMethod.group(animations: [effectTransformAnim], fillMode:.both, forEffectLayer:true, sublayersCount:3)
//            QCMethod.addSublayersAnimation(anim: effectOldAnim, key:"effectOldAnim", layer:layers["effect"]!)
//
//
//
//            ////Text2 animation
//            let text2TransformAnim       = CABasicAnimation(keyPath:"transform")
//            text2TransformAnim.fromValue = NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(1, 0, 0), CATransform3DMakeRotation(180 * CGFloat.pi/180, 0, -0, 1)));
//            text2TransformAnim.toValue   = NSValue(caTransform3D: CATransform3DIdentity);
//            text2TransformAnim.duration  = 0.2
//            text2TransformAnim.setValue(0.1, forKeyPath:"instanceDelay")
//            text2TransformAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let text2OpacityAnim       = CABasicAnimation(keyPath:"opacity")
//            text2OpacityAnim.fromValue = 0;
//            text2OpacityAnim.toValue   = 1;
//            text2OpacityAnim.duration  = 0.2
//            text2OpacityAnim.setValue(0.1, forKeyPath:"instanceDelay")
//            text2OpacityAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let text2FillColorAnim       = CABasicAnimation(keyPath:"fillColor")
//            text2FillColorAnim.fromValue = UIColor.black.cgColor;
//            text2FillColorAnim.toValue   = UIColor(red:0.131, green: 0.826, blue:0.264, alpha:1).cgColor;
//            text2FillColorAnim.duration  = 0.2
//            text2FillColorAnim.beginTime = 0.272
//            text2FillColorAnim.setValue(0.08, forKeyPath:"instanceDelay")
//            text2FillColorAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let text2OldAnim : CAAnimationGroup = QCMethod.group(animations: [text2TransformAnim, text2OpacityAnim, text2FillColorAnim], fillMode:.both, forEffectLayer:true, sublayersCount:11)
//            QCMethod.addSublayersAnimation(anim: text2OldAnim, key:"text2OldAnim", layer:layers["text2"]!)
            
            ////Effect2 animation
            let effect2TransformAnim            = CABasicAnimation(keyPath:"transform")
            effect2TransformAnim.fromValue      = NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.6, 1, 1), CATransform3DMakeTranslation(-20, 0, 0)));
            effect2TransformAnim.toValue        = NSValue(caTransform3D: CATransform3DIdentity);
            effect2TransformAnim.duration       = 0.3
            effect2TransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.993, 1.72)
            effect2TransformAnim.setValue(0.05, forKeyPath:"instanceDelay")
            effect2TransformAnim.setValue(0, forKeyPath:"instanceOrder")
            
            let effect2OldAnim : CAAnimationGroup = QCMethod.group(animations: [effect2TransformAnim], fillMode:.both, forEffectLayer:true, sublayersCount:self.char_count)
            effect2OldAnim.beginTime = 1.0
            QCMethod.addSublayersAnimation(anim: effect2OldAnim, key:"effect2OldAnim", layer:layers["text"]!)
            
            self.add(effect2OldAnim, forKey:"effect2OldAnim")
        }
        


      func addOldAnimationTransform(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1.714
            completionAnim.delegate = self
            completionAnim.setValue("old", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            self.add(completionAnim, forKey:"old")
            if let anim = self.animation(forKey: "old"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : CAMediaTimingFillMode = .forwards
        
//            ////Text animation
//            let textTransformAnim            = CABasicAnimation(keyPath:"transform.scale.y")
//            textTransformAnim.fromValue      = 0;
//            textTransformAnim.toValue        = 1;
//            textTransformAnim.duration       = 0.971
//            textTransformAnim.beginTime      = 0.742
//            textTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.581, 1.28)
//
//            let textOpacityAnim       = CABasicAnimation(keyPath:"opacity")
//            textOpacityAnim.fromValue = 0;
//            textOpacityAnim.toValue   = 1;
//            textOpacityAnim.duration  = 0.685
//            textOpacityAnim.beginTime = 0.742
//
//            let textOldAnim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim, textOpacityAnim], fillMode:fillMode)
//            layers["text"]?.add(textOldAnim, forKey:"textOldAnim")
//
//            ////Effect animation
//            let effectTransformAnim       = CABasicAnimation(keyPath:"transform")
//            effectTransformAnim.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(0.5, 0, 1));
//            effectTransformAnim.toValue   = NSValue(caTransform3D: CATransform3DIdentity);
//            effectTransformAnim.duration  = 0.3
//            effectTransformAnim.beginTime = 0.0903
//            effectTransformAnim.setValue(0.1, forKeyPath:"instanceDelay")
//            effectTransformAnim.setValue(0, forKeyPath:"instanceOrder")
//
//            let effectOldAnim : CAAnimationGroup = QCMethod.group(animations: [effectTransformAnim], fillMode:.both, forEffectLayer:true, sublayersCount:3)
//            QCMethod.addSublayersAnimation(anim: effectOldAnim, key:"effectOldAnim", layer:layers["effect"]!)
//
//
//
          
                  
                  ////Text animation
                  let textTransformAnim            = CABasicAnimation(keyPath:"transform.scale.y")
                  textTransformAnim.fromValue      = 0;
                  textTransformAnim.toValue        = 1;
                  textTransformAnim.duration       = 0.971
                  textTransformAnim.beginTime      = 2
                  textTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.581, 1.28)
                  
                  let textOpacityAnim       = CABasicAnimation(keyPath:"opacity")
                  textOpacityAnim.fromValue = 0;
                  textOpacityAnim.toValue   = 1;
                  textOpacityAnim.duration  = 0.685
                  textOpacityAnim.beginTime = 2
                  
                  let textOldAnim : CAAnimationGroup = QCMethod.group(animations: [textTransformAnim, textOpacityAnim], fillMode:fillMode)
                  layers["text"]?.add(textOldAnim, forKey:"textOldAnim")

                 textOldAnim.beginTime = 1.2
                 
    
        
                 self.add(textOldAnim, forKey:"textOldAnim")
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
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["text"]!.animation(forKey: "quartzcodeOldAnim"), theLayer:layers["text"]!)
             
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "old"{
            layers["text"]?.removeAnimation(forKey: "quartzcodeOldAnim")
             
        }
    }
    
//    func removeAllAnimations(){
//        for layer in layers.values{
//            layer.removeAllAnimations()
//        }
//    }
    
    //MARK: - Bezier Path
    
    
    
    
    
//    func bezierPathFrom(string:String) -> UIBezierPath{
//
//        let paths = CGMutablePath()
//
//    let fontName = __CFStringMakeConstantString("SnellRoundhand")
//
//    let fontRef:AnyObject = CTFontCreateWithName(fontName!,18,nil)
//
//    let attrString = NSAttributedString(string: string,attributes: [kCTFontAttributeName as String : fontRef])
//
//    let line = CTLineCreateWithAttributedString(attrString as CFAttributedString)
//
//    let runA = CTLineGetGlyphRuns(line)
//
//    for (var runIndex = 0; runIndex < CFArrayGetCount(runA); runIndex++){
//
//    let run = CFArrayGetValueAtIndex(runA,runIndex);
//
//    let runb = unsafeBitCast(run,CTRun.self)
//
//    let CTFontName = unsafeBitCast(kCTFontAttributeName,UnsafePointer.self)
//
//    let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb),CTFontName)
//
//    let runFontS = unsafeBitCast(runFontC,CTFont.self)
//
//    let width = 400
//
//    var temp = 0
//
//    var offset:CGFloat = 0.0
//
//    for(var i = 0; i < CTRunGetGlyphCount(runb); i++){
//
//    let range = CFRangeMake(i,1)
//
//    let glyph:UnsafeMutablePointer = UnsafeMutablePointer.alloc(1)
//
//    glyph.initialize(0)
//
//    let position:UnsafeMutablePointer = UnsafeMutablePointer.alloc(1)
//
//    position.initialize(CGPointZero)
//
//    CTRunGetGlyphs(runb,range,glyph)
//
//    CTRunGetPositions(runb,position);
//
//    let temp3 = CGFloat(position.memory.x)
//
//    let temp2 = (Int) (temp3 / width)
//
//    let temp1 = 0
//
//    if(temp2 > temp1){
//
//    temp = temp2
//
//    offset = position.memory.x - (CGFloat(temp) * width)
//
//    }
//
//    let path = CTFontCreatePathForGlyph(runFontS,glyph.memory,nil)
//
//    let x = position.memory.x - (CGFloat(temp) * width) - offset
//
//    let y = position.memory.y - (CGFloat(temp) * 80)
//
//    var transform = CGAffineTransformMakeTranslation(x,y)
//
//    CGPathAddPath(paths,&transform,path)
//
//    glyph.destroy()
//
//    glyph.dealloc(1)
//
//    position.destroy()
//
//    position.dealloc(1)
//
//    }
//
//    }
//
//    let bezierPath = UIBezierPath()
//
//    bezierPath.moveToPoint(CGPointZero)
//
//    bezierPath.appendPath(UIBezierPath(CGPath: paths))
//
//    return bezierPath
//
//    }
    
    
}

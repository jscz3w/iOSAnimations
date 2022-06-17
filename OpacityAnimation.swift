//
//  OpacityAnimation.swift
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/16.
//

import UIKit

@IBDesignable
class OpacityAnimation: CALayer   {
    
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
        
    var animBeginTime:Int = 1
        
      
        
        
     
        
  
        
        //MARK: - Animation Setup
        
    func addUntitled1Animation(aLayer:CALayer,beginValue:Int,endValue:Int,completionBlock: ((_ finished: Bool) -> Void)? = nil){
            
            
            let fillMode : CAMediaTimingFillMode = .forwards
            
            ////ALayer animation
            let aLayerOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
            aLayerOpacityAnim.values   = [beginValue, endValue]
            aLayerOpacityAnim.keyTimes = [0, 2]
            aLayerOpacityAnim.duration = 2
            
            let aLayerUntitled1Anim : CAAnimationGroup = QCMethod.group(animations: [aLayerOpacityAnim], fillMode:fillMode)
     
           aLayer.add(aLayerUntitled1Anim, forKey:"aLayerUntitled1Anim")
 
        }
        
        
        
         
        
         
    

}

//
//  AnimationTool.swift
//  MobileHealth
//
//  Created by boeDev on 2019/3/20.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit
protocol AnimationDelegate:NSObjectProtocol {
    func animationComplete() -> ()
}
typealias AnimationCpmpleteOver = ()->()
class AnimationTool: NSObject,CAAnimationDelegate {
    static let shareInstence = AnimationTool.init()
    weak var m_pView:UIView? = nil
    weak var m_shapeLayer:CAShapeLayer?
    weak var delegate:AnimationDelegate?
    //reserve 相反的 参考DoitPushAnimator
    class func viewDisappearToPoint(view:UIView,_ point:CGPoint,_ reserve:Bool = false){
        AnimationTool.shareInstence.m_pView = view
//        let ani = CABasicAnimation.init(keyPath: "transform")
//        ani.fromValue =
        
        
        let center = point
        let path1 = UIBezierPath.init(arcCenter: center, radius: 0, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = path1.cgPath
        let h = view.frame.height
        let radius2 = sqrt(pow(h - center.x, 2) + pow(h - center.y, 2))
        let path2 = UIBezierPath.init(arcCenter: center, radius: radius2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let animation = CABasicAnimation.init(keyPath: "path")
        AnimationTool.shareInstence.m_shapeLayer = shapeLayer
        if (reserve){
            //点到view push
            animation.fromValue =  path1.cgPath
            animation.toValue = path2.cgPath
            //view.mask = shapeLayer
            view.layer.mask = shapeLayer
        }else{
            //view到点
            animation.fromValue =  path2.cgPath
            animation.toValue = path1.cgPath
            view.layer.mask = shapeLayer
        }
        animation.duration = 0.8
        animation.delegate = AnimationTool.shareInstence
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards

       animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault)
        shapeLayer.add(animation, forKey: "pushAnimation")
//        view.layer.add(animation, forKey: "myScale")
    }
    //动画1:椭圆到圆 动画2:位移
    func viewMoveToPoint(view:UIView,_ point:CGPoint,_ reserve:Bool = false,_ fSide:CGFloat){
        let OldFrame = view.frame
        
        let animationSpeed = kCAMediaTimingFunctionEaseOut
        let animationTime = 3.0
        let bRemoveOnComplete = false
        m_pView = view
        let path1 = UIBezierPath.init(ovalIn: view.bounds)
//         view.frame = newFrame
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = path1.cgPath
        let path2 = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: fSide, height: fSide))
        let animation = CABasicAnimation.init(keyPath: "path")
        AnimationTool.shareInstence.m_shapeLayer = shapeLayer
        animation.fromValue =  path1.cgPath
        animation.toValue = path2.cgPath
        animation.repeatCount = 1
        view.layer.mask = shapeLayer

        animation.duration = animationTime
        animation.delegate = AnimationTool.shareInstence
        animation.isRemovedOnCompletion = bRemoveOnComplete
        animation.fillMode = kCAFillModeForwards
        animation.setValue(view, forKey: "delegateView")
        animation.timingFunction = CAMediaTimingFunction.init(name: animationSpeed)
        shapeLayer.add(animation, forKey: nil)

        
        let animation1 = CABasicAnimation.init(keyPath: "transform.translation.y")
        let nFrom0 = Int(view.center.y)
        let nTo0 = Int(point.y)
        let nFrom = 0
        let nTo = nTo0 - nFrom0
        animation1.fromValue = NSNumber.init(value: nFrom)
        animation1.toValue = NSNumber.init(value: nTo)
        animation1.isRemovedOnCompletion = bRemoveOnComplete
        animation1.fillMode = kCAFillModeForwards
        animation1.duration = animationTime
        animation1.timingFunction = CAMediaTimingFunction.init(name: animationSpeed)
        animation1.repeatCount = 1
        animation1.setValue(view, forKey: "delegateView")
//      view.layer.add(animation1, forKey: "moveAnimation")
       
        let animation2 = CABasicAnimation.init(keyPath: "bounds")
       // let rtEnd = CGRect.init(x: 0, y: 0, width: fSide, height: fSide)
        let rtFix = CGRect.init(x: 0, y: 0, width: 48, height: 48)
        animation2.fromValue = NSValue.init(cgRect: view.bounds)
        animation2.toValue = NSValue.init(cgRect:rtFix )
        animation2.isRemovedOnCompletion = bRemoveOnComplete
        animation2.duration = animationTime
        animation2.fillMode = kCAFillModeForwards
        animation2.timingFunction = CAMediaTimingFunction.init(name: animationSpeed)
        animation2.setValue(view, forKey: "delegateView")
        
        let groupAnimation = CAAnimationGroup.init()
        groupAnimation.duration = animationTime
        groupAnimation.autoreverses = false
        groupAnimation.repeatCount = Float(NSNotFound)
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.animations = [animation1,animation2]
        groupAnimation.isRemovedOnCompletion = bRemoveOnComplete
        groupAnimation.repeatCount = 1
        groupAnimation.timingFunction = CAMediaTimingFunction.init(name: animationSpeed)
        view.layer.add(groupAnimation, forKey: "groupAnimation")
        let pMilkBubble = view as? MilkBubble
        
        pMilkBubble?.m_pBgLayer?.add(animation2, forKey: nil)
        pMilkBubble?.m_pBgLayer?.anchorPoint = CGPoint.init(x: 0, y: 0)
        pMilkBubble?.m_pBgLayer?.position = CGPoint.init(x: 0, y: 0)
        
        let animationPosition = CABasicAnimation.init(keyPath: "position")
        let OldPos = pMilkBubble?.m_pLabel.layer.position ?? CGPoint.init(x: OldFrame.size.width/2, y: OldFrame.size.height/2)
        animationPosition.fromValue = NSValue.init(cgPoint: OldPos)
        animationPosition.toValue = NSValue.init(cgPoint:CGPoint.init(x: fSide/2, y: fSide/2) )
        animationPosition.isRemovedOnCompletion = bRemoveOnComplete
        animationPosition.duration = animationTime
        animationPosition.timingFunction = CAMediaTimingFunction.init(name: animationSpeed)
        animationPosition.fillMode = kCAFillModeForwards
//        pMilkBubble?.m_pLabel.backgroundColor = UIColor.red
        pMilkBubble?.m_pLabel.layer.add(animationPosition, forKey: nil)
//        pMilkBubble?.m_pLabel.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
        pMilkBubble?.m_pLabel.layer.position = CGPoint.init(x: 0, y: 0)
        pMilkBubble?.m_pLabel.contentMode = .topLeft
        pMilkBubble?.m_pBoundLayer?.add(animation, forKey: nil)
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.animationComplete()
        let pView = anim.value(forKey: "delegateView") as? UIView
        let pDelegate = pView as? MilkBubble
        if pView != nil{
            pDelegate?.animationComplete()
        }
//        m_pView?.removeFromSuperview()
    }
}

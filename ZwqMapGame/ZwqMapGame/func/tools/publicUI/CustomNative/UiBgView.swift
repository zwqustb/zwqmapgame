//
//  UiBgView.swift
//  MobileHealth
//
//  Created by boeDev on 2019/11/6.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit
@IBDesignable
class UiBgView: UIView {
    var m_pGradientLayer = CAGradientLayer.init()
    //MARK:部分圆角
    //前四个为上下左右是否有圆角(1:有,0:没有),后俩个为圆角宽高
    @IBInspectable var corners: String {
        get {
            return "1,1,1,1,6,6"
        }
        set {
            let aryCorner = newValue.split(separator: ",")
            if aryCorner.count < 6 {
                return
            }
            var cornerType =  UIRectCorner.allCorners
            if aryCorner[0] == "0"{
                cornerType.remove(.topLeft)
            }
            if aryCorner[1] == "0"{
                cornerType.remove(.topRight)
            }
            if aryCorner[2] == "0"{
                cornerType.remove(.bottomLeft)
            }
            if aryCorner[3] == "0"{
                cornerType.remove(.bottomRight)
            }
            let f4 = CGFloat(Double(aryCorner[4]) ?? 0)
            let f5 = CGFloat(Double(aryCorner[5]) ?? 0)
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: cornerType, cornerRadii: CGSize.init(width: f4, height: f5))
            let mask = CAShapeLayer()
            mask.path = maskPath.cgPath
            self.layer.mask = mask
            layer.masksToBounds = true
            m_pGradientLayer.frame = self.bounds
            m_pGradientLayer.mask = mask
            self.layer.insertSublayer(m_pGradientLayer, at: 0)
        }
    }
    //MARK:阴影
    //入参内容 [阴影色,阴影宽,高,阴影透明度,阴影发散度]
    @IBInspectable var shadows: String {
        get {
            return ""
        }
        set {
            let aryEffects = newValue.split(separator: ",")
            if aryEffects.count < 5 {
                return
            }
            m_pGradientLayer.shadowColor = (UIColor.string(String(aryEffects[0]))).cgColor
            let fW = CGFloat(Double(aryEffects[1]) ?? 5)
            let fH = CGFloat(Double(aryEffects[2]) ?? 5)
            m_pGradientLayer.shadowOffset =  CGSize.init(width: fW, height: fH)
            let fOpacity = CGFloat(Double(aryEffects[3]) ?? 1)
            m_pGradientLayer.shadowOpacity = Float(fOpacity)
            let fRadius = CGFloat(Double(aryEffects[4]) ?? 10)
            m_pGradientLayer.shadowRadius = fRadius
            m_pGradientLayer.frame = self.bounds
            self.layer.insertSublayer(m_pGradientLayer, at: 0)
        }
    }
    //MARK:渐变色
    //入参内容:[渐变色数组,渐变location数组,渐变起始位置,渐变结束位置]
    @IBInspectable var gradients:String{
        get{
            return ""
        }
        set{
            let aryEffects = newValue.split(separator: ",")
            if aryEffects.count < 6 {
                return
            }
            let aryColorsStr = aryEffects[0].split(separator: "-")
            let aryCgColors = NSMutableArray.init()
            aryColorsStr.forEach({ (strColor) in
                aryCgColors.add(UIColor.string(String(strColor)).cgColor)
            })
            m_pGradientLayer.frame = self.bounds
            m_pGradientLayer.colors = aryCgColors as? [Any]
            let aryLocationStr  = aryEffects[1].split(separator: "-")
            let aryLocation = NSMutableArray.init()
            aryLocationStr.forEach({ (strLocation) in
                let fLoc = CGFloat(Double(strLocation) ?? 0)
                aryLocation.add(fLoc)
            })
            m_pGradientLayer.locations = aryLocation as? [NSNumber]
            let fW1 = CGFloat(Double(aryEffects[2]) ?? 0.5)
            let fH1 = CGFloat(Double(aryEffects[3]) ?? 0)
            m_pGradientLayer.startPoint =  CGPoint.init(x: fW1, y: fH1)
            let fW2 = CGFloat(Double(aryEffects[4]) ?? 0.5)
            let fH2 = CGFloat(Double(aryEffects[5]) ?? 1)
            m_pGradientLayer.endPoint = CGPoint.init(x: fW2, y: fH2)
            m_pGradientLayer.type = kCAGradientLayerAxial

            self.backgroundColor = .clear
            self.layer.insertSublayer(m_pGradientLayer, at: 0)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

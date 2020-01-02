//
//  UIView+IB.swift
//  biniu
//
//  Created by zhangwenqiang on 2018/5/18.
//  Copyright © 2018年 zhangwenqiang. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if newValue < 0 {
                let nRadius = round(self.frame.size.height)/2
                layer.cornerRadius = nRadius
            }else{
                layer.cornerRadius = newValue
            }
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    // 是不是分割线
    @IBInspectable var bLine: Bool{
        get {
            return false
        }
        set {
            if newValue {
                self.backgroundColor = UIColor.string("EAEDEE")
            }
        }
    }
  
    func addConstraintsSameFrame(_ contentView:UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }
    func addConstraintsSameCenter(_ contentView:UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .centerX,
                                            relatedBy: .equal, toItem: self, attribute: .centerX,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .centerY,
                                        relatedBy: .equal, toItem: self, attribute: .centerY,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //渐变色的类型
    @IBInspectable var GradientType: Int{
        get {
            return 0
        }
        set {
            self.addGradientLayer(newValue)
        }
    }
    @objc func addGradientLayer(_ newValue:Int){
        for pLayer in self.layer.sublayers ?? []{
            if pLayer is CAGradientLayer{
                pLayer.removeFromSuperlayer()
            }
        }
        switch newValue {
        case -1,4:
            //按钮不可点击的渐变色
            let gradientLayer = CAGradientLayer.init()
            gradientLayer.frame = self.bounds
            if newValue == -1{
                gradientLayer.colors = [UIColor(red: 0.39, green: 0.8, blue: 1, alpha: 0.5).cgColor, UIColor(red: 0.2, green: 0.72, blue: 0.96, alpha: 0.5).cgColor]
            }else{
                gradientLayer.colors = [
                    UIColor.string("63CDFF").cgColor,
                    UIColor.string("33B7F5").cgColor]
            }
            
            gradientLayer.locations=[0.0,1]
            gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0)
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.backgroundColor = UIColor.clear
            self.layer.shadowColor = UIColor.string("4AC2F9").cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize.init(width: 2, height: 2)
            self.clipsToBounds = true
            break
        case 1:
            //硬件连接界面的上半部分
            
            let gradientLayer = CAGradientLayer.init()
            gradientLayer.frame = CGRect.init(x: 0, y: 0, width: KScreenWidth, height: self.frame.size.height)
            gradientLayer.colors = [
                UIColor.string("45C4FF").cgColor,
                UIColor.string("02A4F0").cgColor]
            gradientLayer.locations=[0.0,1]
            gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0)
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.backgroundColor = UIColor.clear
            break
        case 2:
            //底部长条按钮的渐变色
            let gradientLayer = CAGradientLayer.init()
            gradientLayer.frame = CGRect.init(x: 0, y: 0, width: KScreenWidth-36, height: 44)
            gradientLayer.colors = [UIColor.string("33B7F5").cgColor,
                                    UIColor.string("62CDFF").cgColor]
            gradientLayer.locations=[0.0,1.0]
            gradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.backgroundColor = UIColor.clear
            break
        case 3:
            //底部短按钮的渐变色
            let gradientLayer = CAGradientLayer.init()
            gradientLayer.frame = CGRect.init(x: 0, y: 0, width: KScreenWidth/2, height: 52)
            //                gradientLayer.frame = self.bounds
            gradientLayer.colors = [UIColor.string("30B4F2").cgColor,
                                    UIColor.string("62CDFF").cgColor]
            gradientLayer.locations=[0.0,1.0]
            gradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.backgroundColor = UIColor.clear
            break
        default:
            break
        }
    }
    //显示和隐藏雪花条
    func showWaiting(){
        let watingView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        watingView.tag = 100
        self.addSubview(watingView)
        watingView.center = self.center
    }
    func stopWaiting(){
        for pView in self.subviews {
            if pView is UIActivityIndicatorView && pView.tag == 100 {
                pView.removeFromSuperview()
            }
        }
    }
    
    
    /// 部分圆角----兰文进
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func addCorner(byRoundingCorners corners: UIRectCorner, radius: CGFloat) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = shapeLayer
       
    }
    
    /// 加有圆角的边框----兰文进
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - lineWidth: 线宽
    ///   - strokeColor: 边框颜色
    ///   - fillColor: 填充色颜色
    func addBorderWithCorner(byRoundingCorners corners: UIRectCorner, lineWidth: CGFloat, strokeColor:UIColor, fillColor:UIColor) {
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: self.bounds.size)
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.lineCap = kCALineCapSquare
        layer.strokeColor  = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        self.layer.addSublayer(layer)
    }
    
}

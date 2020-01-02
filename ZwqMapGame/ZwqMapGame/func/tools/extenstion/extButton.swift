//
//  extButton.swift
//  MobileHealth
//
//  Created by boeDev on 2019/10/18.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit
enum eButtonStyle {
    case eSmallOvalBound
    case eSmallOvalFill
    case eDefault
}
extension UIButton {

    func setUIStyle(_ eStyle:eButtonStyle,_ aryGradient:[UIColor])  {
        switch eStyle {
        case .eSmallOvalBound:
            if aryGradient.count == 2 {
                self.layer.borderColor = aryGradient.first!.cgColor
                self.layer.borderWidth = 1
                self.layer.cornerRadius = 22
                self.layer.shadowColor = aryGradient.last!.cgColor
                self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 6
            }
            
            break
        case .eSmallOvalFill:
            let gradientLayer = CAGradientLayer.init()
            gradientLayer.frame = CGRect.init(x: 0, y: 0, width: 120, height: 44)
            //                gradientLayer.frame = self.bounds
            if aryGradient.count == 2{
            gradientLayer.colors = [aryGradient.first!.cgColor,
                                    aryGradient.last!.cgColor]
            }
            gradientLayer.locations=[0.0,0.0]
            gradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0.5)
            gradientLayer.cornerRadius = 22
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.layer.cornerRadius = 22
            self.backgroundColor = UIColor.clear
            break
        default:
            
            break
        }
    }

}

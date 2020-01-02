//
//  extImage.swift
//  MobileHealth
//
//  Created by zhangwenqiang on 2018/6/25.
//  Copyright © 2018年 Jiankun Zhang. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    static func initWithStr(_ pImgName:String)->UIImage?{
        let pImg = UIImage.init(named: pImgName)
        return pImg
    }
}
extension UIImageView {
    
     func setPath(_ strPath:String,_ defaultImageName:String){
        if defaultImageName == "" {
            self.image = nil
        }else{
            let img = UIImage.init(named: defaultImageName)
            if img != nil {
                self.image = img
            }
        }
        let strPathEncode = strPath.httpEncode()
        if strPathEncode != nil {
            let url = URL.init(string: strPathEncode!)
            if url != nil{
//                self.sd_setImage(with: url!, completed: nil)
            }

        }
    }
    
}
extension UIImage {
    //
    func cz_avatarImage(size: CGSize?, backColor: UIColor? = UIColor.white, linkColor: UIColor? = UIColor.lightGray) -> UIImage? {
        //
        var size = size
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        //
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        //
        backColor?.setFill()
        UIRectFill(rect)
        
        //
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        //
        draw(in: rect)
        
        //
        let ovalPath = UIBezierPath(ovalIn: rect)
        ovalPath.lineWidth = 2
        linkColor?.setStroke()
        ovalPath.stroke()
  
        //
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //
        UIGraphicsEndImageContext()
        
        return image
    }
}

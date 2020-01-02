//
//  extColor.swift
//  MobileHealth
//
//  Created by boeDev on 2018/9/3.
//  Copyright © 2018年 Jiankun Zhang. All rights reserved.
//

import UIKit
@objc extension UIColor{
    // string2color 6位是rgb 8位是rgba
    static func string(_ colorStr:String) -> UIColor {
        
        var color = UIColor.red
        var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            // let index = cStr.index(after: cStr.startIndex)
            cStr = cStr.substring(from: 1)
        }
        var alpha = CGFloat(1)
        if cStr.count == 8 {
            let strAlpha = cStr.substring(from: 6)
            let nAlpha = strAlpha.hex2Decimal()
            alpha = CGFloat(nAlpha)/255.0
            cStr = cStr.substring(to: 6)
        }
        if cStr.count != 6{
             return UIColor.black
        }
        
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = String(cStr[rRange])
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = String(cStr[gRange])
        
        // let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = cStr.substring(from: 4)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
        
        return color
    }
    //公用
    @objc class func appBlackColor()->UIColor{
        return UIColor.string("333E43")
    }
    @objc class func appLightBlackColor()->UIColor{
        return UIColor.string("989D9F")
    }
    //蓝色
    @objc class func appBlueColor()->UIColor{
        return UIColor.string("33B7F5")
    }
    @objc class func appBlueColor007CB6() ->UIColor{
        return UIColor.string("007CB6")
    }
    @objc class func appBlueColorE4F5FF() ->UIColor{
           return UIColor.string("E4F5FF")
       }
    @objc class func appBlueColor87D9FF() ->UIColor{
        return UIColor.string("87D9FF")
    }
    @objc class func appBlueColorAFD1E7() ->UIColor{
        return UIColor.string("AFD1E7")
    }
    
    @objc class func appBlueColor33AEE8() ->UIColor{
           return UIColor.string("33AEE8")
       }
    
    @objc class func appBlueColor69C9FA() ->UIColor{
           return UIColor.string("69C9FA")
       }
    
    @objc class func appBlueColorCCEFFF() ->UIColor{
        return UIColor.string("CCEFFF")
    }
    
    @objc class func appBlueColorCDDAE0() ->UIColor{
        return UIColor.string("CDDAE0")
    }
    
    @objc class func appBlueColor1FABEC() ->UIColor{
        return UIColor.string("1FABEC")
    }
    
    @objc class func appBlueColor36BEFF() ->UIColor{
           return UIColor.string("36BEFF")
       }
    
    @objc class func appBlueColor0CAFEF() ->UIColor{
              return UIColor.string("0CAFEF")
          
    }
    @objc class func appBlueColor1BA6E7() ->UIColor{
              return UIColor.string("1BA6E7")
          
    }
    @objc class func appBlueColor32CAF0() ->UIColor{
              return UIColor.string("32CAF0")
          
    }
    
    @objc class func appBlueColor38B8F4() ->UIColor{
                 return UIColor.string("38B8F4")
    }
    
    @objc class func appBlueColor57B3F7() ->UIColor{
                 return UIColor.string("57B3F7")
    }
    
    @objc class func appBlueColor6B95F6() ->UIColor{
                 return UIColor.string("6B95F6")
    }
    
    @objc class func appBlueColor8F96FF() ->UIColor{
                 return UIColor.string("8F96FF")
    }
    
    @objc class func appBlueColor27AEED() ->UIColor{
                 return UIColor.string("27AEED")
    }
    @objc class func appBlueColor0089FF() ->UIColor{
                    return UIColor.string("0089FF")
       
    }
    @objc class func appBlueColor31BDFF() ->UIColor{
                       return UIColor.string("31BDFF")
          
    }
    @objc class func appBlueColor31D9E9() ->UIColor{
                 return UIColor.string("31D9E9")
    }
    @objc class func appBlueColor34BEFF() ->UIColor{
                    return UIColor.string("34BEFF")
       }
    @objc class func appBlueColor5392F5() ->UIColor{
                 return UIColor.string("5392F5")
    }
    //绿色
    @objc class func appGreenColorB0E0DF() ->UIColor{
        return UIColor.string("B0E0DF")
    }
    @objc class func appGreenColor4BE053() ->UIColor{
           return UIColor.string("4BE053")
       }
    @objc class func appGreenColorD5F9F9() ->UIColor{
        return UIColor.string("D5F9F9")
    }
    @objc class func appGreenColor43DB32() ->UIColor{
        return UIColor.string("43DB32")
    }
    @objc class func appGreenColor17DB52() ->UIColor{
        return UIColor.string("17DB52")
    }
    
    @objc class func appGreenColorCDE0E9() ->UIColor{
           return UIColor.string("CDE0E9")
       
    }
    @objc class func appGreenColor3ECB74() ->UIColor{
              return UIColor.string("3ECB74")
          
    }
    
    @objc class func appGreenColor50D486() ->UIColor{
                 return UIColor.string("50D486")
             
       }
    @objc class func appGreenColor73E730() ->UIColor{
              return UIColor.string("73E730")
          
    }
    @objc class func appGreenColor57D668() ->UIColor{
        return UIColor.string("57D668")
    }
    @objc class func appGreenColor68ACFF() ->UIColor{
           return UIColor.string("68ACFF")
       }
    //红色
    @objc class func appRedColorFF6E5B() ->UIColor{
        return UIColor.string("FF6E5B")
    }
    @objc class func appRedColorFF0303() ->UIColor{
           return UIColor.string("FF0303")
       
    }
    
    @objc class func appRedColorFF876F() ->UIColor{
           return UIColor.string("FF876F")
       
    }
    @objc class func appRedColorFF6988() ->UIColor{
           return UIColor.string("FF6988")
       
    }
    
    @objc class func appRedColorFC6F87() ->UIColor{
              return UIColor.string("FC6F87")
          
       }
    @objc class func appRedColorF76B59() ->UIColor{
                 return UIColor.string("F76B59")
             
          }
    
    @objc class func appRedColorFF64BB() ->UIColor{
           return UIColor.string("FF64BB")
       
    }
    
    @objc class func appRedColorD091FF() ->UIColor{
           return UIColor.string("D091FF")
       
    }
    //橙色
    @objc class func appOrangeColorFD930F() ->UIColor{
           return UIColor.string("FD930F")
       
    }
    
    @objc class func appOrangeColorFFA73A() ->UIColor{
              return UIColor.string("FFA73A")
          
       }
    @objc class func appOrangeColorFFB24B() ->UIColor{
                 return UIColor.string("FFB24B")
             
          }
    @objc class func appOrangeColorFF9044() ->UIColor{
           return UIColor.string("FF9044")
       
    }
    //白色
    @objc class func appWhiteColorEDF1F3() ->UIColor{
        return UIColor.string("EDF1F3")
    }
    @objc class func appWhiteColorF6F7F8() ->UIColor{
        return UIColor.string("F6F7F8")
    }
    
    @objc class func appWhiteColorF7FBFD() ->UIColor{
        return UIColor.string("F7FBFD")
    }
    @objc class func appWhiteColorFFFFFF() ->UIColor{
        return UIColor.string("FFFFFF")
    }
    @objc class func appWhiteColorF3FBFF() ->UIColor{
        return UIColor.string("F3FBFF")
    }
    @objc class func appWhiteColorBFDBFF() ->UIColor{
        return UIColor.string("BFDBFF")
    }
    //灰色
    @objc class func appGrayColorEFEFEF() ->UIColor{
        return UIColor.string("EFEFEF")
    }
    @objc class func appGrayColor757575() ->UIColor{
        return UIColor.string("757575")
    }
    @objc class func appGrayColorF0F2F3() ->UIColor{
        return UIColor.string("F0F2F3")
    }
    @objc class func appGrayColorECEFF1() ->UIColor{
        return UIColor.string("ECEFF1")
    }
    @objc class func appGrayColorF8FBFC() ->UIColor{
           return UIColor.string("F8FBFC")
       }
    @objc class func appGrayColorF5F7FA() ->UIColor{
        return UIColor.string("F5F7FA")
    }
    //背景色
    @objc class func appLightWhite()->UIColor{
        return UIColor.string("F7F9FA")
    }
    class func appButtonGray()->UIColor{
        return UIColor.string("AAC7D4")
    }
    class func appLineColor()->UIColor{
        return UIColor.string("EAEDEE")
    }
    class func appNavBlue()->UIColor{
        return UIColor.string("0AA8F2")
    }
    class func appUnableBlue()->UIColor{
        return UIColor.string("B4E1F8")
    }
    class func appEnableBlue()->UIColor{
        return UIColor.string("5EB7F0")
    }
    //字体色
    class func appTextUnable()->UIColor{
        return UIColor.string("CBD0D2")
    }
    class func appTextYellow()->UIColor{
        return UIColor.string("F3A237")
    }
    class func appTextGreen()->UIColor{
        return UIColor.string("21D45F")
    }
    class func appTextBlank()->UIColor{
        return UIColor.string("404040")
    }
    class func appTextBlue()->UIColor{
        return UIColor.string("1C9FDC")
    }
    class func appFontLightBlack()->UIColor{
        return UIColor.string("666C6F")
    }
    class func appBufferWhite()->UIColor{
        return UIColor.string("BEC5C7")
    }
    //阴影色
    class func appShadow()->UIColor{
        return UIColor.string("AECBD9")
    }
    class func appYakunGray()->UIColor{
        return UIColor.string("A3A3A3")
    }
    class func appMask()->UIColor{
        return UIColor.string("AECBD940")
    }
    //4.0 颜色   主色调
    class func appMainTonal47() -> UIColor{
        return UIColor.string("478CF7")
    }
    //黑色
    class func appTextBlack2F() -> UIColor{
        return UIColor.string("2F2F2F")
    }
    
    class func appTextBlack5E() -> UIColor{
        return UIColor.string("5E5E5E")
    }
    
    class func appTextBlack99() -> UIColor{
        return UIColor.string("999999")
    }
    
    class func appTextGrayCC() -> UIColor{
        return UIColor.string("CCCCCC")
    }
    //分割线颜色
    class func appDividingLineE5() -> UIColor{
        return UIColor.string("E5E5E5")
    }
    //分割块背景色
    class func appSegmentationBlockBgF7() -> UIColor{
        return UIColor.string("F7F7F7")
    }
    //辅助色
    class func appAuxiliaryColor478CF7() -> UIColor{
        return UIColor.string("478CF7")
    }
    //辅助色
    class func appAuxiliaryColorE9F8FF() -> UIColor{
        return UIColor.string("E9F8FF")
    }
    //辅助色
    class func appAuxiliaryColor27() -> UIColor{
        return UIColor.string("27C2A3")
    }
    //辅助色
    class func appColorF7F7F7() -> UIColor{
        return UIColor.string("F7F7F7")
    }
    //橘黄
    class func appAuxiliaryColorF3() -> UIColor{
        return UIColor.string("F3A237")
    }
    class func appOrange() -> UIColor{
        return UIColor.string("FE9509")
    }
    //红色
    class func appAuxiliaryColorFF() -> UIColor{
        return UIColor.string("FF4646")
    }
    //深蓝
    class func appAuxiliaryColor40() -> UIColor{
        return UIColor.string("406183")
    }
    class func appAuxiliaryColor2D() -> UIColor{
        return UIColor.string("2DB3F2")
    }
    class func appAuxiliaryColor33() -> UIColor{
        return UIColor.string("33B7F5")
    }
}

//
//  extFont.swift
//  MobileHealth
//
//  Created by boeDev on 2018/9/3.
//  Copyright © 2018年 Jiankun Zhang. All rights reserved.
//

import UIKit

extension UIFont {
    class func appFontSize(_ nSize:CGFloat,bBold:Bool = false)->UIFont{
        var  strFontName = "PingFangSC-Regular"
        if bBold {
            strFontName = "PingFangSC-Medium"
        }
        return UIFont.init(name: strFontName, size: nSize)!
    }
    class func appFont(_ nFontSize:CGFloat,type:Int)->UIFont{
        var  strFontName = "PingFangSC-Regular"
        switch type {
        case 1:
            //汉字
            strFontName = "PingFangSC-Medium"
            break
        case 2:
            //数字和英文
            strFontName = "Helvetica"
            break
        case 3:
            //数字和英文
            strFontName = "Helvetica-Bold"
            break
        case 4:
            //中黑粗体
            strFontName = "PingFangSC-Semibold"
            break
        case 5:
            strFontName = "PingFangSC-Light"
            break
        case 6:
            //detail 的 日期
            strFontName = "Arial"
            break
        default:
            //汉字
            strFontName = "PingFangSC-Regular"
            break
        }
        return UIFont.init(name: strFontName, size: nFontSize) ?? UIFont.systemFont(ofSize:nFontSize)
    }
}

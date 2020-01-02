//
//  exUIImage.swift
//  MobileHealth
//
//  Created by lanwenjin on 2019/10/31.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import Foundation
extension UIImage {

    /// 获取网络图片尺寸
    /// - Parameter url: 网络图片链接
    /// - Returns: 图片尺寸size

    class func getImageSize(_ url: String?) -> CGSize {

        guard let urlStr = url else {
            return CGSize.zero
        }

        let tempUrl = URL(string: urlStr)
        let imageSourceRef = CGImageSourceCreateWithURL(tempUrl! as CFURL, nil)
        var width: CGFloat = 0
        var height: CGFloat = 0
        if let imageSRef = imageSourceRef {
            let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSRef, 0, nil)
            if let imageP = imageProperties {
                let imageDict = imageP as Dictionary
                width = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
                height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
            }
        }
        return CGSize(width: width, height: height)

    }

}

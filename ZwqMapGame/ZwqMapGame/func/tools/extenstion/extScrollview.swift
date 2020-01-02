//
//  extScrollview.swift
//  MobileHealth
//
//  Created by boeDev on 2019/7/24.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit

extension UIScrollView {
    //MARK:内容向上滑,展示下边的内容
    @objc func canScrollUp()->Bool{
        let frameH = self.frame.size.height
        let contentH = self.contentSize.height
        let offsetY = self.contentOffset.y
        if offsetY < contentH - frameH{
            return true
        }
        return false
    }
    @objc func scrollUp(_ fDistence:CGFloat){
        let frameH = self.frame.size.height
        let contentH = self.contentSize.height
        let offsetY = self.contentOffset.y
        var targetY = offsetY + fDistence
        let maxY = contentH - frameH
        if targetY > maxY{
            targetY = maxY
        }
        if targetY < 0{
            targetY = 0
        }
        let ptOffset = CGPoint.init(x: self.contentOffset.x, y: targetY)
        self.setContentOffset(ptOffset, animated: false)
    }
    @objc func scrollToBottom(_ bAnimation:Bool = false){
        let frameH = self.frame.size.height
        let contentH = self.contentSize.height
        let maxY = contentH - frameH
        let ptOffset = CGPoint.init(x: self.contentOffset.x, y: maxY)
        self.setContentOffset(ptOffset, animated: bAnimation)
    }
    //MARK:内容向下滑,展示上边的内容
    @objc func canScrollDown()->Bool{
        let offsetY = self.contentOffset.y
        if offsetY > 0{
            return true
        }
        return false
    }
    @objc func scrollDown(_ fDistence:CGFloat){
        let offsetY = self.contentOffset.y
        var targetY = offsetY - fDistence
        let minY = CGFloat(0)
        if targetY < minY{
            targetY = minY
        }
        let frameH = self.frame.size.height
        let contentH = self.contentSize.height
        let maxY = contentH - frameH
        if targetY > maxY{
            targetY = maxY
        }
        let ptOffset = CGPoint.init(x: self.contentOffset.x, y: targetY)
        self.setContentOffset(ptOffset, animated: false)
    }
    @objc func scrollToTop(){
        let minY = CGFloat(0)
        let ptOffset = CGPoint.init(x: self.contentOffset.x, y: minY)
        self.setContentOffset(ptOffset, animated: true)
    }
}

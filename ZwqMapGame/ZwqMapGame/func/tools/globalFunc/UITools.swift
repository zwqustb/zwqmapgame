//
//  UITools.swift
//  YouYiDian
//
//  Created by zhangwenqiang on 2017/12/19.
//  Copyright © 2017年 zhangwenqiang. All rights reserved.
//

import UIKit
let KScreenWidth = UIScreen.main.bounds.size.width
let KScreenHeight = UIScreen.main.bounds.size.height
let kStatusbarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavBarHeight = CGFloat(44)
let screenScale = KScreenWidth/375
let kTabBarHeight = CGFloat(kStatusbarHeight > 20 ? 83 : 49)
let kSafeareaBottomHeight = CGFloat(kStatusbarHeight > 20 ? 34 : 0)
let kViewY = kStatusbarHeight + kNavBarHeight
let UserData:Dictionary<String, Any> = UserDefaults.standard.object(forKey: "userData") as! Dictionary<String, Any>
//let kMainUserID:Stri3ng = kUserData()["userId"] == nil ? "" : kUserData()["userId"] as! String

func kIsLogined() -> Bool{
//    guard UserDefaults.standard.bool(forKey: "isLogin") != nil else {
//
//    }
    UserDefaults.standard.bool(forKey: "isLogin")
}
func getMainUserID() -> String{
    return kUserData()["userId"] == nil ? "" : kUserData()["userId"] as! String
}
func kUserData() -> Dictionary<String, Any>{
    guard UserDefaults.standard.object(forKey: "userData") != nil else {
        return Dictionary<String, Any>()
    }
    return UserDefaults.standard.object(forKey: "userData") as! Dictionary<String, Any>
}
func getNavHeight(_ bNavHidden:Bool)->CGFloat{
    let nTopH = UIApplication.shared.statusBarFrame.size.height
    if bNavHidden {
        return nTopH
    }else{
        return 44 + nTopH
    }
}
func getNavVC() -> UINavigationController {
    var pNav:UINavigationController? = nil
    let pVC = UIApplication.shared.keyWindow?.rootViewController
    if pVC is UINavigationController {
        pNav = pVC as? UINavigationController
    }else if pVC is UITabBarController{
        let pTabVC = pVC as! UITabBarController
        let pVC1 = pTabVC.selectedViewController
        if pVC1 is UINavigationController{
            pNav = pVC1 as? UINavigationController
        }
    }else{
        pNav = pVC?.navigationController
    }
    if pNav == nil {
        pNav = UINavigationController.init()
    }
    return pNav!
}

func pushView(_ pVC:UIViewController){
    let pNav = getNavVC()
    pNav.pushViewController(pVC, animated:true)
}
//打开pVC后把preViewName到pVC之间的vc全移掉
func pushView(_ pVC:UIViewController,preViewName:String){
    let pNav = getNavVC()
//    var aryVCs =  NSMutableArray.init(array: pNav.viewControllers)
     var aryVCs = pNav.viewControllers
    var nPreViewIndex = -1
    pNav.viewControllers.forEach { (pCurVC:UIViewController) in
      let pCurVCName  = NSStringFromClass(pCurVC.classForCoder)
        if pCurVCName.hasSuffix(preViewName) {
            nPreViewIndex =  pNav.viewControllers.index(of: pCurVC) ?? -1
        }
    }
    
    pNav.pushViewController(pVC, animated:true)
    if preViewName == ""{
        return
    }
    if nPreViewIndex >= 0{
        while aryVCs.count > nPreViewIndex + 1{
            let nRemoveVCIndex = nPreViewIndex + 1
            let pRemoveVC = aryVCs[nRemoveVCIndex]
            let pCurPreVCName  = NSStringFromClass((pRemoveVC as AnyObject).classForCoder)
            if !pCurPreVCName.hasSuffix(preViewName) {
                aryVCs.remove(at: nRemoveVCIndex)
            }
        }
    }
    aryVCs.append(pVC)
    pNav.setViewControllers(aryVCs , animated: false)
}
func presentView(_ pVC:UIViewController){
    let pNav = UITools.getTopestVC()
    pNav?.present(pVC, animated: true) {
        
    }
}

func setNavTitleColor(_ pColor:UIColor){
    let pNav = getNavVC()
    pNav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:pColor]
}
func showError(_ strError:String){
//    BOEProgressHUD.dismiss()
//    BOEProgressHUD.showError(withStatus: strError)
}
func showSuccess(_ strError:String){
//    BOEProgressHUD.dismiss()
//    BOEProgressHUD.showSuccess(withStatus: strError)
}
func showInfo(_ strError:String){
//    BOEProgressHUD.dismiss()
//    BOEProgressHUD.showInfo(withStatus: strError)
}
func showBlock(_ strTip:String){
//    BOEProgressHUD.showProgress(-1, status: strTip)
}
func dismissAlert(){
//    BOEProgressHUD.dismiss()
}
//func pushViewController(_ strVCName:String){
//    // 1.动态获取命名空间
//    guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else{
//        return;
//    }
//    // 2.根据字符串获取对应的Class并转成控制器的类型
//    guard let className = NSClassFromString(nameSpace + "." + strVCName)as? UIViewController.Type else{
//        return
//    }
//    let pVC = className.init()
//    let pNav = getNavVC()
//    pNav.pushViewController(pVC, animated:true)
//}
func popView(animation:Bool = true){
    let pNav = getNavVC()
    pNav.popViewController(animated: animation)
}
func popToView(_ strVC:String,animation:Bool = true){
    let pNav = getNavVC()
    for pVC in pNav.viewControllers{
        let str = NSStringFromClass(pVC.classForCoder)
        //let aryStr = str.split(separator: ".")
        if str.hasSuffix(strVC){
            pNav.popToViewController(pVC, animated: false)
        }
    }
}
func getVcByName(_ strVC:String)->UIViewController?{
    let pNav = getNavVC()
    for pVC in pNav.viewControllers{
        let str = NSStringFromClass(pVC.classForCoder)
        if str.hasSuffix(strVC){
            return pVC
        }
    }
    return nil
}
func showView(_ pVC:UIViewController){
    let pNav = getNavVC()
    pNav.pushViewController(pVC, animated:false)
}
func setNavHidden(_ bVisible:Bool){
    let pNav = getNavVC()
    pNav.isNavigationBarHidden = bVisible
    pNav.navigationBar.isHidden = bVisible
    pNav.navigationBar.isTranslucent = bVisible
}
func setNavTranslucent(_ bTranslucent:Bool){
    let pNav = getNavVC()
    pNav.isNavigationBarHidden = false
    pNav.navigationBar.isTranslucent = bTranslucent
    if bTranslucent {
        let pBgColor = UIColor.clear
        //如果以前设置过图片,这里必须先置空,再设置透明色
//        pNav.navigationBar.setBackgroundImage(nil, for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
//        pNav.navigationBar.shadowImage =  nil
//        pNav.navigationBar.setBackgroundImage(UIImage.from(color: pBgColor), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
//        pNav.navigationBar.shadowImage = UIImage.from(color: pBgColor)
    }else{
        pNav.navigationBar.setBackgroundImage(nil, for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
        pNav.navigationBar.shadowImage =  nil
    }
}
//func getClassNameOfAnyObject(object:Any)->String{
//    let mirror=Mirror(reflecting: object).description.replacingOccurrences(of: "Mirror for", with: "").trim()
//    return mirror
//}
@objcMembers
class UITools: NSObject {
    static let share = UITools.init()
    @objc class func setNavgationTranslucent(_ bTranslucent:Bool){
        setNavTranslucent(bTranslucent)
    }
    @objc class func popLastVC(){
        popView()
    }
    @objc class func popToHome(){
        let pNav = getNavVC()
        pNav.popToRootViewController(animated: false)
    }
    class func showVC(_ strVCName:String,_ xibName:String? = nil) {
        let pVC = LanguageTool.getVC(strVCName,xibName)
        if pVC != nil{
            pushView(pVC!)
        }
    }
    @objc class func pushVC(_ pVC:UIViewController,_ bAnimation:Bool = true){
        let pNav = getNavVC()
        pNav.pushViewController(pVC, animated:bAnimation)
    }
    //设置界面标题类型,0是深色,1是浅色
    @objc class func setTitleType(_ nType:Int) {
        let pNavVC = getNavVC()
        switch nType {
        case 0:
            pNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.appBlackColor(),NSAttributedString.Key.font:UIFont.init(name: "PingFangSC-Regular", size: 18)!]
            break
        default:
            pNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.init(name: "PingFangSC-Regular", size: 18)!]
            break
        }
    }
    class func alertInfo(_ pInfo:NSDictionary,callback:@escaping (_ index:Int,_ text:NSString)->()){
        let pVC = UITools.getTopestVC()
        if pVC == nil{
            return
        }
        UITools.alertInfo(pInfo, on: pVC!) { (index, text) in
            callback(index,text)
        }
    }
    class func alertInfo(_ pInfo:NSDictionary,on pVC:UIViewController,callback:@escaping (_ index:Int,_ text:NSString)->()){
        
        let pTitle = pInfo["title"] as? String ?? ""
        let pMsg = pInfo["message"] as? String ?? ""
        let pTextNum = pInfo["textNum"] as? NSString ?? "0"
        let pTextPlaceHolder = pInfo["textPlaceholder"] as? NSString ?? "请输入"
        let strOk = pInfo["OKText"] as? String ?? "确定"
        let strCancel = pInfo["CancelText"] as? String ?? "取消"
        let pAlert = UIAlertController.init(title: pTitle, message: pMsg, preferredStyle: UIAlertController.Style.alert)
        if pTextNum.intValue>0 {
            pAlert.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = pTextPlaceHolder as String
            }
        }
        let OKAction:UIAlertAction=UIAlertAction.init(title: strOk, style: UIAlertAction.Style.default) { (UIAlertAction) in
            let strText = pAlert.textFields?.last?.text ?? ""
            callback(0,strText as NSString)
        }
        let cancelAction:UIAlertAction=UIAlertAction.init(title: strCancel, style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            let strText = pAlert.textFields?.last?.text ?? ""
            callback(-1,strText as NSString)
        }
        if strOk != "nil" {
             pAlert.addAction(OKAction)
        }
        if strCancel != "nil" {
             pAlert.addAction(cancelAction)
        }
        pVC.present(pAlert, animated: true) {
            
        }
        //设置alertView的样式"attributedTitle",action:titleTextColor,titleTextAlignment
        let font = UIFont.init(name: "PingFangSC-Regular", size: 16)
        let dicMsgAttr = pInfo["messageAttr"] as? [NSAttributedString.Key : Any]
        var attrMsg = pMsg.str2AttributeString(["font":font!,"color":UIColor.string("333E43")])
        if dicMsgAttr != nil  {
            attrMsg = pMsg.str2AttrString(dicMsgAttr!)
        }
        pAlert.setValue(attrMsg, forKey: "attributedMessage")
        
        let attrTitle = pInfo["attrTitle"] as? NSAttributedString
        if attrTitle != nil {
            pAlert.setValue(attrTitle, forKey: "attributedTitle")
        }
        
        let titleTextColor = UIColor.string("33B7F5")
        let cancelTextColor = UIColor.string("989d9f")
        OKAction.setValue(titleTextColor, forKey: "titleTextColor")
        cancelAction.setValue(cancelTextColor, forKey: "titleTextColor")
    }
    
    // 获得清晰的二维码图片
    class func getImageInfocus(_ image:CIImage)->UIImage{
        let extent = image.extent.integral
        let size = CGFloat(2000.0)
        let scale = min(size/extent.width, size/extent.height)
        let width = extent.width*scale
        let height = extent.height*scale
        let cs = CGColorSpaceCreateDeviceGray();
        //        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.alphaInfoMask.rawValue | CGImageAlphaInfo.none.rawValue)
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let context = CIContext.init(options: nil)
        let bitmapImage = context.createCGImage(image, from: extent)
        // bitmapRef.se
        bitmapRef?.interpolationQuality = .high
        bitmapRef?.scaleBy(x: scale, y: scale)
        bitmapRef?.draw(bitmapImage!, in: extent)
        // 2.保存bitmap到图片
        let scaledImage = bitmapRef?.makeImage()
        return UIImage.init(cgImage:scaledImage!);
    }
    //设置back不生效,要尝试leftbaritem,可能有的代码被改了
    @objc class func getBackItem(_ bWhite:Bool = true)->UIBarButtonItem{
        let img = bWhite ? #imageLiteral(resourceName: "white_back") : #imageLiteral(resourceName: "back")
        let backItem = UIBarButtonItem.init(image: img.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(clickNavBack))
        return backItem
    }
    @objc class func clickNavBack(){
        popView()
    }
    //没登录,则跳转到登陆页
    @objc static func isLogin()->Bool{
//        if LogicTool.isLogin(){
//            return true
//        }else{
////            LQB  适配IOS 13
////            let pVC = LoginViewController.init()
////            let pNavVC = UINavigationController.init(rootViewController: pVC)
//            let pNav = getNavVC()
////            pNavVC.modalPresentationStyle = .fullScreen
////            pNav.present(pNavVC, animated: true) {
////            }
//
////            MGJRouter.openURL(LOGINVC, withUserInfo: [KEYNAVIGATION:pNav]) { (make) in
//
////            }
////            MGJRouter.openURL(LOGINVC, withUserInfo: [KEYNAVIGATION:pNav], completion: nil)
//
            return false
//        }
    }
    //获取标题label
    class func getTitleLabel(_ strTitle:String,FontColor:UIColor = UIColor.appBlackColor())->UILabel{
        let label = UILabel.init(frame:CGRect.init(x: 0, y: 0, width: KScreenWidth - 100, height: 40) )
        label.textColor = FontColor
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
//        label.isAppFont = 0
        return label
    }
    //获取最外层VC
    @objc class func getTopestVC()->UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
            // topController should now be your topmost view controller
        }
        return nil
    }
    //显示操作介绍图
    class func showGuideImg(_ pImgName:String,on pView:UIView) {
        let pImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
        pImg.image = UIImage.init(named: "iconBreathTeach", in: nil, compatibleWith: nil)
        pImg.contentMode = .scaleAspectFill
        pImg.isUserInteractionEnabled = true
        pImg.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapGuideImg(_:))))
        pView.addSubview(pImg)
    }
    @objc class func tapGuideImg(_ pGesture:UITapGestureRecognizer) {
        let pView = pGesture.view
        if pView is UIImageView{
            let pImgView = pView as! UIImageView
            pImgView.image = nil
        }
        pView?.removeFromSuperview()
    }
    //截屏
    class func captureScreen(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    //table foot
    class func getTableFoot()->UIView{
        let lTableFoot = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 60))
        lTableFoot.text = "已经显示全部内容"
        lTableFoot.textAlignment = .center
        lTableFoot.textColor = UIColor.appLightBlackColor()
        lTableFoot.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
       return lTableFoot
    }
}

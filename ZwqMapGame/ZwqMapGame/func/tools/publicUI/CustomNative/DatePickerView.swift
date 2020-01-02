//
//  DatePickerView.swift
//  MobileHealth
//
//  Created by boeDev on 2019/9/4.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit
@objc protocol DatePickerViewDelegate:NSObjectProtocol {
    func didDatePickerViewSelectOk(_ pView:DatePickerView,_ pDate:Date)
}
class DatePickerView: UIView {
    @IBOutlet weak var lTitle: UILabel!
    weak var  delegate:DatePickerViewDelegate?
    @IBOutlet weak var m_pDate: UILabel!
    @IBOutlet weak var m_pDatePicker: UIDatePicker!
    @IBAction func clickCancel(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func clickOK(_ sender: UIButton) {
      
        delegate?.didDatePickerViewSelectOk(self, m_pDatePicker.date)

    }
    class func showBy(_ pDelegate:Any,_ pMode:UIDatePickerMode ,_ defaultDate:Date,_ strTitle:String = "设置时间")->DatePickerView?{
        let pVC = UITools.getTopestVC()
        let pView = Bundle.main.loadNibNamed("DatePickerView", owner: nil, options: nil)?.first as? DatePickerView
        pView?.m_pDatePicker.datePickerMode = pMode
        pView?.m_pDatePicker.date = defaultDate
        pView?.lTitle.text = strTitle
        pView?.delegate = pDelegate as? DatePickerViewDelegate
        if pView != nil {
            pView?.frame = pVC!.view.bounds
            pVC!.view.addSubview(pView!)
        }
        return pView
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        let date = sender.date.timeIntervalSince1970
        let minDate = sender.minimumDate?.timeIntervalSince1970
        let maxDate = sender.maximumDate?.timeIntervalSince1970
        if minDate != nil && date < minDate! {
            sender.date = sender.minimumDate!
        }else if maxDate != nil && date > maxDate!{
            sender.date = sender.maximumDate!
        }
    }
}

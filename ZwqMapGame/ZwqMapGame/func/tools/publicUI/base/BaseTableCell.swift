//
//  BaseTableCell.swift
//  MobileHealth
//
//  Created by boeDev on 2019/7/4.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {
    weak var m_pTable:UITableView?
    
    //页面位置
    var position:NSString?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ dicData:NSDictionary){
        
    }
    func onCellSelected(){
        
    }
}

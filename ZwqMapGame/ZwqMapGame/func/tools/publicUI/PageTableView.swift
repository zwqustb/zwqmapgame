//
//  MoreTableView.swift
//  MobileHealth
//
//  Created by boeDev on 2018/9/27.
//  Copyright © 2018年 Jiankun Zhang. All rights reserved.
//

import UIKit
//分页table
@objcMembers
class PageTableView: UITableView {
    //不能为0
    var m_nPageSize = 20
    var m_cmdHttp = ""
    var m_dicParam = ["userId":"","pageNo":"1","pageSize":"20"]{
        didSet{
        }
    }
    var m_aryData = NSMutableArray.init()
    var m_bHasMore = true
    var m_bPullRefresh = true{
        didSet{
            if !m_bPullRefresh {
                self.mj_header = nil
            }
        }
    }
    var bGetType = true
    //数据总数
    var m_nTotalCount = -1
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.tableFooterView = UIView.init(frame: CGRect.zero)
        self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.m_dicParam["pageNo"] = "1"
            self.m_dicParam["userId"] = LogicTool.getUserId()
            self.refreshData()
        })
        self.separatorStyle = .none
//        self.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
//            let nCount = self.m_aryData.count
//            let indexPath = IndexPath.init(item: nCount, section: 0)
//            self.willDisplayCell(indexPath)
//        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func willDisplayCell(_ indexPath: IndexPath) {
        if indexPath.row >= m_aryData.count-1 {
            let nMultiple = m_aryData.count / m_nPageSize
            let nRemine = m_aryData.count % m_nPageSize
            m_dicParam["pageNo"] = "\(nMultiple+1)"
            m_dicParam["userId"] = LogicTool.getUserId()
            m_dicParam["pageSize"] = "\(m_nPageSize)"
            m_dicParam["sys"] = "mhealth"
            if nRemine == 0 && m_bHasMore{
                self.m_bHasMore = false
                if bGetType{
                    HttpTools.get(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                        if bRet{
                            self.handleHttpResult(dicRet)
                        }else{
                            //self.mj_footer.endRefreshingWithNoMoreData()
                        }
                    }
                }else{
                    HttpTools.post(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                        if bRet{
                            self.handleHttpResult(dicRet)
                        }else{
                        }
                    }
                }
                
            }else{
//                self.mj_footer.endRefreshing()
            }
        }else{
//            self.mj_footer.endRefreshing()
        }
    }
    func getHttpData(){
        self.getHttpData { (bRet, dicRet) in
        }
    }
    func getHttpData(callback:@escaping (_ bRet:Bool,_ dicRet:NSDictionary)->()){
        if m_aryData.count == 0 {
            if(bGetType){
                HttpTools.get(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                    if bRet{
                        self.handleHttpResult(dicRet)
                        callback(bRet,dicRet)
                    }
                }
            }else{
                HttpTools.post(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                    if bRet{
                        self.handleHttpResult(dicRet)
                        callback(bRet,dicRet)
                    }
                }
            }
        }else{
            self.reloadData()
        }
    }
    func refreshData(){
        if(bGetType){
            HttpTools.get(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                self.mj_header.endRefreshing()
                if bRet{
                    self.handleHttpResult(dicRet, bRefresh: true)
                }
            }
        }else{
            HttpTools.post(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                self.mj_header.endRefreshing()
                if bRet{
                    self.handleHttpResult(dicRet, bRefresh: true)
                }
            }
        }
    }
    //处理服务器返回的结果
    func handleHttpResult(_ dicRet:NSDictionary,bRefresh:Bool = false){
        var aryData = NSArray.init()
        let pAny = dicRet["data"]
        if pAny is NSArray {
            aryData = pAny as! NSArray
        }else if pAny is NSDictionary{
            let pDic = pAny as! NSDictionary
            m_nTotalCount = dicRet.getInt("totalCount")
            aryData = pDic["list"] as? NSArray ?? []
        }
        if aryData.count == self.m_nPageSize{
            self.m_bHasMore = true
        }else if aryData.count == 0{
            return
        }
        if bRefresh {
            self.m_aryData.removeAllObjects()
        }
        // aryData.forEach({ (pAny) in
        self.m_aryData.addObjects(from: aryData as! [Any])
        //})
        
        self.reloadData()
    }
    
}

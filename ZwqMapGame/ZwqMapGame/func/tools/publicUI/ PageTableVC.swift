//
//   PageTableVC.swift
//  MobileHealth
//
//  Created by boeDev on 2019/11/6.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

import UIKit

class PageTableVC: UITableViewController {
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
                        self.tableView.mj_header = nil
                    }
                }
            }
            var bGetType = true
            var bDeleteEnable = true
            //数据总数
            var m_nTotalCount = -1
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
                    self.tableView.reloadData()
                }
            }
            func refreshData(){
                if(bGetType){
                    HttpTools.get(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                        self.tableView.mj_header.endRefreshing()
                        if bRet{
                            self.handleHttpResult(dicRet, bRefresh: true)
                        }
                    }
                }else{
                    HttpTools.post(m_cmdHttp, m_dicParam) { (bRet, dicRet) in
                        self.tableView.mj_header.endRefreshing()
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
                
                self.tableView.reloadData()
            }
        
        //MARK:view life cicle
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "报告列表"
            self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    //        MilkServerData.getReportList { (bRet, dicRet) in
    //
    //        }
            self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
            self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                self.m_dicParam["pageNo"] = "1"
                self.m_dicParam["userId"] = LogicTool.getUserId()
                self.refreshData()
            })
            self.refreshData()
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return m_aryData.count
        }


        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let pImgView = UIImageView.init()
            pImgView.image = #imageLiteral(resourceName: "mine_arrow")
            cell.accessoryView = pImgView
            cell.accessoryView?.bounds = CGRect.init(x: 0, y: 0, width: 9, height: 15)
            let dicData = m_aryData[indexPath.row] as? NSDictionary ?? ["":""]
            cell.accessoryView?.bounds = CGRect.init(x: 0, y: 0, width: 9, height: 15)
            cell.textLabel?.text = dicData.getStr("createTime")
            cell.textLabel?.font = UIFont.appFont(15, type: 2)
            cell.textLabel?.textColor = UIColor.appTextBlack5E()
            return cell
        }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let dicData = m_aryData[indexPath.row] as? NSDictionary ?? ["":""]
            let detectionNo = dicData.getStr("detectionNo")
            MilkLocalData.shareInstence.m_strDetectionNo = detectionNo
            let strUrl = MilkLocalData.getH5Url(.report)
            let pVC = WebVC.init()
            pVC.pUrl = URL.init(string: strUrl)
            pushView(pVC)
        }
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            self.willDisplayCell(indexPath)
        }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 56
        }
        
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        


        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                showInfo("正在删除数据")
                let dicData = m_aryData[indexPath.row] as? NSDictionary ?? ["":""]
                let detectionNo = dicData.getStr("detectionNo")
                MilkServerData.delReport(["detectionNo" : detectionNo]) { (bRet, dicRet) in
                    if(bRet){
                        self.m_aryData.removeObject(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.m_bHasMore = true
                        self.refreshData()
                    }else{
                        showError("删除失败,请稍后重试")
                    }
                }
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        

        /*
        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        }
        */

        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the item to be re-orderable.
            return true
        }
        */

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

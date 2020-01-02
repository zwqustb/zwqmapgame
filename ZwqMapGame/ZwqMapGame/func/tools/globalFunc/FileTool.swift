//
//  FileTool.swift
//  MobileHealth
//
//  Created by boeDev on 2018/10/18.
//  Copyright © 2018年 Jiankun Zhang. All rights reserved.
//
import UIKit
func saveLog(_ strLog:String?)  {
    if strLog != nil && isTestApp(){
        FileTool.default.fileSaveLog(strLog!)
    }
}
class FileTool: NSObject {
    static let `default` = FileTool.init()
    var m_pUploadData = Data.init()
    //分界标识
    let boundaryStr="--"
    let boundaryID="haha"
    
    //上传文件的方法
    func uploadFileToHost(urlString:String,name:String,fileName:String,mimeType:String,paramters:String?,fileData:NSData, sucess :@escaping (Data?)->Void, failure :@escaping (Error?)->Void ){
        

    }
    //把log写入文件
    func fileSaveLog(_ strLog:String){
        //将内容同步写到文件中去（Caches文件夹下）
        let cachePath = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)[0]
        let logURL = cachePath.appendingPathComponent("log.txt")
        appendText(fileURL: logURL, string: "\(strLog)")
    }
    //在文件末尾追加新内容
    func appendText(fileURL: URL, string: String) {
        do {
        //如果文件不存在则新建一个
        if !FileManager.default.fileExists(atPath: fileURL.path) {
        FileManager.default.createFile(atPath: fileURL.path, contents: nil)}
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            let stringToWrite = "\n" + string
            
            //找到末尾位置并添加
            fileHandle.seekToEndOfFile()
            fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
            
        } catch let error as NSError {
            print("failed to append: \(error)")
        }
    }
    class func isFileExist(_ strPath:String)->Bool{
        let bExist = FileManager.default.fileExists(atPath: strPath)
        return bExist
    }
    class func isFolderExist(_ strPath:String)->Bool{
        var directoryExists = ObjCBool.init(false)
        let fileExists = FileManager.default.fileExists(atPath: strPath, isDirectory: &directoryExists)
        return fileExists && directoryExists.boolValue
    }
    class func createFolder(_ strPath:String){
        let url = URL.init(fileURLWithPath: strPath)
        let manager = FileManager.default
        let exist = manager.fileExists(atPath: strPath)
        if !exist {
            try! manager.createDirectory(at: url, withIntermediateDirectories: true,
                                         attributes: nil)
        }
    }
    class func getFolderList(_ strPath:String)->[String]?{
        let manager = FileManager.default
        let aryRet = try?manager.contentsOfDirectory(atPath: strPath)
        return aryRet
    }
    class func copyPath(_ strFrom:String, _ strTo:String){
        do{
            let manager = FileManager.default
            let urlFrom = URL.init(fileURLWithPath: strFrom)
            let urlTo = URL.init(fileURLWithPath: strTo)
            let bExist = manager.fileExists(atPath: strTo)
            if bExist {
                try manager.removeItem(at: urlTo)
            }
            try manager.copyItem(at: urlFrom, to: urlTo)
        }catch{
        }
    }
    class func deleteFile(_ strPath:String){
        let manager = FileManager.default
        let urlTo = URL.init(fileURLWithPath: strPath)
        let bExist = manager.fileExists(atPath: strPath)
        if bExist {
            try? manager.removeItem(at: urlTo)
        }
    }
    class func deleteForderMp3(){
        let path = "\(NSHomeDirectory())/Documents/sleepRecord"
        var documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        documentsUrl = URL.init(fileURLWithPath: path)
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                if fileURL.pathExtension == "mp3" {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
}

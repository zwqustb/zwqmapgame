//
//  SwiftToOcTool.m
//  MobileHealth
//
//  Created by boeDev on 2019/3/20.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

#import "OcFileTool.h"
//#import "AFNetworking.h"
@implementation OcFileTool
-(void)uploadFile:(NSURL*)fileUrl
         toServer:(NSString*)url
             with:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /* 本地图片上传 */
//        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"png"];
        NSData *imageData = [NSData dataWithContentsOfURL:fileUrl];
        
        // 直接将图片对象转成 data 也可以
        // UIImage *image = [UIImage imageNamed:@"test"];
        // NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        /* 上传数据拼接 */
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"test.png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"上传成功：%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"上传失败：%@", error);
    }];
}
-(void)downloadFileTo:(NSURL*)strFileUrl
           fromServer:(NSString*)strUrl
             with:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    
    /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载完成");
    }];
    [downloadTask resume];
}
@end

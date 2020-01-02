//
//  SwiftToOcTool.h
//  MobileHealth
//
//  Created by boeDev on 2019/3/20.
//  Copyright © 2019 Jiankun Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MobileHealth-Swift.h"
#import <UIKit/UIKit.h>
#import "CheckHealthModel.h"
@interface OcFileTool : NSObject
-(void)uploadFile:(NSString*)url
             with:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;
-(void)downloadFile:(NSString*)strUrl
               with:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;
@end



//
//  ToolController.h
//  PocketMedicine
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SloveBlock)(id obj);

@interface DataTool : NSObject

+(void)solveDataWithUrlStr:(NSString *)urlStr method:(NSString *)method postBody:(NSString *)postBody sloveBlock:(SloveBlock)sb;

@end

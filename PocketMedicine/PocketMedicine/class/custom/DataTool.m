//
//  ToolController.h
//  PocketMedicine
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "DataTool.h"
#import <UIKit/UIKit.h>
@implementation DataTool
static int flag = 0;
+(void)solveDataWithUrlStr:(NSString *)urlStr method:(NSString *)method postBody:(NSString *)postBody sloveBlock:(SloveBlock)sb
{
    //urlStr转成NSURL
    NSURL * url = [NSURL URLWithString:urlStr];
    
    //准备请求对象
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    if ([method isEqualToString:@"POST"]) {
        NSData * pragamData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:pragamData];
    }
    
    //建立连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            
            if (flag == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"快去检查你的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                flag++;
            }
            return ;
        }
    
      id tempObj = [NSJSONSerialization JSONObjectWithData:data options:
         (NSJSONReadingAllowFragments) error:nil];
        
        //调用block
        sb(tempObj);
        
    }];
}
@end

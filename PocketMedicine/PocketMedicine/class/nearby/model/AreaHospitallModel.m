//
//  AreaHospitallModel.m
//  asdf105
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AreaHospitallModel.h"

@implementation AreaHospitallModel

//没有发现key
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    NSLog(@"没有发现附件医院详情页的key:%@",key);

}

//打印
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", _hospitalName,_hospitalTel];
}



@end

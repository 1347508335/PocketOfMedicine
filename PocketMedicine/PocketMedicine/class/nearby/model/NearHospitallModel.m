//
//  NearHospitallModel.m
//  asdf105
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NearHospitallModel.h"

@implementation NearHospitallModel


//没发现key
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    NSLog(@"没有发现附件医院对应的key:%@",key);


}


//打印
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", _hospitalName,_hospitalAddress];
}



@end

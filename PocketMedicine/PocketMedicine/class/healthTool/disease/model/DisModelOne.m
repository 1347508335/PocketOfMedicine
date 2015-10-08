//
//  DisModelOne.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "DisModelOne.h"
#import "DiseaseModel.h"
#import "MJExtension.h"

@implementation DisModelOne

- (NSDictionary *)objectClassInArray{
    return @{@"twoType": [DiseaseModel class]};
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

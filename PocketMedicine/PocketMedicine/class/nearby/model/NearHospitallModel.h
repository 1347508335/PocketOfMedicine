//
//  NearHospitallModel.h
//  asdf105
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearHospitallModel : NSObject

//地址
@property(nonatomic,strong) NSString *hospitalAddress;
//参数
@property(nonatomic,strong) NSString *hospitalId;
//医院名称
@property(nonatomic,strong) NSString *hospitalName;
//图片
@property(nonatomic,strong) NSString *hospitalPic;
//电话
@property(nonatomic,strong) NSString *hospitalTel;



@end

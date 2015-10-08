//
//  AreaHospitallModel.h
//  asdf105
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaHospitallModel : NSObject

//医院名称
@property(nonatomic,strong) NSString *hospitalName;
//地址
@property(nonatomic,strong) NSString *hospitalAddress;
//电话
@property(nonatomic,strong) NSString *hospitalTel;
//路线
@property(nonatomic,strong) NSString *zenmozou;
//搜藏数目
@property(nonatomic,strong) NSString *favNum;
//纬度
@property(nonatomic,strong) NSString *lat;
//经度
@property(nonatomic,strong) NSString *lng;



//>>>>>>>>>>>>>>>>>>>>可能用上的可以不写的
@property(nonatomic,strong) NSString *provinceName;
@property(nonatomic,strong) NSString *cityName;



@end


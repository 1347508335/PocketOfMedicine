//
//  CommonDisController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "SecondCollectionViewCell.h"

@implementation SecondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (void)p_setup
{
    
    self.nameLabel = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, self.frame.size.width,25))];
    self.nameLabel.backgroundColor = [UIColor whiteColor];
    
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    //self.nameLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:self.nameLabel];
}


@end

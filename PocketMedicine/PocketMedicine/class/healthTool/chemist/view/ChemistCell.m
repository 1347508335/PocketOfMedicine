//
//  ChemistCell.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "ChemistCell.h"

@implementation ChemistCell

- (void)awakeFromNib {
    
    self.img4pic.layer.cornerRadius = 20;
    self.img4pic.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

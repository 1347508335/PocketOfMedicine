//
//  ToolController.h
//  PocketMedicine
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFAnimationViewController : UIViewController

- (void)didTapped:(NSInteger)index;

@end

@protocol EFItemViewDelegate <NSObject>

- (void)didTapped:(NSInteger)index;

@end




@interface EFItemView : UIButton

@property (nonatomic, weak) id <EFItemViewDelegate>delegate;

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title;

@end
//
//  ToolController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "ToolController.h"
#import "EFAnimationViewController.h"

@interface ToolController ()

@property (nonatomic, strong) EFAnimationViewController *viewController;
@end

@implementation ToolController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

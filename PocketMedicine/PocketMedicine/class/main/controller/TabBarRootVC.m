//
//  TabBarRootVC.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "TabBarRootVC.h"
#import "MineController.h"
#import "NearbyController.h"
#import "ToolController.h"
#import "MessageController.h"
#import "TDnavigationController.h"

@interface TabBarRootVC ()

@end

@implementation TabBarRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MessageController *messageVC = [[MessageController alloc]init];
    [self addChildViewWithController:messageVC title:@"资讯" image:@"zixun"];
    
    ToolController *toolVC = [[ToolController alloc]init];
    [self addChildViewWithController:toolVC title:@"工具" image:@"health"];
    
    NearbyController *neatbyVC = [[NearbyController alloc]init];
    [self addChildViewWithController:neatbyVC title:@"附近" image:@"nearby"];
    
    MineController *meVC = [[MineController alloc]init];
    [self addChildViewWithController:meVC title:@"我" image:@"me"];

    // Do any additional setup after loading the view.
}

- (void)addChildViewWithController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image{
    TDnavigationController *nVC = [[TDnavigationController alloc]initWithRootViewController:childVC];
    //字体能够自定义设置颜色
    nVC.tabBarItem.title = title;
    childVC.navigationItem.title = title;
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [nVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    //图像不被渲染成蓝色
    nVC.tabBarItem.image = [UIImage imageNamed:image];
//    nVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nVC];
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

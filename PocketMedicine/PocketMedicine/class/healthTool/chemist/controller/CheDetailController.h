//
//  CheDetailController.h
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheDetailController : UIViewController

@property (nonatomic, strong) NSString *myTitle;
@property (nonatomic,strong) NSString *myId;
@property (nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong) UIActivityIndicatorView * activityIndicatorView;

@end

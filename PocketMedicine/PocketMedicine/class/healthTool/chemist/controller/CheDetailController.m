//
//  CheDetailController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "CheDetailController.h"

#define kCheDetail @"http://phone.lkhealth.net/ydzx/business/apppage/assaydetail.html?&dataid=%@"

@interface CheDetailController ()<UIWebViewDelegate>

@end

@implementation CheDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.myTitle;
    
    [self setupView];
    [self getData];
}

- (void)setupView{
    self.webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    
    [self.activityIndicatorView setCenter: self.view.center] ;
    [self.activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    
    [self.view addSubview : _activityIndicatorView] ;
}

- (void)getData{
    NSString *urlStr = [NSString stringWithFormat:kCheDetail,self.myId];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alterview show];
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

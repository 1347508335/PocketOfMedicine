//
//  DisDetailController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "DisDetailController.h"

#define kDisDetail @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?&dataid=%@&datatype=0&isalbum="

@interface DisDetailController ()<UIWebViewDelegate>

@end

@implementation DisDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯详情";

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
    NSString *urlStr = [NSString stringWithFormat:kDisDetail,self.myId];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}


#pragma mark - UIWebViewDelegate
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

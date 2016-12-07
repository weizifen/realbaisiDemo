//
//  WZF_WebViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/24.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_WebViewController.h"
#import  <SafariServices/SafariServices.h>
@interface WZF_WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *beforeAge;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextAge;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reload;

@end

@implementation WZF_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"111%@",self.url);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)before:(id)sender {
    [self.webView goBack];
}
- (IBAction)next:(id)sender {
    [self.webView goForward];
}

- (IBAction)reload:(id)sender {
    [self.webView reload];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.beforeAge.enabled=YES;
    self.nextAge.enabled=YES;
    
}
@end

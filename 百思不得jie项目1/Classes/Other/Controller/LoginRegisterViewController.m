//
//  LoginRegisterViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/21.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@property (weak, nonatomic) IBOutlet UIButton *regester;
@property (weak, nonatomic) IBOutlet UIButton *qiehuanwenzi;


@end
//因为很多地方都要用到登录 所以写在这里
@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //将登录框框设置成椭圆
    self.loginButton.layer.cornerRadius=5;
    self.loginButton.layer.masksToBounds=YES;
    
    self.regester.layer.cornerRadius=5;
    self.regester.layer.masksToBounds=YES;
}
//注册账号
- (IBAction)regester:(UIButton *)sender {
   
    //设置这句的目的是:如果登录框的键盘是弹出状态 ,则切换到注册界面的时候弹回去
    [self.view endEditing:YES];
    
   //刚点下去那一刻没有值
    //如果有值
    if (self.leftMargin.constant) {
        self.leftMargin.constant=0;
        self.regester.selected=NO;
        [self.qiehuanwenzi setTitle:@"注册账号" forState:UIControlStateNormal];
        
    }else
    {
        self.leftMargin.constant=-self.view.wzf_width;
        self.regester.selected=YES;
 [self.qiehuanwenzi setTitle:@"已有账号?" forState:UIControlStateNormal];
    }
    
    
    //设置过场动画
    [UIView animateWithDuration:0.5 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];

}




-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

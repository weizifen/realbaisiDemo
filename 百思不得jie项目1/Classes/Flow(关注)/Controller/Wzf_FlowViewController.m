//
//  Wzf_FlowViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "Wzf_FlowViewController.h"
#import "Wzf-RecommendFollowViewController.h"
#import "LoginRegisterViewController.h"
@interface Wzf_FlowViewController ()

@end

@implementation Wzf_FlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RandomColor;
    
    //设置导航栏标题
    self.navigationItem.title=@"我的关注";
    //设置导航栏左侧
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [btn.self sizeToFit];
    [btn addTarget:self action:@selector(flow) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
}








- (IBAction)loginAndRegister:(id)sender {
    LoginRegisterViewController*vc=[[LoginRegisterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (void)flow{
    Wzf_RecommendFollowViewController*vc=[[Wzf_RecommendFollowViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

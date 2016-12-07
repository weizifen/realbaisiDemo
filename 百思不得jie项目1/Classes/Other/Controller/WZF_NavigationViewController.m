//
//  WZF_NavigationViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_NavigationViewController.h"

@interface WZF_NavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WZF_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //手势识别器 ---因为手动设置的左上角按钮 .所以要重新设置
    self.interactivePopGestureRecognizer.delegate=self;
    
    //设置导航栏背景  ,让其不会一卡一卡的
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
  
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    wzfNSlog
    //刚要穿进去那一刻
    if (self.childViewControllers.count>0) {
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        //    设置偏移 ,使左上角按钮更符合审美
        btn.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0,0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
        //影藏底部工具条
        viewController.hidesBottomBarWhenPushed=YES;
    }
   
    
    
//    这边传进去
    [super pushViewController:viewController animated:animated];



}
-(void)back{
    
    [self popViewControllerAnimated:YES];
}



/**
 手势识别器调用这个代理方法决定手势是否有效

 @param gestureRecognizer <#gestureRecognizer description#>

 @return 返回YES有效反之无效
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//    if (self.childViewControllers.count==1) {
//        return NO;
//    }
//    return YES;
    return self.childViewControllers.count>1;
}
@end

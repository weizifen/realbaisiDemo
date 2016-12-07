//
//  WzfViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/19.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WzfViewController.h"
#import "wzfTabBar.h"
#import "Wzf_MeViewController.h"
#import "Wzf_NewViewController.h"
#import "Wzf_FlowViewController.h"
#import "Wzf_EssenceViewController.h"
#import "WZF_NavigationViewController.h"
@interface WzfViewController ()

@end

@implementation WzfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UITabBarItem*bar=[UITabBarItem appearance];
    NSMutableDictionary*nonrmaldict=[NSMutableDictionary dictionary];
    nonrmaldict[NSFontAttributeName]= [UIFont systemFontOfSize:14];
    nonrmaldict[NSForegroundColorAttributeName]=[UIColor grayColor];
    [bar setTitleTextAttributes:nonrmaldict forState:UIControlStateNormal];
    NSMutableDictionary*selected=[NSMutableDictionary dictionary];
    selected[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    [bar setTitleTextAttributes:selected forState:UIControlStateSelected];
    [bar setTitleTextAttributes:selected forState:UIControlStateSelected];
    
    //将上面部分提取
    [self setupSunController:[[WZF_NavigationViewController alloc]initWithRootViewController:[[Wzf_EssenceViewController alloc]init]] andTitle:@"精华" andImage:@"tabBar_essence_icon" andSelect:@"tabBar_essence_click_icon"];
    [self setupSunController: [[WZF_NavigationViewController alloc]initWithRootViewController:[[Wzf_NewViewController alloc]init]] andTitle:@"新帖" andImage:@"tabBar_new_icon" andSelect:@"tabBar_new_click_icon"];

    [self setupSunController:[[WZF_NavigationViewController alloc]initWithRootViewController:[[Wzf_FlowViewController alloc]init]] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelect:@"tabBar_friendTrends_click_icon"];
    [self setupSunController:[[WZF_NavigationViewController alloc]initWithRootViewController:[[Wzf_MeViewController alloc]init]]
 andTitle:@"我" andImage:@"tabBar_me_icon" andSelect:@"tabBar_me_click_icon"];
    //更换tabbar
//    self.tabBar=[[wzfTabBar alloc]init];   只读  只能通过另外一种方式了
    
    
    [self setValue:[[wzfTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
    
    
//    self.tabBar.delegate=self;---设置点击状态栏刷新, 但是tarbar不能成为自己的代理 ,他的代理已经是'Changing the delegate of a tab bar managed by a tab bar controller is not allowed.'

    


}



/**
 <#Description#>

 @param vc           设置自己想要的控制器
 @param title        设置标签栏文字
 @param image        设置标签栏图片
 @param selectedimge 设置选中标签栏图片
 */
-(void)setupSunController:(UIViewController*)vc andTitle:(NSString*)title andImage:(NSString*)image andSelect:(NSString*)selectedimge
{
    vc.tabBarItem.title=title;
    vc.tabBarItem.selectedImage=[UIImage imageNamed:image];
    vc.tabBarItem.image=[UIImage imageNamed:selectedimge];
    [self addChildViewController:vc];
}



@end

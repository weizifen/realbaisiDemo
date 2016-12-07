//
//  AppDelegate.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/19.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "AppDelegate.h"
#import "WzfViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>
/** 记录上一次选中的子控制器的索引 */
@property (nonatomic, assign) NSUInteger lastSelectedIndex;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口
    self.window=[[UIWindow alloc]init];
    self.window.frame=[UIScreen mainScreen].bounds;
//    创建控制器
    WzfViewController*vc=[[WzfViewController alloc]init];
    vc.delegate=self;
    //将控制器设置为窗口的根控制器
    self.window.rootViewController=vc;
;

    //设置选中该窗口
    [self.window makeKeyAndVisible];
    [self show];
    
    return YES;
}

//监听点击tabBarController:didSelectViewController
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    if (tabBarController.selectedIndex==self.lastSelectedIndex) {
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:WZFTabBarButtonDidRepeatClickNotification object:nil];
        
    
    
    }
    self.lastSelectedIndex=tabBarController.selectedIndex;
}




static UIWindow*window_;

/**
 点击顶部status返回顶部
 */
-(void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        创建window盖住status
        window_=[[UIWindow alloc]init];
        window_.frame=[UIApplication sharedApplication].statusBarFrame;
        //设置窗体颜色(默认黑色- -!!!)
        window_.backgroundColor=[UIColor clearColor];
        //设置window的等级 .好让他浮现在状态栏上面让我们可以点击
        window_.windowLevel=UIWindowLevelAlert;
        //默认隐藏 ,
        window_.hidden=NO;
        //设置点击顶部执行的事件
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topWindowClick)]];
        
        
    });
}

-(void)topWindowClick
{
    //获取主要window,为获取每个scrollview
    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    [self findScrollViewInView:window];
    
}

-(void)findScrollViewInView:(UIView*)view
{
    //递归查询scrollview
    for (UIView*subview in view.subviews) {
        [self findScrollViewInView:subview];
    }
    if (![view isKindOfClass:[UIScrollView class]]) {
        return;
    }
//    //查看scrollview与主窗口是否在同一个窗口上
//    UIWindow*windows=[UIApplication sharedApplication].keyWindow;
//    CGRect windowsR=[windows convertRect:windows.bounds toWindow:nil];
//    CGRect viewR=[view convertRect:view.bounds toView:nil];
    if (![view intersectWithView:[UIApplication sharedApplication].keyWindow]) {
        return;
    }
    //如果scrollview在window上
    UIScrollView*scrollView=(UIScrollView*)view;
    CGPoint offset=scrollView.contentOffset;
    offset.y=-scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    
    
}








- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

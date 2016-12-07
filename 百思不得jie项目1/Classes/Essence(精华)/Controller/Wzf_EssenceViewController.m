//
//  Wzf_EssenceViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "Wzf_EssenceViewController.h"
#import "TitleBtn.h"
#import "WZF_AllViewController.h"
#import "WZF_VideoViewController.h"
#import "WZF_VoiceViewController.h"
#import "WZF_PictureViewController.h"
#import "WZF_WordViewController.h"
#import "RecommendController.h"
@interface Wzf_EssenceViewController ()<UIScrollViewDelegate>
@property(nonatomic ,weak)UIButton*oldBtn;
@property(nonatomic,weak)UIView* indicatorView;
#pragma mark 联动2
//联动第二步  --------------------get 2
@property(nonatomic,weak)UIScrollView*scrollView;
//联动
@property(nonatomic,weak)UIView*titleView;

@end

@implementation Wzf_EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏
    [self setupNav];
   
    //添加子控制器
    [self setupAddChidrViewController];
    
    //添加scrollView
    [self setupScroll];
   
    
    //添加标题栏
    [self setupTitlebar];
    
    //默认添加第一个
    [self addChildVcView];
}
//*设置4个titleVIEW的监听


-(void)setupAddChidrViewController
{   
    WZF_AllViewController*all=[[WZF_AllViewController alloc]init];
    [self addChildViewController:all];
    WZF_VideoViewController*video=[[WZF_VideoViewController alloc]init];
    [self addChildViewController:video];
    WZF_VoiceViewController*voice=[[WZF_VoiceViewController alloc]init];
    [self addChildViewController:voice];
    WZF_PictureViewController*pic=[[WZF_PictureViewController alloc]init];
    [self addChildViewController:pic];
    WZF_WordViewController*word=[[WZF_WordViewController alloc]init];
    [self addChildViewController:word];
    NSLog(@"%lu",(unsigned long)self.childViewControllers.count);
}


//添加scrollView
-(void)setupScroll
{   self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView*scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    scrollView.backgroundColor=RandomColor;
    scrollView.pagingEnabled=YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
#pragma mark 联动3
    self.scrollView=scrollView;
    NSUInteger count=self.childViewControllers.count;
    NSLog(@"aaa%lu",(unsigned long)count);
//    for (int i=0; i<count; i++) {
//        UITableView*childVcView=(UITableView*)self.childViewControllers[i].view;
//        childVcView.backgroundColor=RandomColor;
//        childVcView.wzf_x=i*childVcView.wzf_width;
//        childVcView.wzf_y=0;
//        childVcView.wzf_height=scrollView.wzf_height;
//        [scrollView addSubview:childVcView];
//        childVcView.contentInset=UIEdgeInsetsMake(64+35, 0, 49, 0);
////        scrollIndicatorInsets 指定了滚动指示条在位置的切换
//        childVcView.scrollIndicatorInsets=childVcView.contentInset;
//        
//    }
    scrollView.contentSize=CGSizeMake(count*scrollView.wzf_width, 0);
    
    
    }
//添加标题栏
-(void)setupTitlebar
{
    CGFloat titleX=0;
    CGFloat titleY=64;
    CGFloat titleW=self.view.wzf_width;
    CGFloat titleH=35;
    UIView*titleView=[[UIView alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    titleView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    self.titleView=titleView;
    [self.view addSubview:titleView];
//    添加标题
    NSArray*titles=@[@"全部", @"视频", @"声音", @"图片", @"段子"];
    //计算button的宽度
    CGFloat btnW=self.view.wzf_width/titles.count;
    CGFloat btnH=35;
    for (int i=0; i<titles.count; i++) {
        CGFloat btnX=i*btnW;
        TitleBtn*titleButton=[TitleBtn buttonWithType:UIButtonTypeCustom];
                //设置尺寸
#pragma mark 联动1
        //通过tag实现table与button连动-----get! 1.
        titleButton.tag=i;
        titleButton.frame=CGRectMake(btnX, 0, btnW, btnH);
      
        //添加点击事件
        [titleButton addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
        //添加到scrollview上
        [titleView addSubview:titleButton];
        //设置标题,从数组中取出
        [titleButton  setTitle:titles[i] forState:UIControlStateNormal];

        
        }
    //设置底部指示器
 TitleBtn*firstButton=titleView.subviews.firstObject;
    UIView*indicatorView=[[UIView alloc]init];
    //    设置按钮选中的颜色
    
    indicatorView.backgroundColor=[firstButton titleColorForState:UIControlStateSelected];
    indicatorView.wzf_height=1;
    indicatorView.wzf_y=titleView.wzf_height-indicatorView.wzf_height;
       [titleView addSubview:indicatorView];
    self.indicatorView=indicatorView;
    
    //立即根据文字计算内容label的宽度
    [firstButton.titleLabel sizeToFit];
    indicatorView.wzf_width=firstButton.titleLabel.wzf_width;
    indicatorView.wzf_centerX=firstButton.wzf_centerX;
    firstButton.selected=YES;
    self.oldBtn=firstButton;
//    或者添加在一开始viewdidload
//    [self addChildVcView];
    
    
    
}
//设置按钮选中后是红色
-(void)clickTitle:(TitleBtn*)button
{
    //重复点击,刷新
    if (button==self.oldBtn) {
        [[NSNotificationCenter defaultCenter]postNotificationName:WZFTitleButtonDidRepeatClickNotification object:nil];
       }
    
    self.oldBtn.selected=NO;
    button.selected=YES;
    self.oldBtn=button;
    
//浮现状态---动画效果
    [UIView animateWithDuration:0.25 animations:^{
       
//        self.indicatorView.wzf_centerX=button.wzf_centerX;
        //必须先设置宽度在设置中心  ---整巨久  ~~~~(>_<)~~~~
        self.indicatorView.wzf_width=button.titleLabel.wzf_width;
        self.indicatorView.wzf_centerX=button.wzf_centerX;
    }];
#pragma mark 联动4
    //联动终结
    CGPoint offset=self.scrollView.contentOffset;
    offset.x=button.tag*self.scrollView.wzf_width;
    //联动-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView这个方法
    [self.scrollView setContentOffset:offset animated:YES];
    
    
    
    
}




#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.wzf_width;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    //    if (childVc.view.superview) return;
    //    if (childVc.view.window) return;
    if ([childVc isViewLoaded]) return;
    
    //    childVc.view.xmg_x = index * self.scrollView.xmg_width;
    //    childVc.view.xmg_y = 0;
    //    childVc.view.xmg_width = self.scrollView.xmg_width;
    //    childVc.view.xmg_height = self.scrollView.xmg_height;
    
    //    childVc.view.xmg_x = self.scrollView.contentOffset.x;
    //    childVc.view.xmg_y = self.scrollView.contentOffset.y;
    //    childVc.view.xmg_width = self.scrollView.xmg_width;
    //    childVc.view.xmg_height = self.scrollView.xmg_height;
    
    //    childVc.view.xmg_x = self.scrollView.bounds.origin.x;
    //    childVc.view.xmg_y = self.scrollView.bounds.origin.y;
    //    childVc.view.xmg_width = self.scrollView.bounds.size.width;
    //    childVc.view.xmg_height = self.scrollView.bounds.size.height;
    
    //    childVc.view.frame = CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

//人为拖拽
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算所对应页面
    NSUInteger index=self.scrollView.contentOffset.x/scrollView.wzf_width;
    //获取到当前按钮
    TitleBtn*titleButton=self.titleView.subviews[index];
    [self clickTitle:titleButton];
    [self addChildVcView];
    
    
}




//在scrollview滚动动画结束时调用这个方法
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
    
}







-(void)setupNav
{
    //设置导航栏中心文字---图片
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Nav"]];
    //设置左边---图片
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [btn.self sizeToFit];
    [btn addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
}






-(void)tagClick{
    wzfNSlog;
    RecommendController*vc=[[RecommendController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end

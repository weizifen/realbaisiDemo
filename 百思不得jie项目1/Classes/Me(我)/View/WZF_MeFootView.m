//
//  WZF_MeFootView.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/23.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_MeFootView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "WZF_MeModel.h"
#import "footView_button.h"
#import "WZF_WebViewController.h"
@interface WZF_MeFootView()
//@property(nonatomic,assign)CGFloat*footHeight;

@end
@implementation WZF_MeFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//设置footView的尺寸
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
//        self.wzf_height=400;
//        self.backgroundColor=[UIColor redColor];
        
        NSMutableDictionary*dict=[NSMutableDictionary dictionary];
        dict[@"a"]=@"square";
        dict[@"c"]=@"topic";
        //获取数据
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //字典转模型存入数组中
            NSArray*squares=[WZF_MeModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //获取到模型--可以创造对应的控件
            [self creatSquares:squares];
            //设置按钮的度高-----
            NSUInteger hang=(squares.count/4)+1;
            CGFloat width=(self.wzf_width/4);
            CGFloat footHeight=hang*width;
            self.wzf_height=footHeight;
            //重新刷新后生效
            UITableView*tableView=(UITableView*)self.superview;
            [tableView reloadData];
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            WZFLog(@"网络连接失败--%@",error);
        }];
    }
    return self;
}



-(void)creatSquares:(NSArray*)squares
{   //方块的总个数
    NSUInteger count=squares.count;
    NSUInteger maxColsCount=4;//每行的列数
    CGFloat buttonW=self.wzf_width/maxColsCount;
    CGFloat buttonH=buttonW;
    
    
    NSLog(@"%ld",(long)count);
    for (int i=0; i<squares.count; i++) {
        footView_button*btn=[[footView_button alloc]init];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.squares=squares[i];
        btn.wzf_x=(i%maxColsCount)*buttonW;
        btn.wzf_y=(i/maxColsCount)*buttonH;
        btn.wzf_width=buttonW;
        btn.wzf_height=buttonH;
//        btn.backgroundColor=[UIColor redColor];
        
        
        
        
    }
    
}
-(void)click:(footView_button*)btn
{
//    wzfNSlog;
    //获取导航控制器进行跳转
    UITabBarController*tabbarVC=(UITabBarController*)self.window.rootViewController;
    UINavigationController*nav=tabbarVC.selectedViewController;
    //向网页控制器传值
    WZF_WebViewController*webVC=[[WZF_WebViewController alloc]init];
    webVC.url=btn.squares.url;
    [nav pushViewController:webVC animated:YES];
}


@end

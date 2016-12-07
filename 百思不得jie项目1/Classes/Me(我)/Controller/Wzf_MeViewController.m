//
//  Wzf_MeViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "Wzf_MeViewController.h"
#import "SettingViewController.h"
#import "WZF_TableViewCell.h"
#import "WZF_MeFootView.h"
@interface Wzf_MeViewController ()

@end

@implementation Wzf_MeViewController
-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    //去除组头
    self.tableView.sectionHeaderHeight=0;
    //去除组尾
    self.tableView.sectionFooterHeight=10;
    //所以
    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
    WZF_MeFootView*footView=[[WZF_MeFootView alloc]init];
    
    self.tableView.tableFooterView=footView;
    [self setupBefore];
}

//一些四天前的数据(布局)--导航之类的
-(void)setupBefore{
     //设置导航栏标题
    self.navigationItem.title=@"我的";
    //设置导航栏右侧
    //    设置
    UIButton*setting=[UIButton buttonWithType:UIButtonTypeCustom];
    [setting setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [setting setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [setting.self sizeToFit];
    [setting addTarget:self action:@selector(setting1) forControlEvents:UIControlEventTouchUpInside];
    
    //模式
    UIBarButtonItem*settingBtn=[[UIBarButtonItem alloc]initWithCustomView:setting];
    UIButton*moonbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moonbtn setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonbtn setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [moonbtn.self sizeToFit];
    [moonbtn addTarget:self action:@selector(moon) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*moonBtn=[[UIBarButtonItem alloc]initWithCustomView:moonbtn];
    self.navigationItem.rightBarButtonItems=@[settingBtn,moonBtn];
    

}


-(void)setting1{
 
//    wzfNSlog;
    SettingViewController*vc=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)moon{
}

#pragma 数据源方法(tableview)
//多少行
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//多少组
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   //确认重用标识符
    static NSString*identifield=@"cell";
    //从缓存池中取
    WZF_TableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:identifield];
    if (cell==nil) {
        cell=[[WZF_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifield];
        
    }
    
    //赋值
    if (indexPath.section==0) {
        cell.textLabel.text=@"登录/注册";
        cell.imageView.image=[UIImage imageNamed:@"setup-head-default"];
        
    }else
    {
        cell.textLabel.text=@"离线下载";
        cell.imageView.image=nil;
        
    }
    
//    cell.textLabel.text=[NSString stringWithFormat:@"%zd", indexPath.section];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
}

//由点击事件可以知道第一个cell与导航栏bottom的距离是35-------我们想缩小cell与顶部距离可以通过在viewdidload 中写
//self.tableview.contentinset
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WZFLog(@"%@", NSStringFromCGRect(cell.frame));
}

@end

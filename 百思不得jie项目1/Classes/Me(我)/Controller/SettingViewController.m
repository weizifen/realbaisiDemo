//
//  SettingViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "SettingViewController.h"
#import "textViewController.h"
#import <SDImageCache.h>
#import "WZF_SettingTableViewCell.h"
#import "OtherTableViewCell.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
static NSString * const WZF_SettingTableViewCellID = @"WZF_SettingTableViewCell";
static NSString * const OtherTableViewCellID = @"other";

-(instancetype)init
{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RandomColor;
    //修改cell的显示位置
    self.tableView.contentInset=UIEdgeInsetsMake(-35, 0, 0, 0);
    self.navigationItem.title=@"设置";
//    [self getCaches];
    [self.tableView registerClass:[WZF_SettingTableViewCell class] forCellReuseIdentifier:WZF_SettingTableViewCellID];
    [self.tableView registerClass:[OtherTableViewCell class] forCellReuseIdentifier:OtherTableViewCellID];
}


-(void)getCaches
{
    unsigned long long size=0;
//    unsigned cachesSize=0;
    //获取文件路径
    NSString*cachesPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) .lastObject;
    NSLog(@"%@",NSHomeDirectory());
    NSLog(@"%lu", (unsigned long)[SDImageCache sharedImageCache].getSize);
    NSString*over=[cachesPath stringByAppendingPathComponent:@"MP3"];
    NSLog(@"%@",over);
    NSFileManager*manger=[NSFileManager defaultManager];
    NSArray*array=[manger contentsOfDirectoryAtPath:over error:nil];
    for (NSString*substring in array) {
        NSString*full=[over stringByAppendingPathComponent:substring];
        size+=[manger attributesOfItemAtPath:full error:nil].fileSize;
        
    }
    NSLog(@"%zd",size);
    
    
}



//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    textViewController*vc=[[textViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
       
        WZF_SettingTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:WZF_SettingTableViewCellID];
        
        //上下拖动试图 菊花还在的做法
        UIActivityIndicatorView*loadingView=(UIActivityIndicatorView*)cell.accessoryView;
        [loadingView startAnimating];
        return cell;
    }
    else if(indexPath.row ==1)
    {
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:OtherTableViewCellID];
        cell.textLabel.text=@"关于我";
        return cell;
    }
    else
    {UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:OtherTableViewCellID];
        cell.textLabel.text=@"点击评价";
        return cell;
        
    }
    
}


@end

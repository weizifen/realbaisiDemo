//
//  WZF_TopicViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/25.
//  Copyright © 2016年 韦自奋. Topic rights reserved.
//

#import "WZF_TopicViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "ALLModel.h"
#import <UIImageView+WebCache.h>
#import "WZF_Refresh.h"
#import "WZF_PullRefresh.h"
#import "TopicCell.h"
#import "WZF_HTTPSessionManager.h"
#import <SDImageCache.h>
#import "CommentController.h"
#import "Wzf_NewViewController.h"
@interface WZF_TopicViewController ()
@property(nonatomic,strong)NSMutableArray<ALLModel*>*data;
//设置上拉加载更多东西 需要传入的值
@property(nonatomic,strong)NSString*maxtime;
@property(nonatomic,strong)WZF_HTTPSessionManager*manager;
@end

@implementation WZF_TopicViewController
// 1.确定重用标示:
static NSString *ID = @"cell";
#pragma mark 懒加载
-(AFHTTPSessionManager *)manager
{
    if (_manager==nil) {
        _manager=[WZF_HTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置table
    [self setupTable];
    //设置背景颜色
    
    self.view.backgroundColor=[UIColor grayColor];
    //去除底部分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    
    
    //设置下拉
    [self setupRefresh];
    //设置上拉加载更多
    [self pullRefresh];
    
    //高度不能固定,因为中间内容不固定
    //    self.tableView.rowHeight=250;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //通知
    [self setupNote];
    
}

/**
 设置通知
 */
-(void)setupNote
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WZFTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:WZFTitleButtonDidRepeatClickNotification object:nil];
}

-(void)tabBarButtonDidRepeatClick
{
    
    // 如果当前控制器的view不在window上，就直接返回,否则这个方法调用五次
    if (self.view.window == nil) return;
    
    // 如果当前控制器的view跟window没有重叠，就直接返回
    if (![self.view intersectWithView:self.view.window]) return;
    
    // 进行下拉刷新
    [self.tableView.mj_header beginRefreshing];
}
-(void )titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}




/**
 下拉刷新
 */
-(void)setupRefresh
{
    self.tableView.mj_header=[WZF_Refresh headerWithRefreshingTarget:self refreshingAction:@selector(setNetConnect)];
    
    [self.tableView.mj_header beginRefreshing];
    
}


/**
 上拉加载更多
 */
-(void)pullRefresh
{
    self.tableView.mj_footer=[WZF_PullRefresh footerWithRefreshingTarget:self refreshingAction:@selector(setPullNetConnect)];
    //    [self.tableView.mj_footer beginRefreshing];
    
}


- (NSString *)aParam
{
    if (self.parentViewController.class == [Wzf_NewViewController class]) {
        return @"newlist";
    }
    return @"list";
}

/**
 下拉网络连接
 */


-(void)setNetConnect
{
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary*parmenters=[NSMutableDictionary dictionary];
    parmenters[@"a"]=self.aParam;
    parmenters[@"c"]=@"data";
    parmenters[@"type"]=@(self.type);
    
    //    parmenters[@"type"]=@"29";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parmenters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/weizifen/Desktop/a.plist"atomically:YES];
        
        
        
        
        self.maxtime=responseObject[@"info"][@"maxtime"];
        //        NSLog(@"%@",self.maxtime);
        //字典转模型并存入可变数组中
        
        self.data=[ALLModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //
        //                for (NSUInteger i = 0; i < self.data.count; i++) {
        //                    if (self.data[i].top_cmt.count) { // 最热评论
        //                       WZFLog(@"下拉刷新 - %zd", i);
        //                    }
        //                }
#warning must setting
        //必须刷新数据否者显示不出来
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错了   啊啊啊");
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)setPullNetConnect
{
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary*parmenters=[NSMutableDictionary dictionary];
    parmenters[@"a"]=@"list";
    parmenters[@"c"]=@"data";
    parmenters[@"type"]=@(self.type);
    
    parmenters[@"maxtime"]=self.maxtime;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parmenters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime=responseObject[@"info"][@"maxtime"];
        
        //创建一个临时数组
        NSArray*temp=[ALLModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.data addObjectsFromArray:temp];
        //        for (NSUInteger i = 0; i < self.data.count; i++) {
        //            if (self.data[i].top_cmt.count) { // 最热评论
        //                WZFLog(@"下拉刷新 - %zd", i);
        //            }
        //        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"发生错误%@",error);
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


-(void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 2.从缓存池中取
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = RandomColor;
    }
    cell.model=self.data[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.data[indexPath.row].cellHeight;
}
#pragma mark   ---清理缓存
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[SDImageCache sharedImageCache]clearMemory];
}

//*点击摸个Cell要做的事情*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentController*vc=[[CommentController alloc]init];
    vc.model=self.data[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end

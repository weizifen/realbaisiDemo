//
//  CommentController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/2.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "CommentController.h"
#import "WZF-CommentHeaderView.h"
#import "WZF_CommentViewCell.h"
#import <AFNetworking.h>
#import "ALLModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "WZF_commentModel.h"
#import "WZF_Refresh.h"
#import "WZF_PullRefresh.h"
#import "TopicCell.h"
//设置数据源代理和代理
@interface CommentController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)AFHTTPSessionManager*manager;
/** 最热评论数据 */
@property (nonatomic, strong) NSArray<WZF_commentModel *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<WZF_commentModel *> *latestComments;
/** 最热评论 */
@property (nonatomic, strong) WZF_commentModel *savedTopCmt;

@end

@implementation CommentController
//懒加载
-(AFHTTPSessionManager *)manager
{
    if (_manager==nil) {
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}



static  NSString*const TopicID=@"topicCell";
static  NSString*const CommentID=@"commentCell";
static  NSString*const WZFSectionHeaderId=@"header";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBase];
    [self setTable];
    [self setupRefresh];
    [self pullRefresh];
    [self setupHeader];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    
    
    
}
//*-----------------------界面键盘相关---------------------------------*//
-(void)setBase{
    self.navigationItem.title=@"评论";
    //通知监听键盘改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
}

-(void)dealloc
{
    //移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.model.cellHeight = 0;

}
-(void)keyboardWillChange:(NSNotification*)note
{
    //显示键盘相关信息
//    NSLog(@"%@",note.userInfo);
    
    /*
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 538}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 796}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
     UIKeyboardIsLocalUserInfoKey = 1;
    */
    //获取键盘高度,宽度
    CGFloat keybordY=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    self.BottomMargin.constant=screenH-keybordY;
    
    //执行动画
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}
//*-----------------------界面键盘相关---------------------------------*//
//*-----------------------设置头部---------------------------------*//
- (void)setupHeader
{
    // 处理模型数据
    self.savedTopCmt = self.model.top_cmt[0];
    self.model.top_cmt = nil;
    self.model.cellHeight = 0;
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor=[UIColor whiteColor];
    // 添加cell到header
    TopicCell *cell = [TopicCell viewFromXib];
    cell.model = self.model;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.model.cellHeight);
    [header addSubview:cell];
    
    // 设置header的高度
    header.wzf_height = cell.wzf_height + Margin * 2;
    
    // 设置header
    self.tableView.tableHeaderView = header;
}



//*-----------------------设置头部---------------------------------*//

//*-----------------------设置table相关---------------------------------*//
-(void)setTable{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WZF_CommentViewCell class]) bundle:nil] forCellReuseIdentifier:CommentID];
    [self.tableView registerClass:[WZF_CommentHeaderView class] forHeaderFooterViewReuseIdentifier:WZFSectionHeaderId];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = [UIFont systemFontOfSize:15].lineHeight + 2;
    
    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    
    
    
}








//*-----------------------设置table相关---------------------------------*//


//*-----------------------刷新数据---------------------------------*//

/**
 下拉刷新
 */
-(void)setupRefresh
{
    self.tableView.mj_header=[WZF_Refresh headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    
}


/**
 上拉加载更多
 */
-(void)pullRefresh
{
    self.tableView.mj_footer=[WZF_PullRefresh footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //    [self.tableView.mj_footer beginRefreshing];
    
}

//*-----------------------刷新数据---------------------------------*//


//*-----------------------获取网络数据---------------------------------*//
#pragma mark - 数据加载
- (void)loadNewComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.model.ID;
    params[@"hot"] = @1; // @"1";
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        [responseObject writeToFile:@"/Users/weizifen/Desktop/d.plist"atomically:YES];
        weakSelf.latestComments = [WZF_commentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [WZF_commentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];

    }];
}

- (void)loadMoreComments
{
//    / 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.model.ID;
    params[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        NSArray *moreComments = [WZF_commentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) { // 全部加载完毕
            // 提示用户:没有更多数据
            // [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.tableView.mj_footer.hidden = YES;
        } else { // 还没有加载完全
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
 

    
}
 
//*-----------------------获取网络数据---------------------------------*//

#pragma mark----数据源代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%lu",(unsigned long)self.latestComments.count);
    // 有最热评论 + 最新评论数据
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论数据, 有最新评论数据
    if (self.latestComments.count) return 1;
    
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 其他情况
    return self.latestComments.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString*ID=@"cell";
//    UITableViewCell*Cell=[tableView dequeueReusableCellWithIdentifier:ID];
//    if (Cell==nil) {
//        Cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        
//    }
//     return Cell;
    
    WZF_CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentID];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.model = self.hotestComments[indexPath.row];
    } else {
        cell.model = self.latestComments[indexPath.row];
    }
    
    return cell;

}

//
//设置SECTION头文字---自定义组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WZF_CommentHeaderView*vc=[[WZF_CommentHeaderView alloc]initWithReuseIdentifier:WZFSectionHeaderId];
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        vc.textLabel.text = @"最热评论";
    } else { // 其他情况
        vc.textLabel.text = @"最新评论";
    }
    
    return vc;
}


#pragma mark-----代理方法

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end

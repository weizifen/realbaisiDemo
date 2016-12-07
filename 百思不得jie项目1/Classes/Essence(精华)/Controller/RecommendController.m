//
//  RecommendController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/1.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "RecommendController.h"
#import "RecommendCell.h"
#import "RecommendModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface RecommendController ()
@property(nonatomic,strong)AFHTTPSessionManager*manager;
@property(nonatomic,strong)NSArray<RecommendModel*>*recommendArray;
@end


@implementation RecommendController
-(AFHTTPSessionManager *)manager
{
    if (_manager==nil) {
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}


static NSString*ID=@"recommend";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title=@"推荐标签";
    self.tableView.backgroundColor=[UIColor grayColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCell class]) bundle:nil]forCellReuseIdentifier:ID];
    self.tableView.rowHeight=70;
    //去下分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [self LoadData];
    

}


/**
 载入标签数据
 */
-(void)LoadData
{
    __weak typeof(self) weakeself=self;
  

   
    NSMutableDictionary*params=[NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    params[@"type"]=@"10";
    [self.manager GET:    @"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/weizifen/Desktop/b.plist"atomically:YES];
        
            //字典转模型存入
            weakeself.recommendArray=[RecommendModel mj_objectArrayWithKeyValuesArray:responseObject];
            //更新列表
            [weakeself.tableView reloadData];
      
        

        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];

        [SVProgressHUD showErrorWithStatus:@"未能加载成功"];
        
    }];
}


-(void)dealloc
{
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    NSLog(@"%lu",(unsigned long)self.recommendArray.count);

    return self.recommendArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    cell.model=self.recommendArray[indexPath.row];
    return cell;
}

@end

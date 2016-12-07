//
//  PlayerVideoViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/30.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "PlayerVideoViewController.h"
#import "ZFPlayer.h"
#import "ALLModel.h"
@interface PlayerVideoViewController ()<ZFPlayerDelegate>
@property (strong, nonatomic) IBOutlet ZFPlayerView *videoPlayer;

@end

@implementation PlayerVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setModel:(ALLModel *)model
{
    _model=model;
    // 初始化控制层view(可自定义)
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // 初始化播放模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    // playerView的父视图
    playerModel.fatherView = self.view;
    playerModel.videoURL = [NSURL URLWithString:self.model.videouri];
    playerModel.title = @"test";
    [self.videoPlayer playerControlView:controlView playerModel:playerModel];
    // 设置代理
    self.videoPlayer.delegate = self;
    // 自动播放
    [self.videoPlayer autoPlayTheVideo];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)zf_playerBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil]; 
}


@end

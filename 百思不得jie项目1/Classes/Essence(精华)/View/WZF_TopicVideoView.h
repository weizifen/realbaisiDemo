//
//  WZF_TopicVideoView.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/28.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALLModel;
@interface WZF_TopicVideoView : UIView
@property(nonatomic,strong)ALLModel*model;
+(instancetype)videoView;
@end

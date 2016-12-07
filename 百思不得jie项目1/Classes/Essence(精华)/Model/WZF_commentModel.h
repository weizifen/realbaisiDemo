//
//  WZF_commentModel.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/27.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WZF_userModel;
@interface WZF_commentModel : NSObject


@property (nonatomic, copy) NSString *ID;

/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) WZF_userModel *user;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end

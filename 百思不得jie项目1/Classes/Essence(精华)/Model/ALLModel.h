//
//  ALLModel.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/26.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WZF_commentModel;

@interface ALLModel : NSObject
typedef NS_ENUM(NSUInteger,WZF_TopicType)
{
    WZF_TopicTypeAll=1,
    //*图片/
    WZF_TopicTypePicture=10,
    //*段子/
    WZF_TopicTypeWord=29,
    //*声音/
    WZF_TopicTypeVoice=31,
    //*视频/
    WZF_TopicTypeVideo=41
    
};
/**id*/

@property (nonatomic, copy) NSString *ID;

//用户名字*/
@property(nonatomic,strong)NSString*name;

/**用户头像*/
@property(nonatomic,strong)NSString*profile_image;

/**
 帖子内容
 */
@property(nonatomic,strong)NSString*text;

/**
 帖子创造时间
 */
@property(nonatomic,strong)NSString*created_at;

/**
 踩
 */
@property(nonatomic,assign)NSInteger cai;

/**
 顶
 */
@property(nonatomic,assign)NSInteger ding;

/**
 转发
 */
@property(nonatomic,assign)NSInteger repost;

/**
 评论数量
 */
@property(nonatomic,assign)NSInteger comment;


/**
最热评论  告诉数组  里面存放的是WZF_commentModel模型
 */
@property(nonatomic,strong)NSArray <WZF_commentModel*>*top_cmt;

/**
 帖子类型
 */
@property(nonatomic,assign)WZF_TopicType type;

/**
 图片的高度
 */
@property(nonatomic,assign)CGFloat height;

/**
 图片的宽度
 */
@property(nonatomic,assign)CGFloat width;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;

/** 视频地址*/
@property(nonatomic,copy)NSString *videouri;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/*-----------------------------------------*/
/**
 cell的高度
 */
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGRect contentF;
@property(nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

@end

//
//  WZF_userModel.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/27.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZF_userModel : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end

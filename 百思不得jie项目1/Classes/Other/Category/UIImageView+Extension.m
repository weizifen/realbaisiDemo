//
//  UIImageView+Extension.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/1.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (Extension)

-(void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}
-(void)setCircleHeader:(NSString*)url
{
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.image = [image circleImage];
    }];

}
-(void)setRectHeader:(NSString*)url
{
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];

}
@end

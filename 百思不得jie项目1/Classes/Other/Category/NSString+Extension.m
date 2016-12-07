//
//  NSString+Extension.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/24.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(unsigned long long)fileSize
{
    
    
    unsigned long long size=0;
    //创建文件管理者
    NSFileManager*mgr=[NSFileManager defaultManager];
    //文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    //如果数组里面有文件夹
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {
        //遍历文件夹的子路径
        NSDirectoryEnumerator*Enumerator=      [mgr enumeratorAtPath:self];
        for (NSString*sub in Enumerator) {
            //全路径
            NSString*over=[self stringByAppendingPathComponent:sub];
            size+=[mgr attributesOfItemAtPath:over error:nil].fileSize;
        }
        
    }else
    {
        size=attrs.fileSize;
    }
    return size;
    
    
}
@end

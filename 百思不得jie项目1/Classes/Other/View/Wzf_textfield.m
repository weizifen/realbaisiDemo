//
//  Wzf_textfield.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/22.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "Wzf_textfield.h"
static NSString*const WZF_PlaceholderColorKey=@"placeholderLabel.textColor";

@interface Wzf_textfield()

@end
@implementation Wzf_textfield

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    //设置光标颜色
    self.tintColor=[UIColor whiteColor];
   
    self.placeholderColor=[UIColor grayColor];
    
}


/**
 让textfield成为第一响应者(开始编辑\弹出键盘\获得焦点)

 */
-(BOOL)becomeFirstResponder
{
    self.placeholderColor=[UIColor whiteColor];
    return [super becomeFirstResponder];
}


/**
 *  调用时刻 : 不做第一响应者(结束编辑\退出键盘\失去焦点)
 */
-(BOOL)resignFirstResponder
{
    self.placeholderColor=[UIColor grayColor];

    
    return [super resignFirstResponder];
}



@end

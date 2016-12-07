//
//  UITextField+Extension.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/22.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "UITextField+Extension.h"
static NSString*const WZF_PlaceholderColorKey=@"placeholderLabel.textColor";

@implementation UITextField (Extension)

//这个扩展属性必须先设置placeholder文字 然后才能实现----考虑不全面的做法步骤 --仅需那两部

//完善后应该是

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{   //这三句的做法是为了让本来应该提前创建的placeholder可以在placeholderColor后创建- -!!!
    NSString*oldePlaceholder=self.placeholder;
    self.placeholder=@"";
    self.placeholder=oldePlaceholder;
    if (self.placeholderColor==nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];

    }
    
    
    [self setValue:placeholderColor forKeyPath:WZF_PlaceholderColorKey];//考虑不全面的做法步骤1

}
-(UIColor *)placeholderColor
{
    return [self valueForKeyPath:WZF_PlaceholderColorKey];//考虑不全面的做法步骤2
}




@end

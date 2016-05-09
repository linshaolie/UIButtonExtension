//
//  UIButton+Extension.h
//  MsgNegotiateDemo
//
//  Created by 木木 on 16/5/6.
//  Copyright © 2016年 linshaolie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

@property(nonatomic,readonly,strong) UIColor *currentBorderColor;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)setborderColor:(UIColor *)borderColor forState:(UIControlState)state;

- (UIColor *)borderColorForState:(UIControlState)state;
- (UIColor *)backgroundColorForState:(UIControlState)state;

- (void)configBorderColors:(NSDictionary *)borderColors;
- (void)configBackgroundColors:(NSDictionary *)backgroundColors;
@end

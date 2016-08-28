//
//  UIButton+Extension.m
//  MsgNegotiateDemo
//
//  Created by 木木 on 16/5/6.
//  Copyright © 2016年 linshaolie. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, strong) NSMutableDictionary *borderColors;
@property (nonatomic, strong) NSMutableDictionary *backgroundColors;

@end

@implementation UIButton (Extension)

+ (void)load {
    //交换 setHighlighted:, setEnabled: 和 setSelected: 方法
    Class aClass = [self class];
    method_exchangeImplementations(class_getInstanceMethod(aClass, @selector(setHighlighted:)),
                                   class_getInstanceMethod(aClass, @selector(sl_setHighlighted:))
                                  );
    method_exchangeImplementations(class_getInstanceMethod(aClass, @selector(setEnabled:)),
                                   class_getInstanceMethod(aClass, @selector(sl_setEnabled:))
                                  );
    method_exchangeImplementations(class_getInstanceMethod(aClass, @selector(setSelected:)),
                                   class_getInstanceMethod(aClass, @selector(sl_setSelected:))
                                   );
}

#pragma mark - public method

- (void)setborderColor:(UIColor *)borderColor forState:(UIControlState)state {
    if (borderColor) {
        [self.borderColors setObject:borderColor forKey:@(state)];

        if (self.layer.borderWidth == 0) {
            self.layer.borderWidth = 1.0;
        }
    }
    
    if(self.state == state) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (backgroundColor) {
        [self.backgroundColors setObject:backgroundColor forKey:@(state)];
    }
    if(self.state == state) {
        self.backgroundColor = backgroundColor;
    }
}

- (UIColor *)borderColorForState:(UIControlState)state {
    return [self.borderColors objectForKey:@(state)];
}

- (UIColor *)backgroundColorForState:(UIControlState)state {
    return [self.backgroundColors objectForKey:@(state)];
}

- (void)configBorderColors:(NSDictionary *)borderColors {
    self.borderColors = [borderColors mutableCopy];
    [self _update];
}

- (void)configBackgroundColors:(NSDictionary *)backgroundColors {
    self.backgroundColors = [backgroundColors mutableCopy];
    [self _update];
}

#pragma mark - override

- (void)sl_setSelected:(BOOL)selected {
    [self sl_setSelected:selected];
    
    [self _update];
}

- (void)sl_setEnabled:(BOOL)enabled {
    [self sl_setEnabled:enabled];

    [self _update];
}

- (void)sl_setHighlighted:(BOOL)highlighted {
    [self sl_setHighlighted:highlighted];

    [self _update];
}

#pragma mark - private method

- (void)_update {
    UIColor *backgroundColor = [self backgroundColorForState:self.state];
    UIColor *borderColor = [self borderColorForState:self.state];
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    } else {
        UIColor *normalColor = [self backgroundColorForState:UIControlStateNormal];
        if (normalColor) {
            self.backgroundColor = normalColor;
        }
    }
    
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    } else {
        UIColor *normalColor = [self borderColorForState:UIControlStateNormal];
        if (normalColor) {
            self.layer.borderColor = normalColor.CGColor;
        }
    }
}

#pragma mark - setter and getter

//currentBorderColor
- (UIColor *)currentBorderColor {
    return [self borderColorForState:self.state];
}

//borderColors
- (void)setBorderColors:(NSMutableDictionary *)borderColors {
    objc_setAssociatedObject(self, @selector(borderColors), borderColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)borderColors {
    NSMutableDictionary *_borderColors = objc_getAssociatedObject(self, @selector(borderColors));
    
    if (!_borderColors) {
        _borderColors = [NSMutableDictionary new];
        self.borderColors = _borderColors;
    }
    return _borderColors;
}

//backgroundColors
- (void)setBackgroundColors:(NSMutableDictionary *)backgroundColors {
    objc_setAssociatedObject(self, @selector(backgroundColors), backgroundColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)backgroundColors {
    NSMutableDictionary *_backgroundColors = objc_getAssociatedObject(self, @selector(backgroundColors));
    if(!_backgroundColors) {
        _backgroundColors = [[NSMutableDictionary alloc] init];
        self.backgroundColors = _backgroundColors;
    }
    return _backgroundColors;
}


@end

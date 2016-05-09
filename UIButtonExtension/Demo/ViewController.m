//
//  ViewController.m
//  UIButtonExtension
//
//  Created by 木木 on 16/5/9.
//  Copyright © 2016年 linshaolie. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set borderColor for state
    UIButton *borderButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [borderButton setFrame:CGRectMake(100, 100, 100, 30)];
    [borderButton setborderColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    [borderButton setborderColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
    [borderButton setborderColor:[UIColor blueColor] forState:(UIControlStateSelected)];
    //    [borderButton setborderColor:[UIColor yellowColor] forState:(UIControlStateSelected | UIControlStateHighlighted)];
    
    [borderButton addTarget:self action:@selector(touchButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self setTitleToButton:borderButton];
    
    //set background for state
    UIButton *bkButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [bkButton setFrame:CGRectMake(100, 200, 200, 30)];
    [self setTitleToButton:bkButton];
    [bkButton addTarget:self action:@selector(touchButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bkButton configBackgroundColors:@{
                                       @(UIControlStateNormal):[UIColor grayColor],
                                       @(UIControlStateSelected):[UIColor blueColor],
                                       @(UIControlStateHighlighted):[UIColor redColor],
                                       }];
    //等同于
    //    [button setBackgroundColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    //    [button setBackgroundColor:[UIColor redColor] forState:(UIControlStateSelected)];
    //    [button setBackgroundColor:[UIColor purpleColor] forState:(UIControlStateHighlighted)];
    
    [self.view addSubview:borderButton];
    [self.view addSubview:bkButton];
}

- (void)setTitleToButton:(UIButton *)button {
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setTitle:@"nomal" forState:(UIControlStateNormal)];
    [button setTitle:@"selected" forState:(UIControlStateSelected)];
    [button setTitle:@"disabled" forState:(UIControlStateDisabled)];
    [button setTitle:@"highlight" forState:(UIControlStateHighlighted)];
}

- (void)touchButton:(UIButton *)button {
    button.selected = !button.selected;
}

@end

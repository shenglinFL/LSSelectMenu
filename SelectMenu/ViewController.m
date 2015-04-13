//
//  ViewController.m
//  SelectMenu
//
//  Created by Sheng Lin on 15-3-31.
//  Copyright (c) 2015年 林盛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.lsSelectMenuView = [[LSSelectMenuView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
    self.lsSelectMenuView = [[LSSelectMenuView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 500) andNumberOfCellForRow:3 andSelectedMenuTitles:@[@"综合",@"财经",@"科技",@"娱乐",@"社会",@"体育",@"汽车",@"房产",@"教育",@"游戏",@"电影"] andUnSelectedMenuTitles:@[@"旅游",@"国际",@"国内",@"时尚",@"搞笑",@"图片",@"人文"]];
    [self.view addSubview:self.lsSelectMenuView];
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

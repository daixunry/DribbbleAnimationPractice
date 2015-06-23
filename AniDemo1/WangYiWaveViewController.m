//
//  WangYiWaveViewController.m
//  AniDemo1
//
//  Created by daixu on 15/6/3.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "WangYiWaveViewController.h"

@interface WangYiWaveViewController ()

@property (weak, nonatomic) IBOutlet WangYiWave *wangYiWave;

@end

@implementation WangYiWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wangYiWave.speed = 2;
    self.wangYiWave.waveHeight = 5;
    self.wangYiWave.backgroundColor = [UIColor colorWithRed:200/255.0 green:30/255.0 blue:20/255.0 alpha:1];
}

- (IBAction)wave:(id)sender {
    [self.wangYiWave wave];
}

@end

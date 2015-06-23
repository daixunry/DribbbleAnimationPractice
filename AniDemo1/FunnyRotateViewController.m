//
//  FunnyRotateViewController.m
//  AniDemo1
//
//  Created by daixu on 15/6/3.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "FunnyRotateViewController.h"

@interface FunnyRotateViewController ()

@property (weak, nonatomic) IBOutlet QRefreshView *qRefreshV;

@property (weak, nonatomic) IBOutlet QRefreshView2 *qRefreshV2;

@end

@implementation FunnyRotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startAni:(id)sender {
    [self.qRefreshV beginAni];
    [self.qRefreshV2 beginAni];
}

@end

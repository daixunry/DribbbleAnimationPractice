//
//  ViewController.m
//  AniDemo1
//
//  Created by daixu on 15/6/3.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "ViewController.h"
#import "FunnyRotateViewController.h"
#import "Menu3DContainerViewController.h"
#import "WangYiWaveViewController.h"
#import "Menu3DContainerViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushWangYiWaveVC:(id)sender {
    [self.navigationController pushViewController:[WangYiWaveViewController new] animated:YES];
}

- (IBAction)push3DSideMenuVC:(id)sender {
    [self.navigationController pushViewController:[Menu3DContainerViewController new] animated:YES];
}

- (IBAction)pushFunnyRotateCircleVC:(id)sender {
    [self.navigationController pushViewController:[FunnyRotateViewController new] animated:YES];
}

- (IBAction)push3DSideMenuVC2:(id)sender {
    [self.navigationController pushViewController:[Menu3DContainerViewController2 new] animated:YES];
}

@end

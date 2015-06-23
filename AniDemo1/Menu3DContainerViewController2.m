//
//  Menu3DContainerViewController.m
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/6/1.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "Menu3DContainerViewController2.h"
#import "Menu3DSideBar2.h"
#import "UIConfig.h"

@interface Menu3DContainerViewController2 ()
{
    UIView *_containView;
    UIView *_navView;
    Menu3DSideBar2 *_sideMenu2;
    UIView *_testV;
    CGFloat _rota;
}
@end

@implementation Menu3DContainerViewController2

+ (UIImage *)createImageWithWithFrame:(CGSize)size Path:(UIBezierPath *)path color:(UIColor*)stokeColor backColor:(UIColor*)backColor lineWidth:(CGFloat)lineW
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    CGContextSetStrokeColorWithColor(context, stokeColor.CGColor);
    CGContextSetFillColorWithColor(context, backColor.CGColor);
    CGContextSetLineWidth(context, lineW);
    CGContextStrokePath(context);
    CGContextFillPath(context);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavAndSideMenu];
    [self initGes];
}

- (void)initNavAndSideMenu
{
    _containView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_FULL_WIDTH, 64)];
    _navView.backgroundColor = [UIColor blackColor];
    
    _testV = [[UIView alloc] initWithFrame:self.view.bounds];
    _testV.backgroundColor = LikeGreenColor;
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 32, 32)];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(4, 4)];
    [path addLineToPoint:CGPointMake(24, 4)];
    [path moveToPoint:CGPointMake(4, 11)];
    [path addLineToPoint:CGPointMake(24, 11)];
    [path moveToPoint:CGPointMake(4, 18)];
    [path addLineToPoint:CGPointMake(24, 18)];

    [menuBtn setImage:[Menu3DContainerViewController2 createImageWithWithFrame:CGSizeMake(32, 32) Path:path color:[UIColor whiteColor] backColor:[UIColor blackColor] lineWidth:3] forState:UIControlStateNormal];
    [_navView addSubview:menuBtn];
    [menuBtn addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    _sideMenu2 = [[Menu3DSideBar2 alloc] initWithFrame:CGRectMake(0, 0, 100, UI_SCREEN_FULL_HEIGHT)];
    _sideMenu2.containerView = _containView;
    _sideMenu2.cshowMenuView = menuBtn;
    
    [self.view addSubview:_sideMenu2];
    [self.view addSubview:_containView];
    
    [_containView addSubview:_testV];
    [_containView addSubview:_navView];
}

- (void)initGes
{
    UIPanGestureRecognizer *pan  =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(foldMenu:)];
    [self.view addGestureRecognizer:pan];
}

- (void)foldMenu:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        [_sideMenu2 doAni];
    }
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan translationInView:self.view];
        CGFloat fullH = 160;
        CGFloat rota = point.x/fullH;

        [_sideMenu2 setOffset:rota];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded||pan.state == UIGestureRecognizerStateCancelled) {
        [_sideMenu2 aniContinue];
    }
    
}

- (void)openMenu:(id)sender
{
    [_sideMenu2 doOpenOrNot];
}

@end

//
//  Menu3DSideBar.h
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/6/1.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu3DSideBar : UIView

@property(nonatomic,weak)UIView *containerView;
@property(nonatomic,weak)UIView *cshowMenuView;

- (CGFloat)setRota:(CGFloat)rota;

- (void)closeFold;

- (void)openFold;

- (void)doAni;

- (void)doOpenOrNot;

@end

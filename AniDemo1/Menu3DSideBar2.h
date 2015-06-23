//
//  Menu3DSideBar2.h
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/6/3.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu3DSideBar2 : UIView

@property(nonatomic,weak)UIView *containerView;
@property(nonatomic,weak)UIView *cshowMenuView;

- (void)setOffset:(CGFloat)offset;

- (void)doAni;

- (void)aniContinue;

- (void)doOpenOrNot;

@end

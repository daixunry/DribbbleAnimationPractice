//
//  AniView2-1.h
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/4/29.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WangYiWave : UIView

@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat waveHeight;

- (void)wave;
- (void)stop;

@end

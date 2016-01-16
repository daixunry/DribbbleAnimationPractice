//
//  AniView2-1.m
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/4/29.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "WangYiWave.h"

@implementation WangYiWave
{
    CADisplayLink *_link;
    CGFloat _offset;
    CAShapeLayer *_layer;
    CAShapeLayer *_layer2;
    CGFloat _waveWidth;
    CGFloat _h;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initLayerAndProperty];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initLayerAndProperty];
    }
    return self;
}

- (void)initLayerAndProperty
{
    _waveWidth = self.frame.size.width;
    _h = 30;
    _layer = [CAShapeLayer layer];
    _layer.opacity = 0.5;
    _layer.frame = self.bounds;
    
    _layer2 = [CAShapeLayer layer];
    _layer2.frame = self.bounds;
    _layer2.opacity = 0.5;
    
    [self.layer addSublayer:_layer];
    [self.layer addSublayer:_layer2];
}

- (void)wave
{
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAni)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    [_link invalidate];
    _link = nil;
}

- (void)doAni
{
    _offset += _speed;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startY = _waveHeight*sinf(_offset*M_PI/_waveWidth);
    CGPathMoveToPoint(pathRef, NULL, 0, startY);
    for (CGFloat i = 0.0; i < _waveWidth; i ++) {
        CGFloat y = 1.1*_waveHeight*sinf(2.5*M_PI*i/_waveWidth + _offset*M_PI/_waveWidth) + _h;
        CGPathAddLineToPoint(pathRef, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef, NULL, _waveWidth, 40);
    CGPathAddLineToPoint(pathRef, NULL, 0, 40);
    CGPathCloseSubpath(pathRef);
    
    _layer.path = pathRef;
    _layer.fillColor = [UIColor lightGrayColor].CGColor;
    CGPathRelease(pathRef);
    
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    CGFloat startY2 = _waveHeight*sinf(_offset*M_PI/_waveWidth + M_PI/4);
    CGPathMoveToPoint(pathRef2, NULL, 0, startY2);
    for (CGFloat i = 0.0; i < _waveWidth; i ++) {
        CGFloat y = _waveHeight*sinf(2.5*M_PI*i/_waveWidth + 3*_offset*M_PI/_waveWidth + M_PI/4) + _h;
        CGPathAddLineToPoint(pathRef2, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef2, NULL, _waveWidth, 40);
    CGPathAddLineToPoint(pathRef2, NULL, 0, 40);
    CGPathCloseSubpath(pathRef2);
    
    _layer2.path = pathRef2;
    _layer2.fillColor = [UIColor lightGrayColor].CGColor;
    CGPathRelease(pathRef2);
}


@end

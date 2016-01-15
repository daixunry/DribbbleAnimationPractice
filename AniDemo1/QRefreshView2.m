//
//  QRefreshView2.m
//  AniDemo1
//
//  Created by daixu on 15/6/3.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "QRefreshView2.h"
#import "UIConfig.h"

@implementation QRefreshView2
{
    CAReplicatorLayer *_parLayer;
    CAShapeLayer *_layerArrow1;
    CAShapeLayer *_layerArc1;
    
    UIBezierPath *_startArrowPath1;
    UIBezierPath *_endArrowPath1;
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
    self.backgroundColor = [UIColor colorWithRed:34/255.0 green:233/255.0 blue:123/255.0 alpha:1];
    [self setLayers];
    [self setPaths];
}

- (void)setLayers
{
    _parLayer = [CAReplicatorLayer layer];
    _parLayer.frame = self.bounds;
    _parLayer.instanceCount = 2;
    _parLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    
    _layerArc1 = [CAShapeLayer layer];
    _layerArc1.fillColor = [UIColor clearColor].CGColor;
    _layerArc1.strokeColor = [UIColor whiteColor].CGColor;
    _layerArc1.lineWidth = 3;
    _layerArc1.contentsScale = [UIScreen mainScreen].scale;
    _layerArc1.lineCap = kCALineCapRound;
    
    _layerArrow1 = [CAShapeLayer layer];
    _layerArrow1.fillColor = [UIColor clearColor].CGColor;
    _layerArrow1.strokeColor = [UIColor whiteColor].CGColor;
    _layerArrow1.lineWidth = 3;
    _layerArrow1.lineCap = kCALineCapRound;
    _layerArrow1.contentsScale = [UIScreen mainScreen].scale;
    
    [_parLayer addSublayer:_layerArc1];
    [_parLayer addSublayer:_layerArrow1];
    [self.layer addSublayer:_parLayer];
}

- (void)setPaths
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(UTIL_View_Width(self)/2.0, UTIL_View_Height(self)/2.0) radius:40 startAngle:0 endAngle:M_PI_2*7/4 clockwise:YES];
    _layerArc1.path = path.CGPath;
    
    _startArrowPath1 = [UIBezierPath bezierPath];
    [_startArrowPath1 moveToPoint:CGPointMake(80, 54)];
    [_startArrowPath1 addLineToPoint:CGPointMake(90, 50)];
    [_startArrowPath1 addLineToPoint:CGPointMake(99, 56.5)];
    _layerArrow1.path = _startArrowPath1.CGPath;
    
    _endArrowPath1 = [UIBezierPath bezierPath];
    [_endArrowPath1 moveToPoint:CGPointMake(80, 42.5)];
    [_endArrowPath1 addLineToPoint:CGPointMake(90, 50)];
    [_endArrowPath1 addLineToPoint:CGPointMake(99, 44.5)];
}

- (void)beginAni
{
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    baseAni.fromValue = @(M_PI*2);
    baseAni.toValue = @(0);
    baseAni.duration = 2;
    baseAni.repeatCount = NSIntegerMax;
    [_parLayer addAnimation:baseAni forKey:@"ro1"];
    
    CAKeyframeAnimation *aniChangePath1 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    aniChangePath1.values = @[(__bridge id)_startArrowPath1.CGPath,(__bridge id)_endArrowPath1.CGPath,(__bridge id)_endArrowPath1.CGPath];
    aniChangePath1.keyTimes = @[@(0.45),@.75,@.95];
    aniChangePath1.autoreverses = YES;
    aniChangePath1.repeatCount = NSIntegerMax;
    aniChangePath1.duration = 1;
    
    [_layerArrow1 addAnimation:aniChangePath1 forKey:@"changePath"];
}

@end

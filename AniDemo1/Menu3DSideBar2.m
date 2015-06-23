//
//  Menu3DSideBar2.m
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/6/3.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "Menu3DSideBar2.h"

@implementation Menu3DSideBar2
{
    BOOL _open;
    CGFloat _offset;

    UIView *_mainView;
    CATransform3D _mainStartTrans;
    CATransform3D _touTrans;
    
    CAGradientLayer *_gradLayer;
    NSArray *_gradOpenColors;
    NSArray *_gradCloseColors;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(50, 64, frame.size.width, frame.size.height - 64)];
        [_mainView setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_mainView];
        
        [self setGradLayer];
        [self setInitTrans];
    }
    return self;
}

- (void)setGradLayer
{
    _gradOpenColors = @[(id)[[UIColor clearColor] CGColor],(id)[[UIColor clearColor] CGColor]];
    _gradCloseColors = @[(id)[[UIColor clearColor] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
    
    _gradLayer = [CAGradientLayer layer];
    _gradLayer.frame = _mainView.bounds;
    _gradLayer.colors = _gradCloseColors;
    _gradLayer.startPoint = CGPointMake(0, 0.5);
    _gradLayer.endPoint = CGPointMake(1,0.5);
    _gradLayer.locations = @[@(0.2),@(1)];
    
    [_mainView.layer addSublayer:_gradLayer];
}

- (void)setInitTrans
{
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1/500.0;
    
    _touTrans = tran;
    
    CATransform3D contaTran = CATransform3DRotate(_touTrans,-M_PI_2, 0, 1, 0);
    CATransform3D contaTran2 = CATransform3DMakeTranslation(-self.frame.size.width, 0, 0);
    
    _mainStartTrans = CATransform3DConcat(contaTran, contaTran2);
    _mainView.layer.anchorPoint = CGPointMake(1, 0.5);
    _mainView.layer.transform = _mainStartTrans;
}

- (void)setOffset:(CGFloat)offset
{
    if (_open == NO) {
        if (offset <= 0) {
            offset = 0;
        }
    } else {
        if (offset >= 0) {
            offset = 0;
        }
    }
    _offset = MIN(0.999, MAX(0, ABS(offset)));;
    
    _mainView.layer.timeOffset = _offset;
    _gradLayer.timeOffset = _offset;
    self.cshowMenuView.layer.timeOffset = _offset;
    self.containerView.layer.timeOffset = _offset;
}

- (void)aniContinue
{
    _mainView.layer.transform = [[_mainView.layer.presentationLayer valueForKeyPath:@"transform"] CATransform3DValue];
    _containerView.layer.transform = [[_containerView.layer.presentationLayer valueForKeyPath:@"transform"] CATransform3DValue];
    self.cshowMenuView.layer.transform = [[self.cshowMenuView.layer.presentationLayer valueForKeyPath:@"transform"] CATransform3DValue];
    _gradLayer.colors = [_gradLayer.presentationLayer valueForKeyPath:@"colors"];

    [self resetLayers];
    
    if (_open == NO) {
        if (_offset > 0.5) {
            _open = YES;
            [self openFold:1];
        } else {
            [self closeFold:1];
        }
    }
    else {
        if (_offset > 0.5) {
            _open = NO;
            [self closeFold:1];
        } else {
            [self openFold:1];
        }
    }
}

- (void)doAni
{
    [self resetLayers];
    
    if (_open == NO) {
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
        [self openFold:0];
    }
    else {
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[UIColor clearColor] CGColor]];
        [self closeFold:0];
    }
}

- (void)openFold:(CGFloat)speed
{
    [self addBasicTransformAni:_mainView.layer
                     fromValue:_mainView.layer.transform
                       toValue:_touTrans
                         speed:speed];
    [self addBasicTransformAni:self.containerView.layer
                     fromValue:self.containerView.layer.transform
                       toValue:CATransform3DMakeTranslation(100, 0, 0)
                         speed:speed];
    [self addBasicTransformAni:self.cshowMenuView.layer
                     fromValue:self.cshowMenuView.layer.transform
                       toValue:CATransform3DMakeRotation(M_PI_2, 0, 0, 1)
                         speed:speed];
    [self addBasicAniForLayer:_gradLayer keyPath:@"colors"
                    fromValue:_gradLayer.colors
                      toValue:_gradOpenColors
                        speed:speed];
    
    if (speed == 1) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        _mainView.layer.transform = _touTrans;
        _gradLayer.colors = _gradOpenColors;
        _containerView.layer.transform = CATransform3DMakeTranslation(100, 0, 0);
        self.cshowMenuView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
        
        [CATransaction commit];
    }
}

- (void)closeFold:(CGFloat)speed
{
    
    [self addBasicTransformAni:_mainView.layer
                     fromValue:_mainView.layer.transform
                       toValue:_mainStartTrans
                         speed:speed];
    [self addBasicTransformAni:self.containerView.layer
                     fromValue:self.containerView.layer.transform
                       toValue:CATransform3DIdentity
                         speed:speed];
    [self addBasicTransformAni:self.cshowMenuView.layer
                     fromValue:self.cshowMenuView.layer.transform
                       toValue:CATransform3DIdentity
                         speed:speed];
    [self addBasicAniForLayer:_gradLayer keyPath:@"colors"
                    fromValue:_gradLayer.colors
                      toValue:_gradCloseColors
                        speed:speed];
    
    if (speed == 1) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        _mainView.layer.transform = _mainStartTrans;
        _gradLayer.colors = _gradCloseColors;
        self.containerView.layer.transform = CATransform3DIdentity;
        self.cshowMenuView.layer.transform = CATransform3DIdentity;
        
        [CATransaction commit];
    }
}

- (void)addBasicTransformAni:(CALayer*)layer fromValue:(CATransform3D)from toValue:(CATransform3D)to speed:(CGFloat)speed
{
    [self addBasicAniForLayer:layer keyPath:@"transform" fromValue:[NSValue valueWithCATransform3D:from] toValue:[NSValue valueWithCATransform3D:to] speed:speed];
}

- (void)addBasicAniForLayer:(CALayer*)layer keyPath:(NSString *)key fromValue:(id)from toValue:(id)to speed:(CGFloat)speed
{
    CABasicAnimation *tranAni = [CABasicAnimation animationWithKeyPath:key];
    tranAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tranAni.fromValue = from;
    tranAni.toValue = to;
    tranAni.duration = (speed == 1)?.5:1;
    layer.speed = speed;
    [layer addAnimation:tranAni forKey:@"3dMenu"];
}

- (void)resetLayers
{
    _mainView.layer.timeOffset = 0;
    [_mainView.layer removeAllAnimations];
    
    _containerView.layer.timeOffset = 0;
    [_containerView.layer removeAllAnimations];
    
    self.cshowMenuView.layer.timeOffset = 0;
    [self.cshowMenuView.layer removeAllAnimations];
    
    [_gradLayer removeAllAnimations];
    _gradLayer.timeOffset = 0;
}

- (void)doOpenOrNot
{
    if (_open) {
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[UIColor clearColor] CGColor]];
        
        [self closeFold:1];
    } else {
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
        [self openFold:1];
    }
    _open = !_open;
}

@end

//
//  Menu3DSideBar.m
//  ReactiveCocoaStudy
//
//  Created by daixu on 15/6/1.
//  Copyright (c) 2015年 daixu. All rights reserved.
//

#import "Menu3DSideBar.h"

@implementation Menu3DSideBar
{
    UIView *_containView;
    UIView *_containHelperView;
    BOOL _open;
    CGFloat _rota;
    CAGradientLayer *_gradLayer;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _containView = [[UIView alloc] initWithFrame:CGRectMake(50, 64, frame.size.width, frame.size.height - 64)];
        _containHelperView = [[UIView alloc] initWithFrame:CGRectMake(50, 64, frame.size.width, frame.size.height - 64)];
        [self addSubview:_containView];
        [_containView setBackgroundColor:[UIColor orangeColor]];
        
        _gradLayer = [CAGradientLayer layer];
        _gradLayer.frame = _containView.bounds;
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
        _gradLayer.startPoint = CGPointMake(0, 0.5);
        _gradLayer.endPoint = CGPointMake(1,0.5);
        _gradLayer.locations = @[@(0.2),@(1)];
        [_containView.layer addSublayer:_gradLayer];
        
        self.backgroundColor = [UIColor blackColor];
        
        [self setInitTrans];
    }
    return self;
}

- (void)setInitTrans
{
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1/500.0;
    
    _containView.layer.anchorPoint = CGPointMake(1, 0.5);
    CATransform3D contaTran = CATransform3DRotate(tran,-M_PI_2, 0, 1, 0);
    CATransform3D contaTran2 = CATransform3DMakeTranslation(-self.frame.size.width, 0, 0);
    _containView.layer.transform = CATransform3DConcat(contaTran, contaTran2);
    
    _containHelperView.layer.anchorPoint = CGPointMake(1, 0.5);
    _containHelperView.layer.transform = contaTran;
}

- (CGFloat)setRota:(CGFloat)rota
{
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1/500.0;
    
    if (_open == NO) {
        if (rota <= 0) {
            rota = 0;
        }
        if (rota > M_PI_2) {
            rota = M_PI_2;
        }
        _rota = rota;
        
        self.cshowMenuView.transform = CGAffineTransformMakeRotation(rota);
        
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:((0.5-rota/2.0)>0)?0.5-rota/2.0:0] CGColor]];
        
        CATransform3D contaTran = CATransform3DRotate(tran,-M_PI_2 + rota, 0, 1, 0);
        _containHelperView.layer.transform = contaTran;
        CATransform3D contaTran2 = CATransform3DMakeTranslation(_containHelperView.frame.size.width - 100, 0, 0);
        _containView.layer.transform = CATransform3DConcat(contaTran, contaTran2);
        self.containerView.transform = CGAffineTransformMakeTranslation(_containHelperView.frame.size.width, 0);
        
        NSLog(@"x:%f,y:%f,w:%f,H:%f,rota:%f",_containView.frame.origin.x,_containView.frame.origin.y,_containView.frame.size.width,_containView.frame.size.height,rota);
        return _containHelperView.frame.size.width;
    }
    if (_open == YES) {
        if (rota >= 0) {
            rota = 0;
        }
        if (rota < -M_PI_2) {
            rota = -M_PI_2;
        }
        _rota = rota;
        self.cshowMenuView.transform = CGAffineTransformMakeRotation(M_PI_2+rota);
        _gradLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:((-rota/2.0)<0.5)?-rota/2.0:0.5] CGColor]];
        
        CATransform3D contaTran = CATransform3DRotate(tran, rota, 0, 1, 0);
        _containHelperView.layer.transform = contaTran;
        CATransform3D contaTran2 = CATransform3DMakeTranslation(_containHelperView.frame.size.width - 100, 0, 0);
        _containView.layer.transform = CATransform3DConcat(contaTran, contaTran2);
        self.containerView.transform = CGAffineTransformMakeTranslation(_containHelperView.frame.size.width, 0);
        
        return 0;
    }
    return 0;
}

- (void)closeFold
{
    _open = NO;
    [UIView animateWithDuration:.5 animations:^{
        [self setInitTrans];
        _containerView.layer.transform = CATransform3DIdentity;
    }];
    [UIView animateKeyframesWithDuration:.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        self.cshowMenuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)doAni
{
    if (_open == NO) {
        if (_rota > M_PI_4) {
            [self openFold];
        } else {
            [self closeFold];
        }
    }
    else {
        if (_rota > -M_PI_4) {
            [self openFold];
        } else {
            [self closeFold];
        }
    }
}

- (void)openFold
{
    _open = YES;
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1/500.0;

    CABasicAnimation *tranAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    tranAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tranAni.fromValue = [NSValue valueWithCATransform3D:_containView.layer.transform];
    tranAni.toValue = [NSValue valueWithCATransform3D:tran];
    tranAni.duration = .5;
    [_containView.layer addAnimation:tranAni forKey:@"11"];
    _containView.layer.transform = tran;
    _containHelperView.layer.transform = tran;
    
    CABasicAnimation *tranAni2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    tranAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tranAni2.fromValue = [NSValue valueWithCATransform3D:_containerView.layer.transform];
    tranAni2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 0, 0)];
    tranAni2.duration = .5;
    [_containerView.layer addAnimation:tranAni2 forKey:@"22"];
    _containerView.layer.transform = CATransform3DMakeTranslation(100, 0, 0);
    
    [UIView animateKeyframesWithDuration:.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        self.cshowMenuView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)doOpenOrNot
{
    if (_open) {
        [self closeFold];
    } else {
        [self openFold];
    }
}

@end

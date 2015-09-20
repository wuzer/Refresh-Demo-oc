//
//  JFRefreshView.m
//  Refresh-Demo-oc
//
//  Created by Jefferson on 15/9/18.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "JFRefreshView.h"

@interface JFRefreshView ()



@end

@implementation JFRefreshView

#pragma mark - 从xib加载控件
+ (instancetype)loadRefreshView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"JFRefreshView" owner:nil options:nil] lastObject];
}

- (void)setRotateFlag:(BOOL *)rotateFlag {
    
    self.rotateFlag = rotateFlag;
    rotateFlag = false;
    [self rotateTipAnimation];
}


// 提示图标动画
- (void)rotateTipAnimation {
    
    CGFloat angle = M_PI;
    angle += self.rotateFlag ? -0.01 : 0.01;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.pulldownTipIcon.transform = CGAffineTransformRotate(self.pulldownTipIcon.transform, angle);
    }];
}

// 加载动画
- (void)loadingAnimatjion {
    
    NSString *loadingKey = @"loadingKey";
    if ([self.loadingIcon.layer animationForKey:loadingKey] != nil) {
        return;
    }
    
    self.tipView.hidden = true;
    
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    animate.toValue = @"2 * M_PI";
    animate.repeatCount = MAXFLOAT;
    animate.duration = 1;
}

- (void)stopAnimation {
    
    self.tipView.hidden = false;
    [self.loadingIcon.layer removeAllAnimations];
}


@end

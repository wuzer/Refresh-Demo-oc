//
//  JFRefreshControl.m
//  Refresh-Demo-oc
//
//  Created by Jefferson on 15/9/18.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "JFRefreshControl.h"
#import "JFRefreshView.h"

static CGFloat JFRefreshControlMaxOffSet = -60;

@interface JFRefreshControl ()

@property (nonatomic, strong) JFRefreshView *refreshView;

@end


@implementation JFRefreshControl


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)endRefreshing {
    [super endRefreshing];
    
    [self.refreshView stopAnimation];
}

#pragma mark - kvo 函数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (self.frame.origin.y > 0) {
        return;
    }
    
    if (self.refreshing) {
        [self.refreshView loadingAnimatjion];
        return;
    }
    
    if (self.frame.origin.y < JFRefreshControlMaxOffSet && self.refreshView.rotateFlag) {
        printf("反过来");
        self.refreshView.rotateFlag = true;
    } else if (self.frame.origin.y >= JFRefreshControlMaxOffSet && self.refreshView.rotateFlag) {
        printf("转过去");
        self.refreshView.rotateFlag = false;
    }

}

// 注销监听
- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"frame"];
}

- (void)setupUI {
    
    // kvo 监听 frame 变化
    [self addObserver:self forKeyPath:@"frame" options:0 context:nil];
    
    // 隐藏转轮
    self.tintColor = [UIColor clearColor];
    
    // 添加控件
    [self addSubview:self.refreshView];
    
    
    // 自动布局
    self.refreshView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:1.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:1.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:60]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:156]];
    
//    [self.refreshView sizeToFit];
}

// 懒加载
- (JFRefreshView *)refreshView {
    
    if (!_refreshView) {
        _refreshView = [JFRefreshView loadRefreshView];
    }
    return _refreshView;
}


@end

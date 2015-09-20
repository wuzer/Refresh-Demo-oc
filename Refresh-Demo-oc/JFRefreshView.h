//
//  JFRefreshView.h
//  Refresh-Demo-oc
//
//  Created by Jefferson on 15/9/18.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFRefreshView : UIView

// 加载图标
@property (weak, nonatomic) IBOutlet UIImageView *loadingIcon;

// 提示视图
@property (weak, nonatomic) IBOutlet JFRefreshView *tipView;

// 下拉提示图标
@property (weak, nonatomic) IBOutlet UIImageView *pulldownTipIcon;


@property (nonatomic, assign) BOOL *rotateFlag;
+ (instancetype)loadRefreshView;
- (void)stopAnimation;
- (void)loadingAnimatjion;


@end

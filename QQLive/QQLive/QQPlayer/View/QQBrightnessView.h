//
//  QQBrightnessView.h
//  QQLive
//
//  Created by Mac on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

// 把单例方法定义为宏，使用起来更方便
#define QQBrightnessViewShared [QQBrightnessView sharedBrightnessView]

@interface QQBrightnessView : UIView

+ (instancetype)sharedBrightnessView;

/*--------------------单例记录播放器状态--------------------*/
/** 调用单例记录播放状态是否锁定屏幕方向*/
@property (nonatomic, assign) BOOL isLockScreen;
/** 是否开始过播放 */
@property (nonatomic, assign) BOOL isStartPlay;

@end

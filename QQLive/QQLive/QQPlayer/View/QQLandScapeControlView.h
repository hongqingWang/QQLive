//
//  QQLandScapeControlView.h
//  QQLive
//
//  Created by Mac on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQLandScapeControlViewDelegate <NSObject>

/** 返回按钮被点击 */
- (void)landScapeBackButtonClick;
/** 播放暂停按钮被点击 */
- (void)landScapePlayPauseButtonClick:(BOOL)isSelected;
/** 发送弹幕按钮被点击 */
- (void)landScapeSendBarrageButtonClick;
/** 打开关闭弹幕按钮被点击 */
- (void)landScapeOpenOrCloseBarrageButtonClick:(BOOL)isSelected;
/** 进度条开始拖动 */
- (void)landScapeProgressSliderBeginDrag;
/** 进度结束拖动，并返回最后的值 */
- (void)landScapeProgressSliderEndDrag:(CGFloat)value;
/** 退出全屏按钮被点击 */
- (void)landScapeExitFullScreenButtonClick;
/** 进度条tap点击 */
- (void)landScapeProgressSliderTapAction:(CGFloat)value;

@end

@interface QQLandScapeControlView : UIView

@property (nonatomic, weak) id <QQLandScapeControlViewDelegate> delegate;

/** 重置ControlView */
- (void)playerResetControlView;
- (void)playEndHideView:(BOOL)playeEnd;

// ---------------------------

/** 更新标题 */
- (void)syncTitle:(NSString *)title;

/** 更新播放/暂停按钮显示 */
- (void)syncplayPauseButton:(BOOL)isPlay;

/** 更新打开/关闭弹幕显示 */
- (void)syncOpenCloseBarrageButton:(BOOL)isOpen;

/** 更新缓冲进度 */
- (void)syncbufferProgress:(double)progress;

/** 更新播放进度 */
- (void)syncplayProgress:(double)progress;

/** 更新当前播放时间 */
- (void)syncplayTime:(NSInteger)time;

/** 更新视频时长 */
- (void)syncDurationTime:(NSInteger)time;

@end

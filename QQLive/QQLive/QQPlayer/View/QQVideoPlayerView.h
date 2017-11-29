//
//  QQVideoPlayerView.h
//  QQLive
//
//  Created by Mac on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQPlayerControlView.h"
@class QQPlayerStatusModel;

@protocol QQVideoPlayerViewDelagate <NSObject>
@optional
/** 双击事件 */
- (void)doubleTapAction;
/** pan开始水平移动 */
- (void)panHorizontalBeginMoved;
/** pan水平移动ing */
- (void)panHorizontalMoving:(CGFloat)value;
/** pan结束水平移动 */
- (void)panHorizontalEndMoved;
/** 音量改变 */
- (void)volumeValueChange:(CGFloat)value;

@end

@interface QQVideoPlayerView : UIView

/** 视频控制层, 自定义层 */
@property (nonatomic, strong, readonly) QQPlayerControlView *playerControlView;
/** 未播放, 封面的View */
@property (nonatomic, strong) QQCoverControlView *coverControlView;
/** 未播放, loading时的View */
@property (nonatomic, strong) QQLoadingView *loadingView;

/*
 *
 *
 */
+ (instancetype)videoPlayerViewWithSuperView:(UIView *)superview
                                    delegate:(id <QQVideoPlayerViewDelagate>)delegate
                           playerStatusModel:(QQPlayerStatusModel *)playerStatusModel;

/** 当前是否为全屏，默认为NO */
//@property (nonatomic, assign, getter=isFullScreen, readonly) BOOL fullScreen;

// 设置播放视图
- (void)setPlayerLayerView:(UIView *)playerLayerView;
/** 重置VideoPlayerView */
- (void)playerResetVideoPlayerView;
/**
 *  开始准备播放
 */
- (void)startReadyToPlay;
/**
 *  视频加载失败
 */
- (void)loadFailed;
/**
 *  设置横屏或竖屏
 */
- (void)shrinkOrFullScreen:(BOOL)isFull;
/**
 *  播放完了
 */
- (void)playDidEnd;
/**
 *  重新播放
 */
- (void)repeatPlay;

@end

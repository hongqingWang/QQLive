//
//  QQCoverControlView.h
//  QQLive
//
//  Created by Mac on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQCoverControlViewDelegate <NSObject>

/** 返回按钮被点击 */
- (void)coverControlViewBackButtonClick;
/** 分享按钮被点击 */
- (void)coverControlViewShareButtonClick;
/** 封面图片Tap事件 */
- (void)coverControlViewBackgroundImageViewTapAction;

@end

@interface QQCoverControlView : UIView

@property (nonatomic, weak) id<QQCoverControlViewDelegate> delegate;
/** 更新封面图片 */
- (void)syncCoverImageViewWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end

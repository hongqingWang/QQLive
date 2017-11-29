//
//  QQLoadingView.h
//  QQLive
//
//  Created by Mac on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQLoadingViewDelegate <NSObject>

/** 返回按钮被点击 */
- (void)loadingViewBackButtonClick;
/** 分享按钮被点击 */
- (void)loadingViewShareButtonClick;
@end

@interface QQLoadingView : UIView

@property (nonatomic, weak) id<QQLoadingViewDelegate> delegate;

@end

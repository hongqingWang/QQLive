//
//  QQPlayerStatusModel.m
//  QQLive
//
//  Created by Mac on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQPlayerStatusModel.h"

@implementation QQPlayerStatusModel

/**
 重置状态模型属性
 */
- (void)playerResetStatusModel {
    self.autoPlay = NO;
    self.playDidEnd = NO;
    self.dragged = NO;
    self.didEnterBackground = NO;
    self.pauseByUser = YES;
    self.fullScreen = NO;
}

@end

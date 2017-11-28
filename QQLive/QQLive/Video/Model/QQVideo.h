//
//  QQVideo.h
//  adsasd
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQVideo : NSObject

/** 视频宽度 */
@property (nonatomic, assign) NSInteger width;
/** 视频高度 */
@property (nonatomic, assign) NSInteger height;
/** 视频时长 */
@property (nonatomic, copy) NSString *duration;

@end

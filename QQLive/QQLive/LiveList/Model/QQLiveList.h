//
//  QQLiveList.h
//  adsasd
//
//  Created by Mac on 2017/11/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQLive;

@interface QQLiveList : NSObject

/** 直播名称 */
@property (nonatomic, copy) NSString *name;
/** 主播所在城市 */
@property (nonatomic, copy) NSString *city;
/** 在线人数 */
@property (nonatomic, assign) NSInteger online_users;
/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 主播信息模型 */
@property (nonatomic, strong) QQLive *creator;

@end

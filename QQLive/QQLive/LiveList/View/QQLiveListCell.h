//
//  QQLiveListCell.h
//  adsasd
//
//  Created by Mac on 2017/11/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQLiveList;

@interface QQLiveListCell : UITableViewCell

+ (instancetype)liveListCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) QQLiveList *liveList;

@end

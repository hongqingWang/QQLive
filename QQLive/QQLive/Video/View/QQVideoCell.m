//
//  QQVideoCell.m
//  QQLive
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQVideoCell.h"
#import "UIView+QQ.h"
#import <Masonry.h>

@interface QQVideoCell ()


@property (nonatomic, strong) UIButton *button;

@end

@implementation QQVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
}

+ (instancetype)videoCellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"QQVideoCell";
    QQVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QQVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setupUI {
    
    [self addSubview:self.button];
}

- (void)layoutSubviews {
    
//    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
}

#pragma mark - Getters and Setters
- (UIButton *)button {

    if (_button == nil) {

        _button = [[UIButton alloc] init];
        [_button setTitle:@"aaa" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _button;
}

@end

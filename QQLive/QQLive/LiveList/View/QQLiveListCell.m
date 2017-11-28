//
//  QQLiveListCell.m
//  adsasd
//
//  Created by Mac on 2017/11/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQLiveListCell.h"
#import <Masonry.h>
#import "QQLiveList.h"
#import "QQLive.h"
#import <UIImageView+WebCache.h>

@interface QQLiveListCell ()

/** 头像 */
@property (nonatomic, strong) UIImageView *avatarImageView;
/** 直播名 */
@property (nonatomic, strong) UILabel *liveTitleLabel;
/** 直播地址 */
@property (nonatomic, strong) UILabel *liveAddressLabel;
/** 在线人数 */
@property (nonatomic, strong) UILabel *onlineLabel;
/** 背景 */
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation QQLiveListCell

- (void)setLiveList:(QQLiveList *)liveList {
    
    _liveList = liveList;
    
    NSURL *avatarUrl = [NSURL URLWithString:liveList.creator.portrait];
    [self.avatarImageView sd_setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"qq_avatar"]];
    
    if ([liveList.name isEqualToString:@""]) {
        self.liveTitleLabel.text = @"直播";
    } else {
        self.liveTitleLabel.text = liveList.name;
    }
    
    if ([liveList.city isEqualToString:@""]) {
        self.liveAddressLabel.text = @"无地址";
    } else {
        self.liveAddressLabel.text = liveList.city;
    }
    
    [self.backgroundImageView sd_setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"qq_avatar"]];
    
    NSString *string = [NSString stringWithFormat:@"%zd人在看", liveList.online_users];
    NSRange range = [string rangeOfString:[NSString stringWithFormat:@"%zd", liveList.online_users]];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    UIColor *onlineColor = [UIColor colorWithRed:216 / 255.0 green:41 / 255.0 blue:116 / 255.0 alpha:1];
    [attrString addAttribute:NSForegroundColorAttributeName value:onlineColor range:range];
    self.onlineLabel.attributedText = attrString;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
}

+ (instancetype)liveListCellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"QQLiveListCell";
    QQLiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QQLiveListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setupUI {
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.liveTitleLabel];
    [self addSubview:self.liveAddressLabel];
    [self addSubview:self.onlineLabel];
    [self addSubview:self.backgroundImageView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(16);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.liveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.mas_right).offset(8);
    }];
    [self.liveAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarImageView);
        make.left.equalTo(self.liveTitleLabel);
    }];
    [self.onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarImageView);
        make.right.equalTo(self).offset(-16);
    }];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(8);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
}

#pragma mark - Getters and Setters
- (UIImageView *)avatarImageView {
    
    if (_avatarImageView == nil) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 20;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)liveTitleLabel {
    
    if (_liveTitleLabel == nil) {
        
        _liveTitleLabel = [[UILabel alloc] init];
        _liveTitleLabel.text = @"直播名称";
        _liveTitleLabel.textColor = [UIColor grayColor];
        _liveTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _liveTitleLabel;
}

- (UILabel *)liveAddressLabel {
    
    if (_liveAddressLabel == nil) {
        
        _liveAddressLabel = [[UILabel alloc] init];
        _liveAddressLabel.text = @"厦门市";
        _liveAddressLabel.textColor = [UIColor lightGrayColor];
        _liveAddressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _liveAddressLabel;
}

- (UILabel *)onlineLabel {
    
    if (_onlineLabel == nil) {
        
        _onlineLabel = [[UILabel alloc] init];
        _onlineLabel.text = @"1234人在看";
        _onlineLabel.font = [UIFont systemFontOfSize:12];
    }
    return _onlineLabel;
}

- (UIImageView *)backgroundImageView {
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _backgroundImageView;
}

@end

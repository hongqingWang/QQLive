//
//  QQLiveController.m
//  adsasd
//
//  Created by Mac on 2017/11/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQLiveController.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "QQLiveList.h"
#import "QQLive.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface QQLiveController ()

/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 背景图片 */
@property (nonatomic, strong) UIImageView *backgroundImageView;
/** 播放控制器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation QQLiveController

#pragma mark - Left Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 界面消失,停止播放,不然会崩溃
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
}

#pragma mark - Private Method
- (void)livePlay {
    
    NSURL *url = [NSURL URLWithString:self.liveList.stream_addr];
    
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    [playerVc prepareToPlay];
    
    self.player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
//    playerVc.view.frame = CGRectMake(16, 100, [UIScreen mainScreen].bounds.size.width - (16 * 2), 100);
    
//    playerVc.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.view insertSubview:self.player.view atIndex:1];
}

#pragma mark - setupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *avatarUrl = [NSURL URLWithString:self.liveList.creator.portrait];
    [self.backgroundImageView sd_setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"qq_avatar"]];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.backButton];
    
    [self livePlay];
}

#pragma mark - Event Response
- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getters and Setters
- (UIButton *)backButton {
    
    if (_backButton == nil) {
        
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"qq_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _backButton.frame = CGRectMake(11, 17, 44, 44);
    }
    return _backButton;
}

- (UIImageView *)backgroundImageView {
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = self.view.bounds;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

@end

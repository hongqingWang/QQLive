//
//  QQVideoViewController.m
//  adsasd
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQVideoViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "QQNetworkManager.h"
#import <MJExtension.h>
#import "QQVideo.h"

//#import "UIView+HQCategory.h"

@interface QQVideoViewController ()

/** 播放控制器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;
/** 视频的宽度 */
@property (nonatomic, assign) NSInteger videoWidth;
/** 视频的高度 */
@property (nonatomic, assign) NSInteger videoHeight;

@end

@implementation QQVideoViewController

#pragma mark - Left Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"视频播放";
    
    
    [self loadData];
//    IJKMPMovieNaturalSizeAvailableNotification
    [[NSNotificationCenter defaultCenter] addObserverForName:IJKMPMovieNaturalSizeAvailableNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"IJKMPMovieNaturalSizeAvailableNotification = %@", note.object);
        IJKFFMoviePlayerController *vc = note.object;
        NSLog(@"vc.naturalSize = %@", NSStringFromCGSize(vc.naturalSize));
        NSInteger videoWidth = vc.naturalSize.width;
        NSInteger videoHeigth = vc.naturalSize.height;
        NSLog(@"aaa===%ld", videoWidth);
        NSLog(@"%ld", videoHeigth);
        self.videoWidth = videoWidth;
        self.videoHeight = videoHeigth;
    }];
    
    
    [self playVideo];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaa) name:IJKMPMovieNaturalSizeAvailableNotification object:nil];
}

//- (void)aaa {
//
////    NSLog(@"%@");
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//
//    self.player.view.frame = CGRectMake(0, 100, 375, 200);
//    NSLog(@"viewWillLayoutSubviews = %ld", self.videoWidth);
//    NSLog(@"%ld", self.videoWidth);
//}

#pragma mark - playVideo
- (void)playVideo {
    
    NSLog(@"playVideo = %ld", self.videoWidth);
    NSLog(@"%ld", self.videoHeight);
    
    NSURL *url = [NSURL URLWithString:@"http://img.zzf.sos-life.com//o_1bs56d5m31htgt3tsl51hqv2ma9.mp4"];
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    [playerVc prepareToPlay];
//    NaturalSizeAvailable
    self.player = playerVc;
//    NSLog(@"ijkplayer 视频尺寸 = %@", NSStringFromCGSize(playerVc.naturalSize));
//    playerVc.view.frame = CGRectMake(16, 100, [UIScreen mainScreen].bounds.size.width - (16 * 2), 100);
//    playerVc.view.frame = self.view.bounds;
//    playerVc.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:playerVc.view];
    NSLog(@"ijkplayer 视频尺寸 = %@", NSStringFromCGSize(playerVc.naturalSize));
}

#pragma mark - Load Data
- (void)loadData {
    
    
    
    NSString *urlString = @"http://img.zzf.sos-life.com//o_1bs56d5m31htgt3tsl51hqv2ma9.mp4?avinfo";
    [[QQNetworkManager sharedManager] qq_request:GET urlString:urlString parameters:nil finished:^(id result, NSError *error) {
        
        if (error) {
            NSLog(@"QQVideoViewController - 获取视频具体信息 - error = %@", error);
            return;
        }
        NSLog(@"QQVideoViewController - 获取视频具体信息 - result = %@", result);
        
        NSDictionary *dict = result[@"streams"][0];
        QQVideo *video = [QQVideo mj_objectWithKeyValues:dict];
        NSLog(@"视频的宽 = %ld", video.width);
        NSLog(@"视频的高 = %ld", video.height);
        NSLog(@"视频的时长 = %@", video.duration);
        self.videoWidth = video.width;
//        CGFloat videoWidth = [video.width ]
//        self.player.view.frame = CGRectMake(0, 100, video.width, video.height);
        
        CGFloat videoWidth;
        CGFloat videoHeight;
        
        if (video.width >= [UIScreen mainScreen].bounds.size.width) {
            
            videoWidth = [UIScreen mainScreen].bounds.size.width;
            videoHeight = ([UIScreen mainScreen].bounds.size.width * video.height) / video.width;
            
        } else {
            
            videoWidth = video.width;
            videoHeight = video.height;
        }
        self.player.view.frame = CGRectMake(0, 64 + 5, videoWidth, videoHeight);
    }];
}

@end

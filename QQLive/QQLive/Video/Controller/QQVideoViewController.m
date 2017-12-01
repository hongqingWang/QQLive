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
#import "QQVideoCell.h"
#import <Masonry.h>

#import "QQPlayer.h"

#define QQ_PLAY_VIDEO_CELL_HEIGHT               200

@interface QQVideoViewController ()<UITableViewDataSource, QQVideoPlayerDelegate>
/** 状态栏的背景 */
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) QQVideoPlayer *player;
@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) QQPlayerModel *playerModel;

/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
/** 离开页面时候是否开始过播放 */
@property (nonatomic, assign) BOOL isStartPlay;


/** 新视频按钮 */
@property (nonatomic, strong) UIButton *nextVideoBtn;
/** 下一页 */
@property (nonatomic, strong) UIButton *nextPageBtn;

/**************************************** 下面的是以前的 ****************************************/
/** 播放控制器 */
//@property (nonatomic, strong) IJKFFMoviePlayerController *player;
/** 视频地址集合 */
@property (nonatomic, strong) NSArray *videoUrls;
/** TableView */
@property (nonatomic, strong) UITableView *tableView;
///** 视频的宽度 */
//@property (nonatomic, assign) NSInteger videoWidth;
///** 视频的高度 */
//@property (nonatomic, assign) NSInteger videoHeight;

@end

@implementation QQVideoViewController

#pragma mark - Left Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    // pop回来时候是否自动播放
    if (self.player && self.isPlaying) {
        self.isPlaying = NO;
        [self.player playVideo];
    }
    QQBrightnessViewShared.isStartPlay = self.isStartPlay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self loadData];
//    [self playVideo];
    
    /**
     * 监听通知只为了拿到视频的宽高,但是拿到了目前用途不大
     */
//    [[NSNotificationCenter defaultCenter] addObserverForName:IJKMPMovieNaturalSizeAvailableNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"IJKMPMovieNaturalSizeAvailableNotification = %@", note.object);
//        IJKFFMoviePlayerController *vc = note.object;
//        NSLog(@"vc.naturalSize = %@", NSStringFromCGSize(vc.naturalSize));
//        NSInteger videoWidth = vc.naturalSize.width;
//        NSInteger videoHeigth = vc.naturalSize.height;
//        NSLog(@"aaa===%ld", videoWidth);
//        NSLog(@"%ld", videoHeigth);
//    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    // push出下一级页面时候暂停
    if (self.player && !self.player.isPauseByUser) {
        self.isPlaying = YES;
        [self.player pauseVideo];
    }
    
    QQBrightnessViewShared.isStartPlay = NO;
}

- (void)dealloc {
    NSLog(@"---------------dealloc------------------");
    [self.player destroyVideo];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"视频列表";
    self.isStartPlay = NO;
    
    [self.view addSubview:self.nextVideoBtn];
    [self.view addSubview:self.nextPageBtn];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.playerFatherView];
    
    
//    [self.view addSubview:self.tableView];
    [self makePlayViewConstraints];
    
    QQPlayerModel *model = [[QQPlayerModel alloc] init];
    //    model.videoURL = [NSURL URLWithString:@"http://img.zzf.sos-life.com//o_1bs56d5m31htgt3tsl51hqv2ma9.mp4"];
    model.videoURL = [NSURL URLWithString:@"http://img.zzf.sos-life.com//o_1bs05aspf15b75b01rtmjsi11om9.mp4"];
    model.seekTime = 20;
    model.viewTime = 200;
    
    QQVideoPlayer *player = [QQVideoPlayer videoPlayerWithView:self.playerFatherView delegate:self playerModel:model];
    self.player = player;
}

- (void)nextVideoBtnClick {
    
    if (self.isStartPlay) {
        
        QQPlayerModel *model = [[QQPlayerModel alloc] init];
        model.videoURL = [NSURL URLWithString:@"http://img.zzf.sos-life.com//o_1bs56d5m31htgt3tsl51hqv2ma9.mp4"];
        [self.player resetToPlayNewVideo:model];
    }
}

- (void)nextPageBtnClick {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 添加子控件的约束
- (void)makePlayViewConstraints {
    
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(20);
    }];
    
    [self.nextVideoBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-130);
        make.height.mas_offset(30);
        make.width.mas_offset(150);
    }];
    
    [self.nextPageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-80);
        make.height.mas_offset(30);
        make.width.mas_offset(150);
    }];
}
#pragma mark - 屏幕旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
    
        [self.playerFatherView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(20);
        }];
        
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        [self.playerFatherView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];
    }
}

#pragma mark - LMVideoPlayerDelegate
/** 返回按钮被点击 */
- (void)playerBackButtonClick {
    [self.player destroyVideo];
    [self.navigationController popViewControllerAnimated:YES];
}

/** 控制层封面点击事件的回调 */
- (void)controlViewTapAction {
    if (_player) {
        [self.player autoPlayTheVideo];
        self.isStartPlay = YES;
    }
}

#pragma mark - getter
- (UIView *)topView {
    
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UIView *)playerFatherView {
    
    if (!_playerFatherView) {
        
        _playerFatherView = [[UIView alloc] init];
    }
    return _playerFatherView;
}

- (QQPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel = [[QQPlayerModel alloc] init];
    }
    return _playerModel;
}

- (UIButton *)nextVideoBtn {
    if (!_nextVideoBtn) {
        _nextVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextVideoBtn setTitle:@"当前页播放新视频" forState:UIControlStateNormal];
        _nextVideoBtn.backgroundColor = [UIColor redColor];
        [_nextVideoBtn addTarget:self action:@selector(nextVideoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextVideoBtn;
}

- (UIButton *)nextPageBtn {
    if (!_nextPageBtn) {
        _nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextPageBtn setTitle:@"下一页" forState:UIControlStateNormal];
        _nextPageBtn.backgroundColor = [UIColor redColor];
        [_nextPageBtn addTarget:self action:@selector(nextPageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextPageBtn;
}


//#pragma mark - playVideo
//- (void)playVideo {
//
//    NSURL *url = [NSURL URLWithString:self.videoUrls[2]];
//    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
//    [playerVc prepareToPlay];
//    self.player = playerVc;
//    [self.view addSubview:playerVc.view];
//}
//
//#pragma mark - Load Data
//- (void)loadDataWithIndexPath:(NSIndexPath *)indexPath {
//
//    NSString *urlString = [NSString stringWithFormat:@"%@?avinfo", self.videoUrls[2]];
//
//    [[QQNetworkManager sharedManager] qq_request:GET urlString:urlString parameters:nil finished:^(id result, NSError *error) {
//
//        if (error) {
//            NSLog(@"QQVideoViewController - 获取视频具体信息 - error = %@", error);
//            return;
//        }
//        NSLog(@"QQVideoViewController - 获取视频具体信息 - result = %@", result);
//
//        NSDictionary *dict = result[@"streams"][0];
//        QQVideo *video = [QQVideo mj_objectWithKeyValues:dict];
//        NSLog(@"视频的宽 = %ld", video.width);
//        NSLog(@"视频的高 = %ld", video.height);
//        NSLog(@"视频的时长 = %@", video.duration);
//
//        CGFloat videoWidth;
//        CGFloat videoHeight;
//
//        videoHeight = QQ_PLAY_VIDEO_CELL_HEIGHT;
//        videoWidth = QQ_PLAY_VIDEO_CELL_HEIGHT * video.width / video.height;
//
////        if (video.width >= [UIScreen mainScreen].bounds.size.width) {
////
////            videoWidth = [UIScreen mainScreen].bounds.size.width;
////            videoHeight = ([UIScreen mainScreen].bounds.size.width * video.height) / video.width;
////
////        } else {
////
////            videoWidth = video.width;
////            videoHeight = video.height;
////        }
//
////        videoHeight = QQ_PLAY_VIDEO_CELL_HEIGHT;
////        videoWidth = QQ_PLAY_VIDEO_CELL_HEIGHT * video.width / video.height;
//
////        self.player.view.frame = CGRectMake(0, 64 + 5, videoWidth, videoHeight);
//        [self.player.view mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(videoWidth);
//            make.height.mas_equalTo(videoHeight);
//        }];
//    }];
//}
//
//#pragma mark - UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
////    return self.videoUrls.count;
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [self loadDataWithIndexPath:indexPath];
//
//    QQVideoCell *cell = [QQVideoCell videoCellWithTableView:tableView];
//
//    NSURL *url = [NSURL URLWithString:self.videoUrls[2]];
//    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
//    [playerVc prepareToPlay];
//    self.player = playerVc;
//    [cell addSubview:playerVc.view];
//    cell.backgroundColor = [UIColor redColor];
//    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(cell);
//    }];
//
//    return cell;
//}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        CGRect frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.rowHeight = QQ_PLAY_VIDEO_CELL_HEIGHT;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)videoUrls {
    
    if (_videoUrls == nil) {
        
        _videoUrls = @[
                       @"http://img.zzf.sos-life.com//o_1bshtsgjub9i4ehvs44qrp939.mp4",
                       @"http://img.zzf.sos-life.com//o_1bs56d5m31htgt3tsl51hqv2ma9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bs05aspf15b75b01rtmjsi11om9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1to4vh10nqseb1ifc14h61vha9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1tjhhe4c21mgjn8mk421k6i9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1th0i5119b5431bh01mntu6t9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1tdqdg10ivbv91jh1vkvn47j.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1t6m6h4sia0c1vku74215a59.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1r54olig6lfasd4ni82pq9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1qlujg1m49ekd1a5bhah1eqr9.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1qibq61g7v13enbh4589dk89.mp4",
                       @"http://img.zzf.sos-life.com//o_1bq1qevi418bd1aog74j1moi1vmp9.mp4"
                       ];
    }
    return _videoUrls;
}

@end

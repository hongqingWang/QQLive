//
//  QQLiveListController.m
//  adsasd
//
//  Created by Mac on 2017/11/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQLiveListController.h"
#import "QQLiveListCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "QQNetworkManager.h"
#import "QQLiveList.h"
#import "QQLiveController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface QQLiveListController ()<UITableViewDataSource, UITableViewDelegate>

/** TableView */
@property (nonatomic, strong) UITableView *tableView;
/** 直播列表 */
@property (nonatomic, strong) NSMutableArray *lives;
/** 播放控制器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation QQLiveListController

#pragma mark - Left Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 界面消失,停止播放,不然会崩溃
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
}

#pragma mark - Load Data
- (void)loadData {
    
    NSString *urlString = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    [[QQNetworkManager sharedManager] qq_request:GET urlString:urlString parameters:nil finished:^(id result, NSError *error) {
        NSLog(@"QQLiveListController - 直播列表 = %@", result);
        
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        self.lives = [QQLiveList mj_objectArrayWithKeyValuesArray:result[@"lives"]];
        [self.tableView reloadData];
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"直播列表";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQLiveListCell *cell = [QQLiveListCell liveListCellWithTableView:tableView];
    
    cell.liveList = self.lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QQLiveList *liveList = self.lives[indexPath.row];
    
//    NSURL *url = [NSURL URLWithString:liveList.stream_addr];
//
//    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
//
//    [playerVc prepareToPlay];
//
//    self.player = playerVc;
//
//    playerVc.view.frame = CGRectZero;
//
//    [self.view insertSubview:self.player.view atIndex:1];
    
//    return;
    
    QQLiveController *vc = [[QQLiveController alloc] init];
    vc.liveList = self.lives[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        CGRect frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 436;
    }
    return _tableView;
}

- (NSMutableArray *)lives {
    
    if (_lives == nil) {
        
        _lives = [NSMutableArray array];
    }
    return _lives;
}

@end

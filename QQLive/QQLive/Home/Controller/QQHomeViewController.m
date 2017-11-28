//
//  QQHomeViewController.m
//  QQLive
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQHomeViewController.h"
#import "QQHomeCell.h"
#import "QQLiveListController.h"
#import "QQVideoViewController.h"

@interface QQHomeViewController ()

/** 标题数组 */
@property (nonatomic, strong) NSArray *titles;

@end

@implementation QQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQHomeCell *cell = [QQHomeCell homeCellWithTableView:tableView];
    
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:                                     // 直播列表
        {
            QQLiveListController *vc = [[QQLiveListController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:                                     // 视频播放
        {
            QQVideoViewController *vc = [[QQVideoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters and Setters
- (NSArray *)titles {
    
    if (_titles == nil) {
        
        _titles = @[
                    @"直播列表",
                    @"视频播放"
                    ];
    }
    return _titles;
}

@end

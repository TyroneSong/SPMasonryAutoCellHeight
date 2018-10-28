//
//  ViewController.m
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "UITableViewCell+SPMasonryAutoCellHeight.h"
#import "SPNewsModel.h"
#import "SPNewsCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

#pragma mark - ----  Delegate  ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    
    SPNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SPNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    SPNewsModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = [self.dataSource objectAtIndex:indexPath.row];
    }
    [cell configCellWithModel:model];
    
    cell.expandBlock = ^(BOOL isExpand) {
        model.isExpand = isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPNewsModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = [self.dataSource objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [SPNewsCell sp_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SPNewsCell *cell = (SPNewsCell *)sourceCell;
        //配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kSPCacheUniqueKey  : [NSString stringWithFormat:@"%d", model.uid],
                 kSPCacheStateKey   : stateKey,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kSPRecalculateForStateKey: @(NO)// 标识不用重新更新
                 };
    }];
}


#pragma mark - ----  E  ----
- (NSString *)titleAll {
    return @"欢迎使用HYBMasonryAutoCellHeight扩展，由作者huangyibiao提供，如有任何疑问，请给作者发email：huangyibiao520@163.com，谢谢您的支持！！！";
}

- (NSString *)descAll {
    return @"HYBMasonryAutoCellHeight是基于Masonry第三方开源库而实现的，如想更深入了解Masonry，可直接到github上的官方文档阅读，或可以到作者的博客中阅读相关文章：http://www.hybblog.com/masonryjie-shao/，如果阅读时有疑问，可直接联系作者（email或者QQ），最直接的方式就是在文章后面留言，作者会在收到反馈后的第一时间迅速查看，并给予相应的回复。欢迎留言，希望我们能成为朋友。";
}


#pragma mark - ----  Getter/Setter  ----
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        
        
        int titleTotalLength = (int)[[self titleAll] length];
        int descTotalLength = (int)[[self descAll] length];
        for (NSUInteger i = 0; i < 40; ++i) {
            int titleLength = rand() % titleTotalLength + 15;
            if (titleLength > titleTotalLength - 1) {
                titleLength = titleTotalLength;
            }
            
            SPNewsModel *model = [[SPNewsModel alloc] init];
            model.title = [[self titleAll] substringToIndex:titleLength];
            model.uid = (int)i + 1;
            model.isExpand = YES;
            
            int descLength = rand() % descTotalLength + 20;
            if (descLength >= descTotalLength) {
                descLength = descTotalLength;
            }
            model.desc = [[self descAll] substringToIndex:descLength];
            
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

@end

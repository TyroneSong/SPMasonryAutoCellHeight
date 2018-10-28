//
//  UITableViewCell+SPMasonryAutoCellHeight.h
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+SPCacheHeight.h"

/** 获取高度前会回调，需要在此BLOCK中配置数据，才能正确地获取高度 */
typedef void(^SPCellBlock) (UITableViewCell *sourceCell);

typedef NSDictionary *(^SPCacheHeight)();

/** 唯一键，通常是数据模型的id，保证唯一 */
FOUNDATION_EXTERN NSString * const kSPCacheUniqueKey;

/** 对于同一个model，如果有不同状态，而且不同状态下高度不一样，那么也需要指定 */
FOUNDATION_EXTERN NSString * const kSPCacheStateKey;

/** 用于指定更新某种状态的缓存，比如当评论时，增加了一条评论，此时该状态的高度若已经缓存过，则需要指定来更新缓存 */
FOUNDATION_EXTERN NSString * const kSPRecalculateForStateKey;


/**
 基于Masonry自动布局实现的自动计算cell的行高扩展
 */
@interface UITableViewCell (SPMasonryAutoCellHeight)

/** 最后一个view距离Cell的Bottom距离 */
@property (nonatomic, assign) CGFloat sp_bottomOffsetToCell;
 
/**
 通过此方法来计算行高，需要在config中调用配置数据的API

 @param tableView 必传，为哪个tableView缓存行高
 @param config 必须要实现，且需要调用配置数据的API，
 @return 计算的行高
 */
+ (CGFloat)sp_heightForTableView:(UITableView *)tableView
                          config:(SPCellBlock)config;


/**
 缓存行高

 @param tableView 必传，为哪个tableView缓存行高
 @param config 必须要实现，且需要调用配置数据的API
 @param cache 返回相关key
 @return 行高
 */
+ (CGFloat)sp_heightForTableView:(UITableView *)tableView
                          config:(SPCellBlock)config
                           cache:(SPCacheHeight)cache;

@end



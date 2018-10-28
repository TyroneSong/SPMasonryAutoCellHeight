//
//  UITableView+SPCacheHeight.h
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SPCacheHeight)

/** 缓存Cell行高 */
@property (nonatomic, strong, readonly) NSMutableDictionary *sp_cacheCellHeightDic;
/** 用于获取或者添加计算行高的cell，因为理论上只有一个cell用来计算行高，以降低消耗 */
@property (nonatomic, strong) NSMutableDictionary *sp_reuseCells;

@end

NS_ASSUME_NONNULL_END

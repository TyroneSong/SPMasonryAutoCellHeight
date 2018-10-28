//
//  UITableViewCell+SPMasonryAutoCellHeight.m
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import "UITableViewCell+SPMasonryAutoCellHeight.h"
#import <objc/runtime.h>

NSString * const kSPCacheUniqueKey          = @"kSPCacheUniqueKey";
NSString * const kSPCacheStateKey           = @"kSPCacheStateKey";
NSString * const kSPRecalculateForStateKey  = @"kSPRecalculateForStateKey";
NSString * const kSPCacheForTableViewKey    = @"kSPCacheForTableViewKey";

const void *s_sp_bottomOffsetToCellKey      = "s_sp_bottomOffsetToCellKey";

@implementation UITableViewCell (SPMasonryAutoCellHeight)

+ (CGFloat)sp_heightForTableView:(UITableView *)tableView config:(SPCellBlock)config {
    UITableViewCell *cell = [tableView.sp_reuseCells objectForKey:[[self class] description]];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [tableView.sp_reuseCells setObject:cell forKey:[[self class] description]];
    }
    
    if (config) {
        config(cell);
    }
    
    return [cell private_sp_heightForTableView:tableView];
}

+ (CGFloat)sp_heightForTableView:(UITableView *)tableView config:(SPCellBlock)config cache:(SPCacheHeight)cache {
    
    NSAssert(tableView, @"tableView is necessary param");
    
    if (cache) {
        NSDictionary *cacheKeys = cache();
        NSString *key = cacheKeys[kSPCacheUniqueKey];
        NSString *stateKey = cacheKeys[kSPCacheStateKey];
        NSString *shouldUpdate = cacheKeys[kSPRecalculateForStateKey];
        
        NSMutableDictionary *stateDict = tableView.sp_cacheCellHeightDic[key];
        NSString *cacheHeight = stateDict[stateKey];
        
        if (tableView.sp_cacheCellHeightDic.count == 0
            || shouldUpdate.boolValue
            || cacheHeight == nil) {
            CGFloat height = [self sp_heightForTableView:tableView config:config];
            
            if (stateDict == nil) {
                stateDict = [[NSMutableDictionary alloc] init];
                tableView.sp_cacheCellHeightDic[key] = stateDict;
            }
            
            [stateDict setObject:[NSString stringWithFormat:@"%1f", height] forKey:stateKey];
            
            return height;
        } else if (tableView.sp_cacheCellHeightDic.count != 0
                   && cacheHeight != nil
                   && cacheHeight.integerValue != 0) {
            return cacheHeight.floatValue;
        }
    }
    
    return [self sp_heightForTableView:tableView config:config];
    
}

#pragma mark - ----  Getter/Setter  ----
- (void)setSp_bottomOffsetToCell:(CGFloat)sp_bottomOffsetToCell {
    objc_setAssociatedObject(self,
                             s_sp_bottomOffsetToCellKey,
                             @(sp_bottomOffsetToCell),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)sp_bottomOffsetToCell {
    NSNumber *valueObject = objc_getAssociatedObject(self, s_sp_bottomOffsetToCellKey);
    
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return  valueObject.floatValue;
    }
    
    return 0.0;
}

#pragma mark - ----  Private  ----
- (CGFloat)private_sp_heightForTableView:(UITableView *)tableView {
    [self setNeedsUpdateConstraints];
    [self updateFocusIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat rowHeight = 0.0;
    
    for (UIView *bottomView in self.contentView.subviews) {
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    
    rowHeight += self.sp_bottomOffsetToCell;
    
    return rowHeight;
}

@end

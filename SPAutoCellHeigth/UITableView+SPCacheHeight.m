//
//  UITableView+SPCacheHeight.m
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import "UITableView+SPCacheHeight.h"
#import <objc/runtime.h>

static const void *__sp_tableview_cacheCellHeightKey = "__sp_tableview_cacheCellHeightKey";
static const void *__sp_tableview_reuse_cells_key = "__sp_tableview_reuse_cells_key";

@implementation UITableView (SPCacheHeight)

- (NSMutableDictionary *)sp_cacheCellHeightDic {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, __sp_tableview_cacheCellHeightKey);
    if (dict == nil) {
        dict = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 __sp_tableview_cacheCellHeightKey,
                                 dict,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dict;
}

-(NSMutableDictionary *)sp_reuseCells {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, __sp_tableview_reuse_cells_key);
    
    if (cells == nil) {
        
        objc_setAssociatedObject(self,
                                 __sp_tableview_reuse_cells_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    return cells;
}

@end

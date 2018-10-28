//
//  SPNewsCell.h
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPNewsModel;

typedef void(^SPExpandBlock)(BOOL isExpand);

@interface SPNewsCell : UITableViewCell

@property (nonatomic, copy) SPExpandBlock expandBlock;

- (void)configCellWithModel:(SPNewsModel *)model;

@end


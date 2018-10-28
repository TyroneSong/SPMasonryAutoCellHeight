//
//  SPNewsModel.h
//  SPMasonryAutoCellHeight
//
//  Created by 石头 on 2018/10/28.
//  Copyright © 2018 宋璞. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SPNewsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;

@end


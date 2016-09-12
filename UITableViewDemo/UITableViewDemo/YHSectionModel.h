//
//  YHSectionModel.h
//  UITableViewDemo
//
//  Created by 杨应海 on 16/9/12.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHCellModel;

@interface YHSectionModel : NSObject

/** 组头标题 */
@property (nonatomic, copy) NSString *sectionTitle;
/** 改组的内容是否展开 */
@property (nonatomic, assign) BOOL isExpanded;
/** 每组的cell数组数据 */
@property (nonatomic, strong) NSArray <YHCellModel *> *cellModels;

@end

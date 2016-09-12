//
//  YHTableViewHeaderView.h
//  UITableViewDemo
//
//  Created by 杨应海 on 16/9/12.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSectionModel;

@interface YHTableViewHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) YHSectionModel *model;

@property (nonatomic, copy) void (^YHTableViewHeaderViewExpandCallBack)();

@end

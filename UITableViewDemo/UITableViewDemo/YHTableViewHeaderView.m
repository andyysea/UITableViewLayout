//
//  YHTableViewHeaderView.m
//  UITableViewDemo
//
//  Created by 杨应海 on 16/9/12.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHTableViewHeaderView.h"
#import "YHSectionModel.h"

@interface YHTableViewHeaderView ()

@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UILabel *titleLabel;

/** 控制避免重复点击 */
@property (nonatomic, assign) BOOL IsOk;

@end

@implementation YHTableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.IsOk = YES;
        
        self.contentView.backgroundColor = [UIColor purpleColor];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_expand"]];
        arrowImageView.frame = CGRectMake(10, (44 - 8) / 2, 15, 8);
        [self.contentView addSubview:arrowImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, width, 44);
        
        /** 
         NSLog(@"%@ \n\n %@",NSStringFromCGRect(self.bounds), NSStringFromCGRect(self.contentView.bounds));
         上面的输出结果是 都是 0 ，所以这里是不能直接使用 self.bounds,或者self.contentView.bounds 的大小来给内部子控件计算 frame
         */
        
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
       
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 200, 44)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
        _arrowImageView = arrowImageView;
        _titleLabel = titleLabel;
    }
    return self;
}

#pragma mark 按钮的监听方法
- (void)onExpand:(UIButton *)button {
    
    if (!self.IsOk) {
        return;
    }
    self.IsOk = NO;
    
    self.model.isExpanded = !self.model.isExpanded;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.model.isExpanded) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        } else {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    } completion:^(BOOL finished) {
        if (self.YHTableViewHeaderViewExpandCallBack) {
            self.YHTableViewHeaderViewExpandCallBack();
        }
        self.IsOk = YES;
    }];
    
}



#pragma mark - 重写模型属性的setter方法
- (void)setModel:(YHSectionModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    if (model.isExpanded) {
        self.arrowImageView.transform = CGAffineTransformIdentity;
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    _titleLabel.text = model.sectionTitle;
}


@end

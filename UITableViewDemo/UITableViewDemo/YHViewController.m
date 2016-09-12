//
//  YHViewController.m
//  UITableViewDemo
//
//  Created by 杨应海 on 16/9/12.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHViewController.h"
#import "YHSectionModel.h"
#import "YHCellModel.h"

static NSString *cellId = @"cellId";
static NSString *headerId = @"headerId";

@interface YHViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation YHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    NSLog(@"%@", self.dataList.description);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YHSectionModel *sectionModel = self.dataList[section];
    return sectionModel.isExpanded ? sectionModel.cellModels.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    YHSectionModel *sectionModel = self.dataList[indexPath.row];
    YHCellModel *cellModel = sectionModel.cellModels[indexPath.row];
    cell.textLabel.text = cellModel.title;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    
    YHSectionModel *secitonModel = self.dataList[section];
#warning 这里需要自定义组头视图;
    
    view.contentView.backgroundColor = [UIColor redColor];
    return view;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


#pragma mark - 设置界面
- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerId];
}


#pragma mark - 懒加载加载数据
- (NSArray *)dataList {
    if (_dataList == nil) {
        
        NSMutableArray *sectionArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            YHSectionModel *sectionModel = [[YHSectionModel alloc] init];
            sectionModel.isExpanded = NO;
            sectionModel.sectionTitle = [NSString stringWithFormat:@"secrtion -> %zd",i];
            
            NSMutableArray *cellArray = [NSMutableArray array];
            for (NSInteger j = 0; j < 6; j++) {
                YHCellModel *cellModel = [[YHCellModel alloc] init];
                cellModel.title = [NSString stringWithFormat:@"第%zd组 - 第%zd行",i, j];
                [cellArray addObject:cellModel];
            }
            sectionModel.cellModels = cellArray;
            [sectionArray addObject:sectionModel];
        }
        
        _dataList = sectionArray.copy;
    }
    return _dataList;
}
@end

//
//  SK_TopNavFilterView.m
//  SK_NavFilterDemo
//
//  Created by TrimbleZhang on 2018/11/15.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

#import "SK_TopNavFilterView.h"
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define Navigation_Height (iPhoneX ? 94 : 70)

/**
 *  主屏幕高减去navigationBar的高度
 */
#define CONTENT_HEIGHT ([UIScreen mainScreen].bounds.size.height - (iPhoneX ? 94 : 70))

@interface SK_TopNavFilterView()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation SK_TopNavFilterView

#pragma mark - 0 LazyLoad

- (void)setFilterArr:(NSArray *)filterArr
{
    _filterArr = filterArr;
    
    self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

    self.tableView.frame = CGRectMake(0, Navigation_Height, self.frame.size.width, CGFLOAT_MIN);
    WeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.tableView.frame = CGRectMake(0, Navigation_Height, self.frame.size.width, 45.0 * filterArr.count);
        weakSelf.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
    
    
    
}

#pragma mark - 1 LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }return self;
}

#pragma mark - 2 Create UI
- (void)createUI
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    
    self.whiteView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, Navigation_Height)];
    self.whiteView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    [self addSubview:self.whiteView];
    
    self.blackView =  [[UIView alloc]initWithFrame:CGRectMake(0, Navigation_Height, self.frame.size.width, CONTENT_HEIGHT)];
    self.blackView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self addSubview:self.blackView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Navigation_Height, self.frame.size.width, 270.0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    UITapGestureRecognizer *tapA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    tapA.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tapB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    tapB.numberOfTapsRequired = 1;
    [_blackView addGestureRecognizer:tapA];
    [_whiteView addGestureRecognizer:tapB];
    
    
}
#pragma mark - 3 LoadData

#pragma mark - 4 Delegate Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDA = @"CellIDA";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDA];
    }
    if (self.filterArr.count > indexPath.row) {
        cell.textLabel.text = self.filterArr[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.selectAction_Block) {
        self.selectAction_Block(indexPath.row);
    }
    
    
}
#pragma mark - 5 Action Response

- (void)backAction {
    
    _blackView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _tableView.frame = CGRectMake(0, Navigation_Height, self.frame.size.width, 45.0  * _filterArr.count );
    WeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        weakSelf.tableView.frame = CGRectMake(0, Navigation_Height, self.frame.size.width, CGFLOAT_MIN);
    } completion:^(BOOL finished) {
        if (weakSelf.backAction_Block) {
            weakSelf.backAction_Block();
        }
    }];
}
#pragma mark - 6 Extract Method


@end

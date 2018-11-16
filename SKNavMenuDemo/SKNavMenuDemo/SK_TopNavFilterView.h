//
//  SK_TopNavFilterView.h
//  SK_NavFilterDemo
//
//  Created by TrimbleZhang on 2018/11/15.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SK_TopNavFilterView : UIView

@property (nonatomic, retain) UIView *whiteView;
@property (nonatomic, retain) UIView *blackView;
@property (nonatomic, retain) UITableView *tableView;

/**
 筛选数组
 */
@property (nonatomic, retain) NSArray *filterArr;
/**
 返回
 */
@property (nonatomic, copy) void (^backAction_Block)(void);
/**
 选择结果回调
 */
@property (nonatomic, copy) void (^selectAction_Block)(NSInteger);


@end

NS_ASSUME_NONNULL_END

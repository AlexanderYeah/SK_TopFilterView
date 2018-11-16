//
//  ViewController.m
//  SKNavMenuDemo
//
//  Created by TrimbleZhang on 2018/11/16.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"
#import "SK_TopNavFilterView.h"
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface ViewController ()

@property (nonatomic, retain) SK_TopNavFilterView *filterView;//订单类型筛选
@property (nonatomic, retain)UILabel *titleLbl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 首先定义一个Button
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    // 添加 按钮名字
    [button setTitle:@"筛选" forState:(UIControlStateNormal)];
    // 添加点击方法
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:22.f];
    [button addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    // 自适应大小
    [button sizeToFit];
    
    self.navigationItem.titleView = button;
    // 添加到 表头 title
    
    
    
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.font = [UIFont boldSystemFontOfSize:22.f];
    self.titleLbl = titleLbl;
    titleLbl.textAlignment = 1;
    titleLbl.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    titleLbl.text = @"选择结果";
    titleLbl.frame = CGRectMake(10, 300, 200, 50);
    titleLbl.userInteractionEnabled = YES;
    [self.view addSubview:titleLbl];
    
    
}


- (void)actionButton:(UIButton *)btn
{
    NSLog(@"我是表头, 点击我");
    btn.selected = !btn.selected;
    if (!_filterView) {
        self.filterView = [[SK_TopNavFilterView alloc] initWithFrame:self.view.bounds];
    }
    
    if (btn.selected) {
        
        NSMutableArray *titleArr = [@[@"商品订单",@"退货订单", @"试用商品"] mutableCopy];
        self.filterView.filterArr  = titleArr;
        WeakSelf(weakSelf)
        [self.filterView setBackAction_Block:^{
            [weakSelf.filterView removeFromSuperview];
        }];
        [self.filterView setSelectAction_Block:^(NSInteger idx) {
            weakSelf.titleLbl.text = titleArr[idx];
            [weakSelf.filterView removeFromSuperview];
        }];
        [self.view addSubview: self.filterView];
        
        
    }else{
        
        [self.filterView removeFromSuperview];
        
    }
    
    
    
    
}


@end

//
//  CTTwoVC.m
//  wct_tabbar
//
//  Created by Wcting on 2019/4/24.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "CTTwoVC.h"

@interface CTTwoVC ()

@property (nonatomic, strong)UIButton *backBtn;/**<wct20190424 backBtn*/


@end

@implementation CTTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.backBtn setFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.backBtn];

}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - get
-(UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor = [UIColor cyanColor];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _backBtn;
}

@end

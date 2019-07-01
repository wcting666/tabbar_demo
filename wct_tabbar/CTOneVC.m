//
//  CTOneVC.m
//  wct_tabbar
//
//  Created by Wcting on 2019/4/24.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "CTOneVC.h"
#import "CTTabbarController.h"

@interface CTOneVC ()
@property (nonatomic, strong)UIButton *backBtn;/**<wct20190424 backBtn*/

@end

@implementation CTOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self.backBtn setFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.backBtn];
    
    
    // Do any additional setup after loading the view.
}

- (void)backAction
{
    CTTabbarController *tabbar = [CTTabbarController sharaTabbarController];
    tabbar.selectedButtonIndex = 1;
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - get
-(UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor = [UIColor blueColor];
        [_backBtn setTitle:@"跳转2" forState:UIControlStateNormal];
    }
    return _backBtn;
}


@end

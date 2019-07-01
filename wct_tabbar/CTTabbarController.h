//
//  CTTabbarController.h
//  wct_tabbar
//
//  Created by Wcting on 2019/4/24.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTTabbarController : UITabBarController

@property (nonatomic) NSUInteger selectedButtonIndex;

+(CTTabbarController *)sharaTabbarController;

//销毁对象
- (void)attemptDealloc;

//清所有的空栈
- (void)cleanAllNavigationController;

//根据指定的索引清空栈
- (void)cleanNavigationControllerWithIndex:(NSInteger)index;

//清除不是该索引的栈
- (void)cleanAllNavigationControllerIsNotIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END

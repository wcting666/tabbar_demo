//
//  CTTabbarController.m
//  wct_tabbar
//
//  Created by Wcting on 2019/4/24.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "CTTabbarController.h"
#import "ViewController.h"
#import "CTOneVC.h"
#import "CTTwoVC.h"

@interface CTTabbarController ()

@property (nonatomic, strong)UIView *viewTabbar;/**<wct20190425 自定义tabber*/
@property (nonatomic, strong)NSArray *arrTabImage;/**<wct20190424 tab图片数组*/
@property (nonatomic, strong)CTOneVC *vc1;/**<wct20180227 vc*/
@property (nonatomic, strong)ViewController *vc2;/**<wct20180227 vc*/
@property (nonatomic, strong)ViewController *vc3;/**<wct20180227 vc*/
@property (nonatomic, strong)ViewController *vc4;/**<wct20180227 vc*/
@property (nonatomic, strong)CTTwoVC *v5;/**<wct20180314 v5*/
@property (nonatomic, strong)ViewController *vodVC;/**<wct20180314 vodVc*/
@property (nonatomic, strong) UIButton *buttonCurrent; //保存当前选中的按钮
@property (nonatomic, assign)NSInteger selectIndex;/**<wct20180314  记录点击哪个按钮*/
@end

static CTTabbarController *tabbarController = nil;

@implementation CTTabbarController

+(CTTabbarController *)sharaTabbarController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarController = [[CTTabbarController alloc] init];
    });
    return tabbarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self currentController];
    [self layoutContainer];
    // Do any additional setup after loading the view.
}

#pragma mark - public
- (void)attemptDealloc
{
    //解决没有remove掉通知 kvo
    tabbarController = nil;
    
}

//清空栈
- (void)cleanAllNavigationController
{
    for (UINavigationController *nav in [self viewControllers]) {
        [nav popToRootViewControllerAnimated:NO];
    }
}

//根据指定的索引清空栈
- (void)cleanNavigationControllerWithIndex:(NSInteger)index
{
    if (index < [[self viewControllers] count]) {
        
        UINavigationController *nav = [[self viewControllers] objectAtIndex:index];
        [nav popToRootViewControllerAnimated:NO];
        
    }
}

//清除不是该索引的栈
- (void)cleanAllNavigationControllerIsNotIndex:(NSInteger)index
{
    NSInteger i = 0;
    for (UINavigationController *nav in [self viewControllers]) {
        
        //如果当前的索引根据用户传过来的索引一样，则不清除该栈。
        if (index == i++) {
            continue;
        }
        
        [nav popToRootViewControllerAnimated:NO];
    }
}


#pragma mark - click btn
- (void)setSelectedButtonIndex:(NSUInteger)selectedButtonIndex
{
    if (_selectedButtonIndex != selectedButtonIndex) {
        
        _selectedButtonIndex = selectedButtonIndex;
        
        UIButton *button  = (UIButton*)[self objWithTag:_selectedButtonIndex+1];
        [self tabBarClickEventOnButton:button];
        
    }
}

- (void)tabBarClickEventOnButton:(UIButton *)button
{

    switch ([button tag]) {
        case 3:
        {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CTTwoVC alloc] init]];
                                           
            [self presentViewController:nav animated:YES completion:nil];

        }
            break;
            
        default:
            
            [self jumpPage:button];
            
            break;
    }
    
}

- (void)jumpPage:(UIButton *)button
{
    //1.先将之前选中的按钮设置为未选中
    [[self buttonCurrent] setSelected:NO];
    //2.再将当前按钮设置为选中
    [button setSelected:YES];
    //3.最后把当前按钮赋值为之前选中的按钮
    [self setButtonCurrent:button];
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    [self setSelectedIndex:[button tag]-1];
    //及时修改EMTabBarController索引位置
    _selectedButtonIndex = button.tag-1;
}

#pragma mark - private methods
//添加各个
- (void)currentController
{
    //首页
    self.vc1 = [[CTOneVC alloc] init];
    self.vc1.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:self.vc1];
    
    //工单页
    self.vc2 = [[ViewController alloc] init];
    self.vc2.view.backgroundColor = [UIColor blueColor];
    UINavigationController *orderVCNav = [[UINavigationController alloc] initWithRootViewController:self.vc2];
    
    //发布
    self.v5 = [[CTTwoVC alloc] init];
    UINavigationController *publishNav = [[UINavigationController alloc] initWithRootViewController:self.v5];
    
    //设备页
    self.vc3 = [[ViewController alloc] init];
    UINavigationController *deviceNav = [[UINavigationController alloc] initWithRootViewController:self.vc3];
    
    //我的页面
    self.vc4 = [[ViewController alloc]init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:self.vc4];
    
    NSArray *arrayVC = @[homeNav,orderVCNav,publishNav,deviceNav,meNav];
    [self setViewControllers:arrayVC];
}


- (void)layoutContainer
{

    [self.viewTabbar setFrame:self.tabBar.bounds];
    [self.tabBar addSubview:self.viewTabbar];
    [self layoutTabbar];
    
}

- (void)layoutTabbar
{
    for (int i = 0; i < self.arrTabImage.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat itemW = self.viewTabbar.bounds.size.width / 5;
        [button setFrame:CGRectMake(i * itemW, 0, itemW, 49)];
        NSDictionary *dic = self.arrTabImage[i];
        [button setImage:[UIImage imageNamed:[dic objectForKey:@"n"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[dic objectForKey:@"s"]] forState:UIControlStateSelected];
        button.tag = i + 1;
        [button addTarget:self action:@selector(tabBarClickEventOnButton:) forControlEvents:UIControlEventTouchUpInside];

        [self.viewTabbar addSubview:button];

        
        switch (i) {
                
            case 0:
            {
                [button setSelected:YES];
                [self setButtonCurrent:button];
                
            }
                break;
                
            default:
                
                break;
        }
        
    }

}
//遍历viewTabBar的子控件
- (UIView*)objWithTag:(NSInteger)tag
{
    UIView *view;
    for ( UIView *currentView in [[self viewTabbar] subviews]) {
        
        if ([currentView tag] == tag) {
            
            view = currentView;
            break;
        }
        
    }
    
    return view;
}

#pragma mark - get
-(UIView *)viewTabbar
{
    if (_viewTabbar == nil) {
        _viewTabbar = [[UIView alloc] init];
        
    }
    return _viewTabbar;
}

-(NSArray *)arrTabImage
{
    if (_arrTabImage == nil) {
        _arrTabImage = [NSArray arrayWithObjects:
                        @{@"n":@"nav_shouye",@"s":@"nav_shouye_xz"},
                        @{@"n":@"nav_gz",@"s":@"nav_gz_xz"},
                        @{@"n":@"video_add",@"s":@"video_add"},
                        @{@"n":@"nav_xx",@"s":@"nav_xx_xz"},
                        @{@"n":@"nav_W",@"s":@"nav_W_xz"},
                        nil];
    }
    return _arrTabImage;
}

@end

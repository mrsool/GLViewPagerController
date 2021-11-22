//
//  MRPageController.m
//  MRSOOL
//
//  Created by SOTSYS202 on 07/09/18.
//  Copyright © 2018 SOTSYS155. All rights reserved.
//

#import "MRPageController.h"
//#import "MRSOOL-Swift.h"


@interface MRPageController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate>

@end

@implementation MRPageController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    /// 设置数据源
    self.dataSource = self;
    /// 设置数据委托
    self.delegate = self;
    /// 是否固定标签宽度
    self.fixTabWidth = false;
    /// Tab之间边距
    self.padding = 0;
    /// 是否填充tabs满屏幕
    self.fullfillTabs = false;
    /// 固定指示器宽度
    self.fixIndicatorWidth = false;
    /// 指示器宽度
    self.indicatorWidth = 20;
    /// 指示器颜色
    self.indicatorColor = [UIColor whiteColor];
    /// 头边距
    self.leadingPadding = 0;
    /// 尾边距
    self.trailingPadding = 0;
    /// 默认显示页
    ///self.defaultDisplayPageIndex = 0;
    /// Tab动画
    
    self.tabAnimationType = GLTabAnimationType_none;

    
    
    
    /// 是否支持阿拉伯，如果是阿拉伯则反转
//    self.supportArabic = YES;
    
    
//    /** 设置内容视图 */
//    self.viewControllers = @[
//                             [[GLPresentViewController alloc]initWithTitle:@"Page One"],
//                             [[GLPresentViewController alloc]initWithTitle:@"Page Two"],
//                             ];
//    /** 设置标签标题 */
//    self.tagTitles = @[
//                       @"Page One",
//                       @"Page Two",
//                       ];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabAnimationType = GLTabAnimationType_whileScrolling;
}

-(void)reloadTabs
{
    if (self.viewControllers.count == 1)
    {
        self.isScrollDisable = false;
        self.isWalkThrough = true;
        self.tabHeight = 0;
        [self.view layoutIfNeeded];
        [self reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GLViewPagerViewControllerDataSource
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
    return self.viewControllers.count;
}



- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [self.tagTitles objectAtIndex:index];
    label.font = [UIFont systemFontOfSize:14.0];  //[UIFont systemFontOfSize:16.0];
    /** 默认紫色 */
    label.textColor = self.tabTextColorDefault;
    label.alpha = 0.70;
    label.textAlignment = NSTextAlignmentCenter;
#if 0
    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
#endif
    
    NSLog(@"Badge Value ... %@",self.badgeValue);
    
//    if (index == 1 && _badgeValue > 0) {
//        MIBadgeButton *btn1 = [[MIBadgeButton alloc]init];
//        btn1.badgeString = self.badgeValue;
//        btn1.frame = CGRectMake((self.supportArabic) ? 20 : AppDel.window.frame.size.width/2 - 20, 20 ,20, 20);
//        [label addSubview:btn1];
//    }
    
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
    self.defaultDisplayPageIndex = index;
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
#if 0
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
#endif
    /* 紫色默认颜色 */
    prevLabel.textColor = self.tabTextColorDefault;//[UIColor whiteColor];
    prevLabel.alpha = 0.70;
    /* 灰色高亮颜色 */
    currentLabel.textColor =  self.tabTextColorSelected;// [UIColor whiteColor];
    currentLabel.alpha = 1;
    
    if ([self.pageDelegate respondsToSelector:@selector(pageControllerChangedToIndex:)]) {
        [self.pageDelegate pageControllerChangedToIndex:(int)index];
    }
}

- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
    
    if (fromTabIndex == index) {
        return;
    }
    
    #if 0
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                 1.0 - (0.1 * progress),
                                                 1.0 - (0.1 * progress));
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                    0.9 + (0.1 * progress),
                                                    0.9 + (0.1 * progress));
    
    #endif
    
}


- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.text = [self.tagTitles objectAtIndex:index];
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:14.0];//[UIFont fontWithName:@"Dubai-Medium" size:14.0];
#if 0
    prototypeLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
#endif
    
    NSLog(@"%f",prototypeLabel.intrinsicContentSize.width + (self.fullfillTabs == YES ?  [self tabsFulFillToScreenWidthInset] : 0));
//    return AppDel.window.frame.size.width/self.viewControllers.count;
    return [[UIScreen mainScreen] bounds].size.width / self.viewControllers.count;
}

#pragma mark - funcs

- (CGFloat)tabsFulFillToScreenWidthInset {
    if ([self isTabsWidthGreaterThanScreenWidth]) {
        return 0.0;
    }
    
    return [self screenleftWidthForTabs] / self.tagTitles.count;
}

- (CGFloat)estimateTabsWidthInView {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:14.0];
    
    CGFloat estimateTabsWidth = 0.0;
    estimateTabsWidth += self.leadingPadding;
    
    for (NSUInteger i = 0; i < self.tagTitles.count; i++) {
        prototypeLabel.text = [self.tagTitles objectAtIndex:i];
        estimateTabsWidth += prototypeLabel.intrinsicContentSize.width;
        if (i == self.tagTitles.count - 1) {
            estimateTabsWidth += 0;
        }
        else {
            estimateTabsWidth += self.padding;
        }
    }
    estimateTabsWidth+=self.trailingPadding;
    return estimateTabsWidth;
}

- (CGFloat)screenleftWidthForTabs {
    CGFloat tabsWidth = [self estimateTabsWidthInView];
    return self.view.bounds.size.width - tabsWidth;
}

- (BOOL)isTabsWidthGreaterThanScreenWidth {
    return [self screenleftWidthForTabs] < 0 ? true : false;
}
@end

//
//  MRPageController.h
//  MRSOOL
//
//  Created by SOTSYS202 on 07/09/18.
//  Copyright © 2018 SOTSYS155. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLViewPagerViewController.h"

@protocol MRPageControllerDelegate <NSObject>
- (void)pageControllerChangedToIndex:(int)index;
@end
@interface MRPageController : GLViewPagerViewController
@property (nonatomic,strong)NSArray *viewControllers;
@property (nonatomic,strong)NSArray *tagTitles;
@property (nonatomic,assign)BOOL fullfillTabs;
@property (nonatomic,assign)BOOL isSupportArabic;
@property (nonatomic,assign)NSString *badgeValue;
@property(nonatomic, weak)id <MRPageControllerDelegate> pageDelegate;

-(void)reloadTabs;

@end

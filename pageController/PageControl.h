//
//  PageControl.h
//  FriendsGo
//
//  Created by 海军 高 on 11-11-15.
//  Copyright (c) 2011年 北京微云即趣. All rights reserved.
//

//scrollerView下面的点点点
#import <UIKit/UIKit.h>

@protocol PageControlDelegate;

@interface PageControl : UIView 
{
@private
    NSInteger _currentPage;
    NSInteger _numberOfPages;
    UIColor *dotColorCurrentPage;
    UIColor *dotColorOtherPage;
    NSObject<PageControlDelegate> *delegate;
}


/**
 currentPage:设置当前的page
 numberOfPages:设置总的pages
 */
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger numberOfPages;

/**
 dotColorCurrentPage:设置当前点的颜色
 dotColorOtherPage:设置其他点的颜色
 */
@property (nonatomic, retain) UIColor *dotColorCurrentPage;
@property (nonatomic, retain) UIColor *dotColorOtherPage;

/**
 delegate:代理，可选的。
 当user设置的时候，点击小点的时候，会产生回调
 */
@property (nonatomic, strong) NSObject<PageControlDelegate> *delegate;

@end

@protocol PageControlDelegate<NSObject>
@optional
- (void)pageControlPageDidChange:(PageControl *)pageControl;
@end
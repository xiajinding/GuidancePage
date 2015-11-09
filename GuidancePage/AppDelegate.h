//
//  AppDelegate.h
//  GuidancePage
//
//  Created by Lemon on 15/11/7.
//  Copyright © 2015年 LemonXia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIScrollView *myScrollView;
    PageControl *pageControl;
}
@property (strong, nonatomic) UIWindow *window;


@end


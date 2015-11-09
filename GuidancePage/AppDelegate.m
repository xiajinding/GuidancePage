//
//  AppDelegate.m
//  GuidancePage
//
//  Created by Lemon on 15/11/7.
//  Copyright © 2015年 LemonXia. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#define screenWidth self.window.frame.size.width
#define screenHeight self.window.frame.size.height

@interface AppDelegate ()<UIScrollViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *viewController = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // 引导页在程序中只会显示一次
     NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
     int a=[[userDefaults objectForKey:@"isShow"] intValue];
     if (a!=10) {
     [userDefaults setObject:@"10" forKey:@"isShow"];
     
     [self showGuidancePage];
     
     [userDefaults synchronize];
     }
    
//    [self showGuidancePage];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showGuidancePage {
    myScrollView = [[UIScrollView alloc]init];
    myScrollView.pagingEnabled = YES;// 整页滑动
    myScrollView.bounces = NO;//超出范围不能滑动
    
    /**
     *  //不设置 delegate - (void)scrollViewDidScroll:(UIScrollView *)scrollView 不执行
     */
    myScrollView.delegate = self;
    myScrollView.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    myScrollView.contentSize = CGSizeMake(self.window.frame.size.width*4, self.window.frame.size.height);
    
    [self.window addSubview:myScrollView];
    
    for (int i = 0; i < 4; i ++) {
        [myScrollView addSubview:[self addSubviewImage:[NSString stringWithFormat:@"5help%d",i+1] rect:CGRectMake(self.window.frame.size.width *i, 0, self.window.frame.size.width, self.window.frame.size.height)]];
    }
    
    [self showButton];
    
    pageControl = [[PageControl alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
    pageControl.dotColorCurrentPage = [UIColor redColor];
    pageControl.center = CGPointMake(screenWidth/2, screenHeight -20);
    pageControl.numberOfPages  = 4;
    [self.window addSubview:pageControl];
    
}

- (UIImageView *)addSubviewImage:(NSString *)imageName rect:(CGRect )rect {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = rect;
    return imageView;
}

- (void)showButton {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.window.frame.size.width*3+105,self.window.frame.size.height-70, screenWidth -100*2,67/2);
    [button setBackgroundImage:[UIImage imageNamed:@"helpBtn.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hiddenScroller:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [myScrollView addSubview:button];
}


-(void)hiddenScroller:(id)sender
{
    
    
    
    [UIView animateWithDuration:2.0
                     animations:^{
                         myScrollView.hidden = YES;
                         pageControl.hidden = YES;

                     }
                     completion:^(BOOL finished){
  
                     }
     ];
}

#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    NSLog(@"%@---%@",NSStringFromCGPoint(offset),NSStringFromCGRect(bounds));
    [pageControl setCurrentPage:offset.x /bounds.size.width];
    
}
@end

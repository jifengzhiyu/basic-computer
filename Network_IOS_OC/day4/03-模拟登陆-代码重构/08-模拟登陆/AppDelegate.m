//
//  AppDelegate.m
//  08-模拟登陆
//
//  Created by Apple on 15/10/22.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "AppDelegate.h"
#import "HMNetworkTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

//xode7中didFinishLaunchingWithOptions结束之前，必须设置rootViewController，否则程序会崩溃
//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化window对象
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    //
    [[HMNetworkTool sharedNetworkTool] loginWithSuccess:^{
        [self loadViewControllerWithSBName:@"Main" ID:nil];
        //从sb中加载控制器
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *vc = [sb instantiateInitialViewController];
//        
//        self.window.rootViewController = vc;
        
        
    } error:^{
        [self loadViewControllerWithSBName:@"Login" ID:nil];

        //从sb中加载控制器
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        UIViewController *vc = [sb instantiateInitialViewController];
//        
//        self.window.rootViewController = vc;
    }];
    
    
    //设置rootViewController
    //设置过渡界面
    [self loadViewControllerWithSBName:@"Login" ID:@"guodu"];

    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"guodu"];
//    
//    self.window.rootViewController = vc;
    return YES;
}
//加载sb中的控制器
- (void)loadViewControllerWithSBName:(NSString *)sbName ID:(NSString *)ID {
    //从sb中加载控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = nil;
    if (ID == nil) {
        //加载箭头指向的控制器
       vc = [sb instantiateInitialViewController];

    }else {
        vc = [sb instantiateViewControllerWithIdentifier:ID];
    }
    
    self.window.rootViewController = vc;
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

@end

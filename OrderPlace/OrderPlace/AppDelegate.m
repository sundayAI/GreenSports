//
//  AppDelegate.m
//  OrderPlace
//
//  Created by Daisy on 16/3/30.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"
#import "PlaceViewController.h"
#import "MyInfoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    //消息推送注册
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
    }
    
    LoadingViewController *iView = [[LoadingViewController alloc] init];
    self.window.rootViewController = iView;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    //获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
    
    NSString *b = [token substringFromIndex:1];
    NSString *a = [b substringToIndex:(b.length - 1)];
    NSString *cleanString = [a stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString* devices_token = [NSString stringWithFormat:@"%@",cleanString];
    
    DLog(@"My token is:%@", devices_token);
    
    [[NSUserDefaults standardUserDefaults] setObject:devices_token forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    DLog(@"Failed to get token, error:%@", [NSString stringWithFormat: @"%@", error]);
    
    NSString *devices_token = @"";
    
    [[NSUserDefaults standardUserDefaults] setObject:devices_token forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

+(void) initTurnView:(int)intFirstLaunch
{
    [[UISearchBar appearance] setBackgroundImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIImage *backArrowImage = [[UIImage imageNamed:@"leftBarButtonItemReturn"] imageWithAlignmentRectInsets:insets];
    
    [[UINavigationBar appearance] setBackIndicatorImage:backArrowImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backArrowImage];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    AppDelegate *nowdelegate=[UIApplication sharedApplication].delegate;
    
    switch (intFirstLaunch)
    {
        case 1: //
        {
            // Override point for customization after application launch.
             [nowdelegate initPhone];
            
            break;
        }
    }
}

- (void)initPhone
{
    AppDelegate *nowdelegate=[UIApplication sharedApplication].delegate;
    UIColor *textSelectedColor = RED_COLOR;
    UIColor *textUnselectColor = [UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0];
    //---ios8后需加如下代码，否则初始图片蓝色---
    UIImage *selectedImage1 =[UIImage imageNamed:@"page0_off"];
    selectedImage1 = [selectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //-----end-----
    
    PlaceViewController *mainView = [[PlaceViewController alloc]init];
    nowdelegate.navigationController1 = [[UINavigationController alloc] initWithRootViewController:mainView];
    
    UITabBarItem *firstItem = [[UITabBarItem alloc]initWithTitle:nil image:nil tag:1];
    firstItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);//设置图片下沉居中
    
    [firstItem setImage:[[UIImage imageNamed:@"page0_off"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    [firstItem setSelectedImage:[selectedImage1 imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [firstItem setTitle:@"场地"];
    [firstItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textSelectedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [firstItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textUnselectColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    mainView.tabBarItem = firstItem;
    
    
    
    MyInfoViewController *myInfoView = [[MyInfoViewController alloc]init];
    nowdelegate.navigationController2 = [[UINavigationController alloc] initWithRootViewController:myInfoView];
    
    //---ios8后需加如下代码，否则初始图片蓝色---
    
    //-----end-----
    
    UITabBarItem *fifthItem = [[UITabBarItem alloc]initWithTitle:nil image:nil tag:5];
    fifthItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [fifthItem setImage:[[UIImage imageNamed:@"page4_off"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    [fifthItem setSelectedImage:[[UIImage imageNamed:@"page4_off"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [fifthItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textSelectedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [fifthItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textUnselectColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [fifthItem setTitle:@"我的"];
    myInfoView.tabBarItem = fifthItem;
    
    nowdelegate.rootController = [[UITabBarController alloc]init];
    //            [nowdelegate.rootController.tabBar setBackgroundImage: [UIImage imageNamed:@"image_tab_bg"]];
    nowdelegate.rootController.tabBar.translucent = NO;
    nowdelegate.rootController.tabBar.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    nowdelegate.rootController.viewControllers = [NSArray arrayWithObjects:nowdelegate.navigationController1,nowdelegate.navigationController2,  nil];
    
    
    nowdelegate.window.rootViewController = nowdelegate.rootController;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginStatus"];  //设置非第一次登录
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//处理收到的消息推送
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
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

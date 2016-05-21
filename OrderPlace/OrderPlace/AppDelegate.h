//
//  AppDelegate.h
//  OrderPlace
//
//  Created by Daisy on 16/3/30.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *rootController;
@property (strong, nonatomic) UINavigationController *navigationController1;
@property (strong, nonatomic) UINavigationController *navigationController2;

+ (void) initTurnView:(int)intFirstLaunch;


@end


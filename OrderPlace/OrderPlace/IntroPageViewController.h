//
//  IntroPageViewController.h
//  OrderPlace
//
//  Created by Daisy on 16/3/30.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCIntroView.h"

@interface IntroPageViewController : UIViewController<ABCIntroViewDelegate>

@property (strong, nonatomic) ABCIntroView * introView;

@end

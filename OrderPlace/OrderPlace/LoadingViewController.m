//
//  LoadingViewController.m
//  OrderPlace
//
//  Created by Daisy on 16/3/30.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()
{
    UIImageView *bg;
}

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (ISIPHONE4S) // iPhone4
    {
        bg.image = [UIImage imageNamed:@"loading_4s"];
    }
    else
    {
        bg.image = [UIImage imageNamed:@"loading_5+"];
    }
    [self.view addSubview:bg];
    
   [AppDelegate initTurnView:1];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  MyInfoViewController.h
//  OrderPlace
//
//  Created by Daisy on 16/3/30.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end

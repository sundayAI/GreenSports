//
//  OrderViewController.h
//  OrderPlace
//
//  Created by Daisy on 16/5/19.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

-(void)initOrderInfo:(NSMutableDictionary *)dic ;

@end

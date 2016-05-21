//
//  PlaceCell.h
//  OrderPlace
//
//  Created by Daisy on 16/4/1.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imagePlace;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *posLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *disLab;
@property (strong, nonatomic) IBOutlet UIButton *orderBtn;

@end

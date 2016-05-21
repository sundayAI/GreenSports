//
//  NewPassWardViewController.h
//  OrderPlace
//
//  Created by Daisy on 16/4/1.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  login;
@interface NewPassWardViewController : UIViewController
@property(nonatomic,strong)NSMutableDictionary* dict;
@property(nonatomic,copy) login *logininfo;

//从a传值到b  属性必须定义在.h文件中
@property(nonatomic,strong)NSString *userPhone;
@end

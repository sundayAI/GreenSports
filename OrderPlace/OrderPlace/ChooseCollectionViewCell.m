//
//  ChooseCollectionViewCell.m
//  InterestedActivity
//
//  Created by 张雪原 on 16/4/11.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "ChooseCollectionViewCell.h"
#define THE_WIDTH_OF_SCREEN [UIScreen mainScreen].bounds.size.width
#define THE_HEIGHT_OF_SCREEN [UIScreen mainScreen].bounds.size.height
#define ISIPHONE4S                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIPHONE5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//是否是iPad
#define isPad                      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define ISIPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)

#define ISIPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
@interface ChooseCollectionViewCell ()

@property (nonatomic, retain) UILabel *label;

@end

@implementation ChooseCollectionViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
    }
    return self;
}
-(void)setPrice:(NSString *)price{
    if (_price != price) {
        _price = price;
    }
    _label.text = _price;
    _label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.frame = CGRectMake(1, 0, 47.5, THE_HEIGHT_OF_SCREEN/25-1);
}

-(void)setStatue:(NSString *)statue{
    if (_statue != statue) {
        _statue = statue;
    }
    if ([_statue isEqualToString:@"0"]) {
        _label.backgroundColor = [UIColor greenColor];
    }else if([_statue isEqualToString:@"1"]){
        _label.backgroundColor = [UIColor blueColor];
    }else{
        _label.backgroundColor = [UIColor clearColor];
    }
}

@end

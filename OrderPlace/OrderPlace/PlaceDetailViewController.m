//
//  PlaceDetailViewController.m
//  OrderPlace
//
//  Created by Daisy on 16/4/23.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "RatingView.h"
#import "LiuXSegmentView.h"
#import "ChooseViewController.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"

#define PICVIEW_HEIGHT 100
#define PIC_WIDTH 130

#define CHOOSEVIEW_HEIGHT 150
#define SEGMENTVIEW_HEIGHT 40
#define DATEVIEW_HEIGHT 100
#define DATEVIEW_WIDTH 80

#define VIEW_WIDTH [[UIScreen mainScreen] bounds].size.width


@interface PlaceDetailViewController ()
{
    NSMutableArray *weekdayArr;
    NSMutableArray *dateStrArr;
}

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"场馆详情";
    self.myScrollView.contentSize =  CGSizeMake(VIEW_WIDTH, 0);
    self.myScrollView.scrollEnabled = YES;
    [self buildWeekDayString];
    [self initPicView];
    [self initChooseView];
}

-(void)initPicView {
    UIView * picView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, PICVIEW_HEIGHT)];
    
    //图片
    UIImageView * picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, PIC_WIDTH, PICVIEW_HEIGHT - 20)];
    [picImageView setImage:[UIImage imageNamed:@"image0"]];
    picImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [picImageView addGestureRecognizer:singleTap];
    picImageView.layer.masksToBounds=YES;
//    picImageView.layer.cornerRadius=188/2.0f; //设置为图片宽度的一半出来为圆形
    picImageView.layer.borderWidth=3.0f; //边框宽度
    picImageView.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
    [picView addSubview:picImageView];
    
    //名字
    UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(picImageView.frame.origin.x + PIC_WIDTH + 20 , 10, VIEW_WIDTH - 100 - 50, 50)];
    nameLab.text = @"羽毛球馆";
    nameLab.font = [UIFont systemFontOfSize:15];//采用系统默认文字设置大小
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.textColor = [UIColor blackColor];
    nameLab.adjustsFontSizeToFitWidth =YES;
    [picView addSubview:nameLab];
    
    //评分
    RatingView *starView = [[RatingView alloc]initWithFrame:CGRectMake(picImageView.frame.origin.x + PIC_WIDTH + 20, 10 + 50, 100, 50)];
    [starView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:nil];
    [starView displayRating:4.5];
    [picView addSubview:starView];
    
    UILabel * lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0 , PICVIEW_HEIGHT-1, VIEW_WIDTH, 1)];
    [lineLab setBackgroundColor:[UIColor grayColor]];
    [picView addSubview:lineLab];
    
    
    [self.myScrollView addSubview:picView];
}

-(void)initChooseView {
    UIView * chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, PICVIEW_HEIGHT, VIEW_WIDTH, CHOOSEVIEW_HEIGHT)];
    
    //项目
    LiuXSegmentView *segmentView=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, SEGMENTVIEW_HEIGHT) titles:@[@"羽毛球",@"篮球"] clickBlick:^void(NSInteger index) {
        
        NSLog(@"-----%ld",index);
        
    }];
    segmentView.titleFont=[UIFont systemFontOfSize:13];
    segmentView.defaultIndex=0;
    segmentView.titleNomalColor=[UIColor blackColor];
    segmentView.titleSelectColor=[UIColor blueColor];
    [chooseView addSubview:segmentView];
    
    //预定
    UIScrollView * dateScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SEGMENTVIEW_HEIGHT, VIEW_WIDTH, CHOOSEVIEW_HEIGHT - SEGMENTVIEW_HEIGHT)];
    dateScrollView.contentSize =  CGSizeMake(DATEVIEW_WIDTH*7 + 10*8, CHOOSEVIEW_HEIGHT - SEGMENTVIEW_HEIGHT);
    dateScrollView.scrollEnabled = YES;
    
    for (int i = 0; i < 7; i++) {
        UIView * dateView = [[UIView alloc]initWithFrame:CGRectMake(10 + i * (DATEVIEW_WIDTH + 10), 5, DATEVIEW_WIDTH, DATEVIEW_HEIGHT)];
        [dateView setBackgroundColor:[UIColor whiteColor]];
        
        //星期几
        UILabel * weekLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DATEVIEW_WIDTH, DATEVIEW_HEIGHT/3)];
        weekLab.text = weekdayArr[i];
        weekLab.font = [UIFont systemFontOfSize:15];//采用系统默认文字设置大小
        weekLab.textAlignment = NSTextAlignmentCenter;
        weekLab.textColor = [UIColor blackColor];
        [dateView addSubview:weekLab];
        
        //日期
        UILabel * dateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, DATEVIEW_HEIGHT/3, DATEVIEW_WIDTH, DATEVIEW_HEIGHT/3)];
        dateLab.text = dateStrArr[i];
        dateLab.font = [UIFont systemFontOfSize:12];//采用系统默认文字设置大小
        dateLab.textAlignment = NSTextAlignmentCenter;
        dateLab.textColor = [UIColor grayColor];
        [dateView addSubview:dateLab];
        
        //按钮
        UIButton *btnOrder = [[UIButton alloc] initWithFrame:CGRectMake(5, DATEVIEW_HEIGHT/3*2, DATEVIEW_WIDTH - 10, DATEVIEW_HEIGHT/3)];
        btnOrder.backgroundColor = [UIColor clearColor];
        btnOrder.tag = i;
        [btnOrder setTitle:@"预定" forState:UIControlStateNormal];
        [btnOrder setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btnOrder addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        [btnOrder.layer setMasksToBounds:YES];
        [btnOrder.layer setCornerRadius:2.0];
        [btnOrder.layer setBorderWidth:1.0];
        btnOrder.layer.borderColor=[UIColor orangeColor].CGColor;
        [dateView addSubview:btnOrder];
        
        [dateScrollView addSubview:dateView];
    }
    [dateScrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    [chooseView addSubview:dateScrollView];
    
    [self.myScrollView addSubview:chooseView];
}

-(void)selectDate:(UIButton *)btnDate {
    int n = (int)btnDate.tag;
//    dateStrArr[n];
    self.hidesBottomBarWhenPushed=YES;
    ChooseViewController * spvc = [[ChooseViewController alloc]init];
    [self.navigationController pushViewController:spvc animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
    
}

-(void)onClickImage{
    
    NSLog(@"图片被点击!");
    FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://bbsimg.qianlong.com/data/attachment/forum/day_070813/20070813_ff3c2a278aca3273b200CZ2k3Hf3TvaO.jpg"] name:@"Photo 1"];
    FSBasicImage *secondPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://www.nkfust.edu.tw/ezfiles/2/1002/img/229/StudentAssociation_2F_02.jpg"] name:@"Photo 2"];
    
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[firstPhoto, secondPhoto]];
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    [self.navigationController pushViewController:imageViewController animated:YES];
    
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

#pragma mark getDate
-(void)buildWeekDayString
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSDate *mydate = [NSDate date];
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:mydate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日"];
    
    weekdayArr = [[NSMutableArray alloc]init];
    dateStrArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 7; i++) {
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        [adcomps setYear:0];
        [adcomps setMonth:0];
        [adcomps setDay:i];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
        
        NSString *currentDateStr = [dateFormatter stringFromDate:newdate];
        
        [weekdayArr addObject:[self weekdayStringFromDate:newdate]];
        [dateStrArr addObject:currentDateStr];
    }
}
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



@end

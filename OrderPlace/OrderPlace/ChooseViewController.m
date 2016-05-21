//
//  ChooseViewController.m
//  InterestedActivity
//
//  Created by 张雪原 on 16/4/11.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "ChooseViewController.h"
#import "OrderViewController.h"

@interface ChooseViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *weekdayArr;
    NSMutableArray *dateStrArr;
    NSMutableArray *selectArr;
    NSMutableArray *arr;
    NSMutableDictionary * placeInfoDic;
    
    float fTotalPrice;
    NSString * selectWeekStr;
    NSString * selectDateStr;
    
    NSMutableArray *sectionArray;
}

@property (nonatomic, retain) UIScrollView *topScroll;
@property (nonatomic, retain) UIScrollView *middleScroll;
@property (nonatomic, retain) UICollectionView *middleCollection;
@property (nonatomic, retain) UICollectionViewFlowLayout *flow;
@property (nonatomic, retain) UIView *belowMiddleView;
@property (nonatomic, retain) UIButton *commitBtn;

@property (nonatomic, retain) UIButton *Monday;//今天
@property (nonatomic, retain) UIButton *Tuesday;
@property (nonatomic, retain) UIButton *Wednesday;
@property (nonatomic, retain) UIButton *Thursday;
@property (nonatomic, retain) UIButton *Friday;
@property (nonatomic, retain) UIButton *Saturday;
@property (nonatomic, retain) UIButton *Sunday;

@property (nonatomic, retain) UIView *OnedayView;//今天
@property (nonatomic, retain) UIView *TuesdayView;
@property (nonatomic, retain) UIView *WednesdayView;
@property (nonatomic, retain) UIView *ThursdayView;
@property (nonatomic, retain) UIView *FridayView;
@property (nonatomic, retain) UIView *SaturdayView;
@property (nonatomic, retain) UIView *SundayView;

@property (nonatomic, retain) UIView *line_one_b;
@property (nonatomic, retain) UIView *line_two_b;
@property (nonatomic, retain) UIView *line_three_b;
@property (nonatomic, retain) UIView *line_four_b;
@property (nonatomic, retain) UIView *line_five_b;
@property (nonatomic, retain) UIView *line_six_b;
@property (nonatomic, retain) UIView *line_seven_b;

@property (nonatomic, retain) UIView *nextView;
@property (nonatomic, retain) UIView *legend;
@property (nonatomic, retain) UIView *oneChooseView;
@property (nonatomic, retain) UIView *twoChooseView;
@property (nonatomic, retain) UIView *threeChooseView;
@property (nonatomic, retain) UIView *fourChooseView;
@property (nonatomic, retain) UILabel *one_label_time;
@property (nonatomic, retain) UILabel *two_label_time;
@property (nonatomic, retain) UILabel *three_label_time;
@property (nonatomic, retain) UILabel *four_label_time;
@property (nonatomic, retain) UILabel *one_label_section;
@property (nonatomic, retain) UILabel *two_label_section;
@property (nonatomic, retain) UILabel *three_label_section;
@property (nonatomic, retain) UILabel *four_label_section;
@property (nonatomic, retain) UILabel *moneyLabel;



@property (nonatomic, assign) long week;
@property (nonatomic, assign) long month;
@property (nonatomic, assign) long day;
@property (nonatomic, assign) long time;
@property (nonatomic, assign) long days;

@end

@implementation ChooseViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //获取网络数据
    //[_middleCollection reloadData];
    //假数据
    arr = [[NSMutableArray alloc] init];
    NSDictionary *dic =@{@"main":@"1号场", @"status":@"0",@"section":@"1"};
    [arr addObject:dic];
    NSDictionary *dic1 =@{@"main":@"14", @"status":@"0",@"section":@"0"};
    for(int i=0;i<15;i++){
        [arr addObject:dic1];
    }
    NSDictionary *dic2 =@{@"main":@"2号场", @"status":@"0",@"section":@"1"};
    [arr addObject:dic2];
    for(int i=0;i<15;i++){
        [arr addObject:dic1];
    }
    [_middleCollection reloadData];
}

-(void)initPlaceInfo:(NSMutableDictionary *)dic {
    placeInfoDic = [[NSMutableDictionary alloc]init];
    placeInfoDic = [dic mutableCopy];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择场次";
    
    _time = 9;
    
    _days = 1;
    
    [self initTopScrollView];//顶部scroll
    [self initMiddleScroll];
    [self initNextView];
    [self initCommitBtn];
    
    _oneChooseView.hidden = YES;
    _twoChooseView.hidden = YES;
    _threeChooseView.hidden = YES;
    _fourChooseView.hidden = YES;
    
    _line_one_b.backgroundColor = [UIColor greenColor];
    _moneyLabel.text = @"请选择场次";
}
#pragma mark - 初始化所有控件
-(void)initTopScrollView{
    [self createTopScroll];
    [self buildWeekDayString];
    selectArr = [[NSMutableArray alloc] init];
    _OnedayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    
    selectWeekStr = weekdayArr[0];
    selectDateStr = dateStrArr[0];
    
    UILabel *todayLable = [[UILabel alloc] init];
    NSString *item = @"今天";
    todayLable.text = item;
    UIFont *chooseLabelFont;
    if (ISIPHONE4S) {
        chooseLabelFont = [UIFont fontWithName:@"Helvetica" size:11.f];
    }else if (ISIPHONE5){
        chooseLabelFont = [UIFont fontWithName:@"Helvetica" size:12.f];
    }else{
        chooseLabelFont = [UIFont fontWithName:@"Helvetica" size:13.f];
    }
    
    todayLable.font =chooseLabelFont;
    todayLable.numberOfLines = 1;
    todayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    CGSize chooseSize = CGSizeMake(THE_WIDTH_OF_SCREEN/6, MAXFLOAT);
    NSDictionary *chooseDic = [NSDictionary dictionaryWithObjectsAndKeys:chooseLabelFont,NSFontAttributeName,nil];
    CGSize chooseActualsize =[item boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    todayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_OnedayView addSubview:todayLable];
    UILabel *todayDate = [[UILabel alloc] init];
    NSString *today_str = dateStrArr[0];
    todayDate.text = today_str;
    todayDate.font =chooseLabelFont;
    todayDate.numberOfLines = 1;
    todayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseDic = [NSDictionary dictionaryWithObjectsAndKeys:chooseLabelFont,NSFontAttributeName,nil];
     chooseActualsize =[today_str boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    todayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_OnedayView addSubview:todayDate];
    _Monday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Monday.backgroundColor = [UIColor clearColor];
    [_Monday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_OnedayView addSubview:_Monday];
    _line_one_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_one_b.backgroundColor = [UIColor grayColor];
    [_OnedayView addSubview:_line_one_b];
    [_topScroll addSubview:_OnedayView];
    UIView *line_one = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6, 0, 1, THE_HEIGHT_OF_SCREEN/15-3)];
    line_one.backgroundColor = [UIColor grayColor];
    [_topScroll addSubview:line_one];
    //第二天
    _TuesdayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6+1, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    UILabel *tuesdayLable = [[UILabel alloc] init];
    NSString *item_tuesday = weekdayArr[1];
    tuesdayLable.text = item_tuesday;
    tuesdayLable.font =chooseLabelFont;
    tuesdayLable.numberOfLines = 1;
    tuesdayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_tuesday boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    tuesdayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_TuesdayView addSubview:tuesdayLable];
    UILabel *tuesdayDate = [[UILabel alloc] init];
    NSString *item_tuesDate = dateStrArr[1];
    tuesdayDate.text = item_tuesDate;
    tuesdayDate.font =chooseLabelFont;
    tuesdayDate.numberOfLines = 1;
    tuesdayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_tuesDate boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    tuesdayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_TuesdayView addSubview:tuesdayDate];
    _Tuesday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Tuesday.backgroundColor = [UIColor clearColor];
    [_Tuesday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_TuesdayView addSubview:_Tuesday];
    _line_two_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_two_b.backgroundColor = [UIColor grayColor];
    [_TuesdayView addSubview:_line_two_b];
    [_topScroll addSubview:_TuesdayView];
    UIView *line_two = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*2+1, 0, 1, THE_HEIGHT_OF_SCREEN/15-3)];
    line_two.backgroundColor = [UIColor grayColor];
    [_topScroll addSubview:line_two];
    //第三天
    _WednesdayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*2+2, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    UILabel *wednesdayLable = [[UILabel alloc] init];
    NSString *item_wednesday = weekdayArr[2];
    wednesdayLable.text = item_wednesday;
    wednesdayLable.font =chooseLabelFont;
    wednesdayLable.numberOfLines = 1;
    wednesdayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_wednesday boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    wednesdayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_WednesdayView addSubview:wednesdayLable];
    UILabel *wednesdayDate = [[UILabel alloc] init];
    NSString *item_wednesDate = dateStrArr[2];
    wednesdayDate.text = item_wednesDate;
    wednesdayDate.font =chooseLabelFont;
    wednesdayDate.numberOfLines = 1;
    wednesdayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_wednesDate boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    wednesdayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_WednesdayView addSubview:wednesdayDate];
    _Wednesday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Wednesday.backgroundColor = [UIColor clearColor];
    [_Wednesday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_WednesdayView addSubview:_Wednesday];
    
    _line_three_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_three_b.backgroundColor = [UIColor grayColor];
    [_WednesdayView addSubview:_line_three_b];
    [_topScroll addSubview:_WednesdayView];
    UIView *line_three = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*3+2, 0, 1, THE_HEIGHT_OF_SCREEN/15-3)];
    line_three.backgroundColor = [UIColor grayColor];
    [_topScroll addSubview:line_three];
    //第四天
    _ThursdayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*3+3, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    UILabel *thursdayLable = [[UILabel alloc] init];
    NSString *item_thursday = weekdayArr[3];
    thursdayLable.text = item_thursday;
    thursdayLable.font =chooseLabelFont;
    thursdayLable.numberOfLines = 1;
    thursdayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_thursday boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    thursdayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_ThursdayView addSubview:thursdayLable];
    UILabel *thursdayDate = [[UILabel alloc] init];
    NSString *item_thursDate = dateStrArr[3];
    thursdayDate.text = item_thursDate;
    thursdayDate.font =chooseLabelFont;
    thursdayDate.numberOfLines = 1;
    thursdayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_thursDate boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    thursdayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_ThursdayView addSubview:thursdayDate];
    _Thursday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Thursday.backgroundColor = [UIColor clearColor];
    [_Thursday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_ThursdayView addSubview:_Thursday];
    
    _line_four_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_four_b.backgroundColor = [UIColor grayColor];
    [_ThursdayView addSubview:_line_four_b];
    [_topScroll addSubview:_ThursdayView];
    UIView *line_four = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*4+3, 0, 1, THE_HEIGHT_OF_SCREEN/15-3)];
    line_four.backgroundColor = [UIColor grayColor];
    [_topScroll addSubview:line_four];
    //第五天
    _FridayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*4+4, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    UILabel *fridayLable = [[UILabel alloc] init];
    NSString *item_friday = weekdayArr[4];
    fridayLable.text = item_friday;
    fridayLable.font =chooseLabelFont;
    fridayLable.numberOfLines = 1;
    fridayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_friday boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    fridayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_FridayView addSubview:fridayLable];
    UILabel *fridayDate = [[UILabel alloc] init];
    NSString *item_friDate = dateStrArr[4];
    fridayDate.text = item_friDate;
    fridayDate.font =chooseLabelFont;
    fridayDate.numberOfLines = 1;
    fridayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_friDate boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    fridayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_FridayView addSubview:fridayDate];
    _Friday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Friday.backgroundColor = [UIColor clearColor];
    [_Friday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_FridayView addSubview:_Friday];
    _line_five_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_five_b.backgroundColor = [UIColor grayColor];
    [_FridayView addSubview:_line_five_b];
    [_topScroll addSubview:_FridayView];
    UIView *line_five = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*5+4, 0, 1, THE_HEIGHT_OF_SCREEN/15-3)];
    line_five.backgroundColor = [UIColor grayColor];
    [_topScroll addSubview:line_five];
    //第六天
    _SaturdayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*5+5, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    UILabel *saturdayLable = [[UILabel alloc] init];
    NSString *item_saturday = weekdayArr[5];
    saturdayLable.text = item_saturday;
    saturdayLable.font =chooseLabelFont;
    saturdayLable.numberOfLines = 1;
    saturdayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_saturday boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    saturdayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_SaturdayView addSubview:saturdayLable];
    UILabel *saturdayDate = [[UILabel alloc] init];
    NSString *item_saturDate = dateStrArr[5];
    saturdayDate.text = item_saturDate;
    saturdayDate.font =chooseLabelFont;
    saturdayDate.numberOfLines = 1;
    saturdayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_saturDate boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    saturdayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_SaturdayView addSubview:saturdayDate];
    _line_six_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_six_b.backgroundColor = [UIColor grayColor];
    [_SaturdayView addSubview:_line_six_b];
    _Saturday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Saturday.backgroundColor = [UIColor clearColor];
    [_Saturday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_SaturdayView addSubview:_Saturday];
    [_topScroll addSubview:_SaturdayView];
    UIView *line_sex = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/6*6+5, 0, 1, THE_HEIGHT_OF_SCREEN/15-3)];
    line_sex.backgroundColor = [UIColor grayColor];
    [_topScroll addSubview:line_sex];
    //第七天
    _SundayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN+6, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    UILabel *sundayLable = [[UILabel alloc] init];
    NSString *item_sunday = weekdayArr[6];
    sundayLable.text = item_sunday;
    sundayLable.font =chooseLabelFont;
    sundayLable.numberOfLines = 1;
    sundayLable.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_sunday boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    sundayLable.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2,chooseActualsize.width,chooseActualsize.height);
    [_SundayView addSubview:sundayLable];
    UILabel *sundayDate = [[UILabel alloc] init];
    NSString *item_sunDate = dateStrArr[6];
    sundayDate.text = item_sunDate;
    sundayDate.font =chooseLabelFont;
    sundayDate.numberOfLines = 1;
    sundayDate.lineBreakMode =NSLineBreakByTruncatingTail;
    chooseActualsize =[item_sunDate boundingRectWithSize:chooseSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:chooseDic context:nil].size;
    sundayDate.frame =CGRectMake(THE_WIDTH_OF_SCREEN/12-chooseActualsize.width/2,THE_HEIGHT_OF_SCREEN/60-chooseActualsize.height/2+THE_HEIGHT_OF_SCREEN/30,chooseActualsize.width,chooseActualsize.height);
    [_SundayView addSubview:sundayDate];
    _line_seven_b = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/15-3, THE_WIDTH_OF_SCREEN/6, 3)];
    _line_seven_b.backgroundColor = [UIColor grayColor];
    [_SundayView addSubview:_line_seven_b];
    _Sunday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/6, THE_HEIGHT_OF_SCREEN/15-3)];
    _Sunday.backgroundColor = [UIColor clearColor];
    [_Sunday addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
    [_SundayView addSubview:_Sunday];
    [_topScroll addSubview:_SundayView];
    
}

-(void)createTopScroll{
    _topScroll = [[UIScrollView alloc] init];
    _topScroll.frame = CGRectMake(0, 0, THE_WIDTH_OF_SCREEN, THE_HEIGHT_OF_SCREEN/15);
    _topScroll.contentSize = CGSizeMake(THE_WIDTH_OF_SCREEN/6*7+6, THE_HEIGHT_OF_SCREEN/15);
    _topScroll.delegate = self;
    _topScroll.pagingEnabled = NO;
    _topScroll.directionalLockEnabled = YES;
    _topScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_topScroll];
}
-(void)createVerticalScroll{
    _middleScroll = [[UIScrollView alloc] init];
    _middleScroll.frame = CGRectMake(0, THE_HEIGHT_OF_SCREEN/15, THE_WIDTH_OF_SCREEN, THE_HEIGHT_OF_SCREEN/3*2);
    _middleScroll.contentSize = CGSizeMake(THE_WIDTH_OF_SCREEN, THE_HEIGHT_OF_SCREEN/3*2);
    _middleScroll.delegate = self;
    _middleScroll.pagingEnabled = NO;
    _middleScroll.directionalLockEnabled = YES;
    _middleScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_middleScroll];
}
-(void)initMiddleScroll{
    [self createVerticalScroll];
    UIFont *font;
    if (ISIPHONE4S) {
        font =[UIFont fontWithName:@"Helvetica" size:11.f];
    }else{
        font =[UIFont fontWithName:@"Helvetica" size:11.f];
    }
    UIView *verticalTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/10, THE_HEIGHT_OF_SCREEN/3*2+11-THE_HEIGHT_OF_SCREEN/25)];
    
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*16+8, THE_WIDTH_OF_SCREEN/10, 20)];
    label0.text = [[[NSString stringWithFormat:@"%ld",_time] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    
    label0.font = font;
    label0.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label0];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/5*3+7, THE_WIDTH_OF_SCREEN/10, 20)];
    label1.text = [[[NSString stringWithFormat:@"%ld",_time+1] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label1.font = font;
    label1.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*14+6, THE_WIDTH_OF_SCREEN/10, 20)];
    label2.text = [[[NSString stringWithFormat:@"%ld",_time+2] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label2.font = font;
    label2.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*13+6, THE_WIDTH_OF_SCREEN/10, 20)];
    label3.text = [[[NSString stringWithFormat:@"%ld",_time+3] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label3.font = font;
    label3.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*12+5, THE_WIDTH_OF_SCREEN/10, 20)];
    label4.text = [[[NSString stringWithFormat:@"%ld",_time+4] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label4.font =font;
    label4.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*11+5, THE_WIDTH_OF_SCREEN/10, 20)];
    label5.text = [[[NSString stringWithFormat:@"%ld",_time+5] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label5.font = font;
    label5.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*10+4, THE_WIDTH_OF_SCREEN/10, 20)];
    label6.text = [[[NSString stringWithFormat:@"%ld",_time+6] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label6.font = font;
    label6.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*9+4, THE_WIDTH_OF_SCREEN/10, 20)];
    label7.text = [[[NSString stringWithFormat:@"%ld",_time+7] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label7.font = font;
    label7.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*8+3, THE_WIDTH_OF_SCREEN/10, 20)];
    label8.text = [[[NSString stringWithFormat:@"%ld",_time+8] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label8.font = font;
    label8.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label8];
    
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*7+3, THE_WIDTH_OF_SCREEN/10, 20)];
    label9.text = [[[NSString stringWithFormat:@"%ld",_time+9] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label9.font = font;
    label9.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label9];
    
    UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*6+2, THE_WIDTH_OF_SCREEN/10, 20)];
    label10.text = [[[NSString stringWithFormat:@"%ld",_time+10] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label10.font = font;
    label10.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label10];
    
    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*5+1, THE_WIDTH_OF_SCREEN/10, 20)];
    label11.text = [[[NSString stringWithFormat:@"%ld",_time+11] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label11.font = font;
    label11.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label11];
    
    UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*4+1, THE_WIDTH_OF_SCREEN/10, 20)];
    label12.text = [[[NSString stringWithFormat:@"%ld",_time+12] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label12.font = font;
    label12.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label12];
    
    UILabel *label13 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*3+1, THE_WIDTH_OF_SCREEN/10, 20)];
    label13.text = [[[NSString stringWithFormat:@"%ld",_time+13] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label13.font = font;
    label13.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label13];
    
    UILabel *label14 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25*2+1, THE_WIDTH_OF_SCREEN/10, 20)];
    label14.text = [[[NSString stringWithFormat:@"%ld",_time+14] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label14.font = font;
    label14.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label14];
    
    UILabel *label15 = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2-10-THE_HEIGHT_OF_SCREEN/25+1, THE_WIDTH_OF_SCREEN/10, 20)];
    label15.text = [[[NSString stringWithFormat:@"%ld",_time+15] stringByAppendingString:@":00"] stringByAppendingString:@"-"];
    label15.font = font;
    label15.textAlignment = NSTextAlignmentRight;
    [verticalTime addSubview:label15];
    
    [_middleScroll addSubview:verticalTime];
    [self createCollection];
}
-(void)createCollection{
    _flow = [[UICollectionViewFlowLayout alloc] init];
    _flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flow.minimumInteritemSpacing = 0;
    //_flow.headerReferenceSize =CGSizeMake(48, THE_HEIGHT_OF_SCREEN/25-1);
    _flow.minimumLineSpacing = 1;
    _flow.itemSize = CGSizeMake(48, THE_HEIGHT_OF_SCREEN/25-1);
    _flow.sectionInset = UIEdgeInsetsMake(0, 1, 0, 0);
    
    _middleCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/10, 0, THE_WIDTH_OF_SCREEN-THE_WIDTH_OF_SCREEN/10,THE_HEIGHT_OF_SCREEN/3*2-THE_HEIGHT_OF_SCREEN/25+1) collectionViewLayout:_flow];
    _middleCollection.delegate = self;
    _middleCollection.dataSource = self;
    _middleCollection.pagingEnabled = YES;
    _middleCollection.backgroundColor = [UIColor whiteColor];
    [_middleCollection registerClass:[ChooseCollectionViewCell class] forCellWithReuseIdentifier:@"ChooseCollectionViewCell"];
    //[_middleCollection registerClass:[RecipeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [_middleScroll addSubview:_middleCollection];
    
}
-(void)initNextView{
    UIFont *font;
    if (ISIPHONE4S) {
        font =[UIFont fontWithName:@"Helvetica" size:10.f];
    }else{
        font =[UIFont fontWithName:@"Helvetica" size:11.f];
    }
    _nextView = [[UIView alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/3*2+THE_HEIGHT_OF_SCREEN/15, THE_WIDTH_OF_SCREEN, THE_HEIGHT_OF_SCREEN/11)];
    _legend = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/4, THE_HEIGHT_OF_SCREEN/44, THE_WIDTH_OF_SCREEN/2, THE_HEIGHT_OF_SCREEN/22)];
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/8, THE_HEIGHT_OF_SCREEN/22)];
    greenView.backgroundColor = [UIColor greenColor];
    
    UILabel *label_yes = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/44, THE_WIDTH_OF_SCREEN/8, THE_HEIGHT_OF_SCREEN/44)];
    label_yes.text = @"可预定";
    label_yes.font =font;
    label_yes.textAlignment = NSTextAlignmentCenter;
    [greenView addSubview:label_yes];
    [_legend addSubview:greenView];
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/4-THE_WIDTH_OF_SCREEN/16, 0, THE_WIDTH_OF_SCREEN/8, THE_HEIGHT_OF_SCREEN/22)];
    grayView.backgroundColor = [UIColor grayColor];
    
    UILabel *label_no = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/44, THE_WIDTH_OF_SCREEN/8, THE_HEIGHT_OF_SCREEN/44)];
    label_no.text = @"已预定";
    label_no.font =font;
    label_no.textAlignment = NSTextAlignmentCenter;
    [grayView addSubview:label_no];
    [_legend addSubview:grayView];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/2-THE_WIDTH_OF_SCREEN/8, 0, THE_WIDTH_OF_SCREEN/8, THE_HEIGHT_OF_SCREEN/22)];
    blueView.backgroundColor = [UIColor blueColor];
    
    UILabel *label_my = [[UILabel alloc] initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/44, THE_WIDTH_OF_SCREEN/8, THE_HEIGHT_OF_SCREEN/44)];
    label_my.text = @"我的预定";
    label_my.font =font;
    label_my.textAlignment = NSTextAlignmentCenter;
    [blueView addSubview:label_my];
    [_legend addSubview:blueView];
    [_nextView addSubview:_legend];

    _oneChooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/15)];
    _one_label_time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _one_label_time.backgroundColor = [UIColor blueColor];
    _one_label_time.textColor = [UIColor whiteColor];
    _one_label_time.textAlignment = NSTextAlignmentCenter;
    _one_label_time.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_oneChooseView addSubview:_one_label_time];
    _one_label_section = [[UILabel alloc]initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/30, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _one_label_section.textAlignment = NSTextAlignmentCenter;
    _one_label_section.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_oneChooseView addSubview:_one_label_section];
    [_nextView addSubview:_oneChooseView];
    
    _twoChooseView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/2-THE_WIDTH_OF_SCREEN/5-10, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/15)];
    _two_label_time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _two_label_time.backgroundColor = [UIColor blueColor];
    _two_label_time.textColor = [UIColor whiteColor];
    _two_label_time.textAlignment = NSTextAlignmentCenter;
    _two_label_time.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_twoChooseView addSubview:_two_label_time];
    _two_label_section = [[UILabel alloc]initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/30, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _two_label_section.textAlignment = NSTextAlignmentCenter;
    _two_label_section.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_twoChooseView addSubview:_two_label_section];
    [_nextView addSubview:_twoChooseView];
    
    _threeChooseView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN/2+10, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/15)];
    _three_label_time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _three_label_time.backgroundColor = [UIColor blueColor];
    _three_label_time.textColor = [UIColor whiteColor];
    _three_label_time.textAlignment = NSTextAlignmentCenter;
    _three_label_time.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_threeChooseView addSubview:_three_label_time];
    _three_label_section = [[UILabel alloc]initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/30, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _three_label_section.textAlignment = NSTextAlignmentCenter;
    _three_label_section.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_threeChooseView addSubview:_three_label_section];
    [_nextView addSubview:_threeChooseView];
    
    _fourChooseView = [[UIView alloc] initWithFrame:CGRectMake(THE_WIDTH_OF_SCREEN-THE_WIDTH_OF_SCREEN/5, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/15)];
    _four_label_time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _four_label_time.backgroundColor = [UIColor blueColor];
    _four_label_time.textColor = [UIColor whiteColor];
    _four_label_time.textAlignment = NSTextAlignmentCenter;
    _four_label_time.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_fourChooseView addSubview:_four_label_time];
    _four_label_section = [[UILabel alloc]initWithFrame:CGRectMake(0, THE_HEIGHT_OF_SCREEN/30, THE_WIDTH_OF_SCREEN/5, THE_HEIGHT_OF_SCREEN/30)];
    _four_label_section.textAlignment = NSTextAlignmentCenter;
    _four_label_section.font =[UIFont fontWithName:@"Helvetica" size:10.f];
    [_fourChooseView addSubview:_four_label_section];
    [_nextView addSubview:_fourChooseView];
    
    
    
    [self.view addSubview:_nextView];
}
-(void)initCommitBtn{
    UIView *commitView = [[UIView alloc] initWithFrame:CGRectMake(20, THE_HEIGHT_OF_SCREEN/15+THE_HEIGHT_OF_SCREEN/3*2+THE_HEIGHT_OF_SCREEN/11, THE_WIDTH_OF_SCREEN-40, THE_HEIGHT_OF_SCREEN/15)];
    commitView.backgroundColor = [UIColor redColor];
    _moneyLabel.text = @"请选择场次";
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, THE_WIDTH_OF_SCREEN-40, THE_HEIGHT_OF_SCREEN/15)];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.textColor = [UIColor whiteColor];
    _moneyLabel.font =[UIFont fontWithName:@"Helvetica" size:15.f];
    [commitView addSubview:_moneyLabel];
    [self.view addSubview:commitView];
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _nextView.frame.origin.y+_nextView.frame.size.height+10, THE_WIDTH_OF_SCREEN-40, THE_HEIGHT_OF_SCREEN/15)];
    commitBtn.backgroundColor = [UIColor clearColor];
    [commitBtn addTarget:self action:@selector(orderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
}

-(void)orderBtnAction:(UIButton *)button {
    
    
    if(selectArr.count <= 0) {
        
        return;
    }
//    NSMutableDictionary * orderInfoDic =  [[NSMutableDictionary alloc]init];
//    orderInfoDic = [placeInfoDic copy];
    NSString * dateweekStr = [[NSString alloc]initWithFormat:@"%@（%@）",selectWeekStr,selectDateStr];
    [placeInfoDic setObject:dateweekStr forKey:@"dateweek"];
    NSString *strTotal = [[NSString alloc]initWithFormat:@"%.2f",fTotalPrice];
    [placeInfoDic setObject:strTotal forKey:@"totalprice"];
    
    NSMutableArray *arrTimeSelected = [[NSMutableArray alloc]init];
    NSMutableArray *arrPlaceSelected = [[NSMutableArray alloc]init];

    for (int i = 0; i < selectArr.count; i++) {
        NSString *strTime = [[[[NSString stringWithFormat:@"%ld",[selectArr[i] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[i] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
        
        NSString *strPrice = [[arr objectAtIndex:[selectArr[i] intValue]] objectForKey:@"main"];
        
        NSString * strTimeAndPrice = [[NSString alloc]initWithFormat:@"%@  %@元",strTime,strPrice];
        [arrTimeSelected addObject:strTimeAndPrice];
        
        NSString *strPlace = [[sectionArray objectAtIndex:[selectArr[i] intValue]/16] objectForKey:@"main"];
        [arrPlaceSelected addObject:strPlace];
    }
    
    [placeInfoDic setObject:arrTimeSelected forKey:@"timeprice"];
    [placeInfoDic setObject:arrPlaceSelected forKey:@"placename"];
    
    self.hidesBottomBarWhenPushed=YES;
    OrderViewController * spvc = [[OrderViewController alloc]init];
    [spvc initOrderInfo:placeInfoDic];
    [self.navigationController pushViewController:spvc animated:YES];

}

#pragma mark - top按钮点击事件
-(void)selectWeek:(UIButton *)button{
    _line_one_b.backgroundColor = [UIColor grayColor];
    _line_two_b.backgroundColor = [UIColor grayColor];
    _line_three_b.backgroundColor = [UIColor grayColor];
    _line_four_b.backgroundColor = [UIColor grayColor];
    _line_five_b.backgroundColor = [UIColor grayColor];
    _line_six_b.backgroundColor = [UIColor grayColor];
    _line_seven_b.backgroundColor = [UIColor grayColor];
    
    int i = 0;
    if (button == _Monday) {
        _line_one_b.backgroundColor = [UIColor greenColor];
        i = 0;
    }else if (button == _Tuesday){
        _line_two_b.backgroundColor = [UIColor greenColor];
        i = 1;
    }else if (button == _Wednesday){
        _line_three_b.backgroundColor = [UIColor greenColor];
        i = 2;
    }else if (button == _Thursday){
        _line_four_b.backgroundColor = [UIColor greenColor];
        i = 3;
    }else if (button == _Friday){
        _line_five_b.backgroundColor = [UIColor greenColor];
        i = 4;
    }else if (button == _Saturday){
        _line_six_b.backgroundColor = [UIColor greenColor];
        i = 5;
    }else{
        _line_seven_b.backgroundColor = [UIColor greenColor];
        i = 6;
    }
    selectWeekStr = weekdayArr[i];
    selectDateStr = dateStrArr[i];
    //getData获取数据
    [_middleCollection reloadData];
    [selectArr removeAllObjects];
    _legend.hidden = NO;
    _oneChooseView.hidden = YES;
    _twoChooseView.hidden = YES;
    _threeChooseView.hidden = YES;
    _fourChooseView.hidden = YES;
}
#pragma mark - collection代理
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 32;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableview = nil;
//    if (kind == UICollectionElementKindSectionHeader){
//        RecipeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        //headerView.frame = CGRectMake(0, 0, 48, THE_HEIGHT_OF_SCREEN/25-2);
//        headerView.backgroundColor = [UIColor redColor];
//        reusableview = headerView;
//    }
//    
//    return reusableview;
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChooseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = [arr objectAtIndex:indexPath.item];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    if ([[dic objectForKey:@"section"] isEqualToString:@"1"]) {
        cell.price = [dic objectForKey:@"main"];
        cell.tag = 2;
        cell.backgroundColor = [UIColor clearColor];
    }else{
        cell.price = [@"¥" stringByAppendingString:[dic objectForKey:@"main"]];
        if ([[dic objectForKey:@"status"] isEqualToString:@"0"]) {
            cell.tag = 0;
            cell.backgroundColor = [UIColor greenColor];
        }else{
            cell.tag = 3;
            cell.backgroundColor = [UIColor grayColor];
        }
        
    }
    if (indexPath.item%16 <= [dateTime integerValue] -_time) {
        cell.tag = 3;
        cell.backgroundColor = [UIColor grayColor];
    }
    if ([[dic objectForKey:@"section"] isEqualToString:@"1"]) {
        cell.tag = 2;
        cell.backgroundColor = [UIColor clearColor];
    }
    for (int i = 0; i<selectArr.count; i++) {
        if ([[NSString stringWithFormat:@"%ld",indexPath.item] isEqualToString:selectArr[i]]) {
            cell.tag = 1;
            cell.backgroundColor = [UIColor blueColor];
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ChooseCollectionViewCell *cell = (ChooseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //[dic setObject:[NSString stringWithFormat:@"%ld",indexPath.item] forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = [arr objectAtIndex:indexPath.item];
    if (indexPath.item %16 != 0) {
        if (selectArr.count<=4) {
            if (selectArr.count == 4) {
                if(cell.tag == 1){
                    cell.tag = 0;
                    cell.backgroundColor = [UIColor greenColor];
                    for (int i=0; i<selectArr.count; i++) {
                        NSString *str = selectArr[i];
                        if ([str isEqualToString:[NSString stringWithFormat:@"%ld",indexPath.item]]) {
                            [selectArr removeObjectAtIndex:i];
                            break;
                        }
                    }
                }
            }else{
                if (cell.tag == 0) {
                    cell.tag = 1;
                    cell.backgroundColor = [UIColor blueColor];
                    [selectArr addObject:[NSString stringWithFormat:@"%ld",indexPath.item]];
                }else if(cell.tag == 1){
                    cell.tag = 0;
                    cell.backgroundColor = [UIColor greenColor];
                    for (int i=0; i<selectArr.count; i++) {
                        NSString *str = selectArr[i];
                        if ([str isEqualToString:[NSString stringWithFormat:@"%ld",indexPath.item]]) {
                            [selectArr removeObjectAtIndex:i];
                            break;
                        }
                    }
                }else{
                    NSLog(@"不可点击");
                }
            }
        }
    }
    if (selectArr.count>0) {
        sectionArray = [[NSMutableArray alloc] init];
        //使用真数据是更改
        float sum=0;
        for (int i=0; i<selectArr.count; i++) {
            sum += [[[arr objectAtIndex:[selectArr[i] intValue]] objectForKey:@"main"] floatValue];
        }
        for (int i=0; i<arr.count; i++) {
            if ([[[arr objectAtIndex:i] objectForKey:@"section"] isEqualToString:@"1"]) {
                [sectionArray addObject:[arr objectAtIndex:i]];
            }
        }
        
        fTotalPrice = sum;
        
        _moneyLabel.text = [[@"¥" stringByAppendingString:[NSString stringWithFormat:@"%.2f",sum]] stringByAppendingString:@" 提交订单"];
        _legend.hidden = YES;
        if (selectArr.count == 1) {
            _oneChooseView.hidden = NO;
            _twoChooseView.hidden = YES;
            _threeChooseView.hidden = YES;
            _fourChooseView.hidden = YES;
            _one_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _one_label_section.text = [[sectionArray objectAtIndex:[selectArr[0] intValue]/16] objectForKey:@"main"];
        }else if (selectArr.count == 2){
            _oneChooseView.hidden = NO;
            _twoChooseView.hidden = NO;
            _threeChooseView.hidden = YES;
            _fourChooseView.hidden = YES;
            _one_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _two_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[1] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[1] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _one_label_section.text = [[sectionArray objectAtIndex:[selectArr[0] intValue]/16] objectForKey:@"main"];
            _two_label_section.text = [[sectionArray objectAtIndex:[selectArr[1] intValue]/16] objectForKey:@"main"];
        }else if (selectArr.count == 3){
            _oneChooseView.hidden = NO;
            _twoChooseView.hidden = NO;
            _threeChooseView.hidden = NO;
            _fourChooseView.hidden = YES;
            _one_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _two_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[1] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[1] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _three_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[2] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[2] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _one_label_section.text = [[sectionArray objectAtIndex:[selectArr[0] intValue]/16] objectForKey:@"main"];
            _two_label_section.text = [[sectionArray objectAtIndex:[selectArr[1] intValue]/16] objectForKey:@"main"];
            _three_label_section.text = [[sectionArray objectAtIndex:[selectArr[2] intValue]/16] objectForKey:@"main"];
        }else{
            _oneChooseView.hidden = NO;
            _twoChooseView.hidden = NO;
            _threeChooseView.hidden = NO;
            _fourChooseView.hidden = NO;
            _one_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[0] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _two_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[1] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[1] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _three_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[2] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[2] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _four_label_time.text = [[[[NSString stringWithFormat:@"%ld",[selectArr[3] intValue]%16+(_time-1)] stringByAppendingString:@":00"] stringByAppendingString:@"-"] stringByAppendingString:[[NSString stringWithFormat:@"%ld",[selectArr[3] intValue]%16+(_time-1)+1] stringByAppendingString:@":00"]];
            _one_label_section.text = [[sectionArray objectAtIndex:[selectArr[0] intValue]/16] objectForKey:@"main"];
            _two_label_section.text = [[sectionArray objectAtIndex:[selectArr[1] intValue]/16] objectForKey:@"main"];
            _three_label_section.text = [[sectionArray objectAtIndex:[selectArr[2] intValue]/16] objectForKey:@"main"];
            _four_label_section.text = [[sectionArray objectAtIndex:[selectArr[3] intValue]/16] objectForKey:@"main"];
        }
    }else{
        _moneyLabel.text = @"请选择场次";
        _legend.hidden = NO;
        _oneChooseView.hidden = YES;
        _twoChooseView.hidden = YES;
        _threeChooseView.hidden = YES;
        _fourChooseView.hidden = YES;
    }
}


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

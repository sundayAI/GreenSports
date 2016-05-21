//
//  PlaceViewController.m
//  OrderPlace
//
//  Created by Daisy on 16/3/30.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import "PlaceViewController.h"
#import "UIScrollView+SpiralPullToRefresh.h"
#import "UINavigationController+StatusBarStyle.h"
#import "PlaceTypeCell.h"
#import "SGFocusImageFrame.h"
#import "PlaceCell.h"
#import "ChooseViewController.h"
#import "PlaceDetailViewController.h"


@interface PlaceViewController () <SGFocusImageFrameDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrPlace;
    NSString * strSportType;
}

@property (nonatomic, strong) NSTimer *workTimer;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *imageURLs;

@end

@implementation PlaceViewController

@synthesize workTimer = _workTimer;
@synthesize items = _items;

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray new];
    }
    return _items;
}

- (void)statTodoSomething {
    
    [self.workTimer invalidate];
    
    self.workTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onAllworkDoneTimer) userInfo:nil repeats:NO];
}

- (void)onAllworkDoneTimer {
    [self.workTimer invalidate];
    self.workTimer = nil;
    
//    [self.items addObject: [NSNumber numberWithInt: self.items.count]];
    
    [self.myTable.pullToRefreshController didFinishRefresh];
    [self.myTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrPlace = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RED_COLOR;
    self.navigationController.navigationBar.translucent = NO;
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self initPlaceData];
    
    strSportType = @"羽毛球";
    
    
    __typeof (&*self) __weak weakSelf = self;
    
    [self.myTable addPullToRefreshWithActionHandler:^ {
        int64_t delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf refreshTriggered];
        });
    }];
    

}

-(void)initPlaceData {
    
    
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:6];
    [mutableDictionary setObject:@"1" forKey:@"id"];
    [mutableDictionary setObject:@"大奥羽毛球馆" forKey:@"name"];
    [mutableDictionary setObject:@"工业大学" forKey:@"address"];
    [mutableDictionary setObject:@">100KM" forKey:@"distance"];
    [mutableDictionary setObject:@"￥25" forKey:@"price"];
    [mutableDictionary setObject:@"url" forKey:@"pic"];
    [arrPlace addObject:mutableDictionary];
    
    NSMutableDictionary * mutableDictionary2 = [NSMutableDictionary dictionaryWithCapacity:6];
    [mutableDictionary2 setObject:@"2" forKey:@"id"];
    [mutableDictionary2 setObject:@"四维体育场" forKey:@"name"];
    [mutableDictionary2 setObject:@"铁西北二路" forKey:@"address"];
    [mutableDictionary2 setObject:@">100KM" forKey:@"distance"];
    [mutableDictionary2 setObject:@"￥20" forKey:@"price"];
    [mutableDictionary2 setObject:@"url" forKey:@"pic"];
    [arrPlace addObject:mutableDictionary2];
    
    NSMutableDictionary * mutableDictionary3 = [NSMutableDictionary dictionaryWithCapacity:6];
    [mutableDictionary3 setObject:@"3" forKey:@"id"];
    [mutableDictionary3 setObject:@"奥体中心" forKey:@"name"];
    [mutableDictionary3 setObject:@"浑南" forKey:@"address"];
    [mutableDictionary3 setObject:@">100KM" forKey:@"distance"];
    [mutableDictionary3 setObject:@"￥30" forKey:@"price"];
    [mutableDictionary3 setObject:@"url" forKey:@"pic"];
    [arrPlace addObject:mutableDictionary3];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTriggered {
    [self statTodoSomething];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section != 2) {
        return 1;
    }
    return [arrPlace count];
}

#pragma mark 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section] == 0) {
        return 85.0f;
    }else if([indexPath section] == 1) {
        return 100.0f;
    }else
       return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            static NSString *indentifier = @"PlaceTypeCell";
            PlaceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
            
            if (cell == nil)
            {
                //通过xib的名称加载自定义的cell
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PlaceTypeCell" owner:self options:nil] lastObject];
            }
            
            if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            {
                [cell setSeparatorInset:UIEdgeInsetsZero];
            }
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;    //取消点击高亮样式
            
            [cell.btn1 addTarget:self action:@selector(btnTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn2 addTarget:self action:@selector(btnTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn3 addTarget:self action:@selector(btnTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn4 addTarget:self action:@selector(btnTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;

        }
    }else if([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            static NSString *cellIdentifier = @"ADCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithTitle:@"title1" image:[UIImage imageNamed:@"image0"] tag:0];
            SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithTitle:@"title2" image:[UIImage imageNamed:@"image1"] tag:1];
            SGFocusImageItem *item3 = [[SGFocusImageItem alloc] initWithTitle:@"title3" image:[UIImage imageNamed:@"image2"] tag:2];
            SGFocusImageItem *item4 = [[SGFocusImageItem alloc] initWithTitle:@"title4" image:[UIImage imageNamed:@"image3"] tag:4];
            
            SGFocusImageFrame *bottomImageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100.0) delegate:self focusImageItems:item1, item2, item3, item4, nil];
            bottomImageFrame.autoScrolling = YES;
            [cell addSubview:bottomImageFrame];
            
            return cell;
            
        }
    }else {
        static NSString *indentifier = @"PlaceCell";
        PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        if (cell == nil)
        {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:self options:nil] lastObject];
        }
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        cell.orderBtn.tag = [indexPath row];
        [cell.orderBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderBtn.layer setMasksToBounds:YES];
        [cell.orderBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [cell.orderBtn.layer setBorderWidth:1.0]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
        
        [cell.orderBtn.layer setBorderColor:colorref];//边框颜色
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;    //取消点击高亮样式
        
        
        NSMutableDictionary * mutableDictionary = [arrPlace objectAtIndex:indexPath.row];
        
        cell.nameLab.text = [mutableDictionary objectForKey:@"name"];
        cell.posLab.text =  [mutableDictionary objectForKey:@"address"];
        cell.disLab.text = [mutableDictionary objectForKey:@"distance"];
        cell.priceLab.text = [mutableDictionary objectForKey:@"price"];
        
        
        return cell;
    }
    return nil;

}

-(void)btnTypeAction:(id)sender{
    NSInteger i = [sender tag];
    if (i == 11) {
        strSportType = @"羽毛球";
    } else if (i == 12) {
        strSportType = @"篮球";
    } else if (i == 13) {
        strSportType = @"足球";
    } else if (i == 14) {
        strSportType = @"网球";
    }
}

-(void)btnAction:(id)sender{
    //这个sender其实就是UIButton，因此通过sender.tag就可以拿到刚才的参数
    NSInteger i = [sender tag];
    NSMutableDictionary * mutableDictionary = [arrPlace objectAtIndex:i];
    
    [mutableDictionary setObject:strSportType forKey:@"SportType"];
    self.hidesBottomBarWhenPushed=YES;
    ChooseViewController * spvc = [[ChooseViewController alloc]init];
    [spvc initPlaceInfo:mutableDictionary];
    [self.navigationController pushViewController:spvc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed=YES;
    PlaceDetailViewController * spvc = [[PlaceDetailViewController alloc]init];
    [self.navigationController pushViewController:spvc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


#pragma mark - SGFocusImageFrameDelegate

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%@ tapped", item.title);
    
    if (item.tag == 1004) {
        [imageFrame removeFromSuperview];
    }
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

//
//  OrderViewController.m
//  OrderPlace
//
//  Created by Daisy on 16/5/19.
//  Copyright © 2016年 SurpassYX. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderViewNormalCell.h"
#import "OrderViewCostCell.h"

@interface OrderViewController () {
    BOOL isSwitch;
    NSMutableDictionary * orderDic;
    NSMutableArray *arrPlace;
    NSMutableArray *arrTimePrice;
}

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
}

-(void)initOrderInfo:(NSMutableDictionary *)dic {
    orderDic = [dic copy];
    arrPlace = [[NSMutableArray alloc]init];
    arrPlace = [orderDic objectForKey:@"placename"];
    arrTimePrice = [[NSMutableArray alloc]init];
    arrTimePrice = [orderDic objectForKey:@"timeprice"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark 设置每个Section的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        //计算订购多少个场地
        return [arrPlace count] + 2;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return 3;
    }else if (section == 3) {
        return 1;
    }
    return 0;
}

#pragma mark 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50.0f;
    }else if (indexPath.section == 1) {
        return 50.0f;
    }else if (indexPath.section == 2) {
        return 50.0f;
    }else if (indexPath.section == 3) {
        return 130.0f;
    }

    return 100.0f;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *indentifier = @"OrderViewNormalCell";
        OrderViewNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        if (cell == nil)
        {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderViewNormalCell" owner:self options:nil] lastObject];
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
        
        if (indexPath.row == 0) {
            cell.typeLab.text = [orderDic objectForKey:@"SportType"];
            cell.contextLab.text = [orderDic objectForKey:@"name"];

        }else if (indexPath.row == [arrPlace count] + 1) {
            //最后一行
            cell.typeLab.text = @"日期";
            cell.contextLab.text = [orderDic objectForKey:@"dateweek"];
        }else {
            cell.typeLab.text = [arrPlace objectAtIndex:indexPath.row - 1];
            cell.contextLab.text = [arrTimePrice objectAtIndex:indexPath.row - 1];
            
        }
        
        return cell;
        
    }else if (indexPath.section == 1) {
        static NSString *SwitchCellIdentifier = @"SwitchCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SwitchCellIdentifier];
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
        
        UILabel * insuranceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 40)];
        insuranceLab.text = @"运动保险";
        insuranceLab.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:insuranceLab];
        
        UISwitch * insuranceSwitch = [[UISwitch alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 50, 5, 100, 40)];
        insuranceSwitch.on = NO;
        [insuranceSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:insuranceSwitch];
        
        return cell;

    }else if (indexPath.section == 2) {
        
        static NSString *indentifier = @"OrderViewCostCell";
        OrderViewCostCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        if (cell == nil)
        {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderViewCostCell" owner:self options:nil] lastObject];
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
        
        if (indexPath.row == 0) {
            
            cell.nameLab.text = @"场地费用";
            NSString * strTemp = [orderDic objectForKey:@"totalprice"];
            strTemp = [strTemp stringByAppendingString:@"元"];
            cell.costLab.text = strTemp;

        } else if (indexPath.row == 1) {
            
            cell.nameLab.text = @"保险总额";
            cell.costLab.text = @"0元";

        } else if (indexPath.row == 2) {
            
            cell.nameLab.text = @"支付金额";
            NSString * strTemp = [orderDic objectForKey:@"totalprice"];
            strTemp = [strTemp stringByAppendingString:@"元"];
            cell.costLab.text = strTemp;
            cell.costLab.textColor = [UIColor orangeColor];
            
        }
        return cell;
    }else{
        static NSString *SubCellIdentifier = @"SubCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SubCellIdentifier];
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
        UILabel * costTextLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
        costTextLab.font = [UIFont systemFontOfSize:15.0];
        costTextLab.text = @"您的手机号码:18500000000";
        [cell addSubview:costTextLab];
        
        UIButton * subBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        subBtn.frame = CGRectMake(10, 40, [[UIScreen mainScreen] bounds].size.width - 20, 50);
        [subBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [subBtn setTitle:@"提交订单" forState:UIControlStateHighlighted];
        [subBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [subBtn setBackgroundColor:[UIColor orangeColor]];
        [subBtn.layer setMasksToBounds:YES];
        [subBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//        [subBtn.layer setBorderWidth:1.0]; //边框宽度
        [subBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:subBtn];
        
        UILabel * tipTextLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 200, 30)];
        tipTextLab.text = @"暂不支持退换";
        tipTextLab.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:tipTextLab];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)payAction:(id)sender
{
    
}

-(void)switchAction:(id)sender
{
    UISwitch * switchView = (UISwitch *)sender;
    isSwitch = switchView.on;
}

@end

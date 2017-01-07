//
//  TrainDetailVC.m
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainDetailVC.h"
#import "TrainDetailCell0.h"
#import "TrainDetailCell1.h"
#import "TrainDetailCell2.h"
#import "TrainDetailCell3.h"
#import "CoachDetailVC.h"
#import "ComplaintCoachVC.h"
@interface TrainDetailVC ()

@end

@implementation TrainDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的练车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitleWithTwoWords:@"投诉"];
    [self.rightNaviBtn addTarget:self action:@selector(complaintCoach) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryTags=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateData];
}
-(void)complaintCoach
{
    ComplaintCoachVC *vc=[[ComplaintCoachVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"practice/getEvaluateDetail.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[[self.preData objectForKey:@"practiceId"] stringValue]] forKeys:@[@"account",@"practiceId"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
            [self.m_aryTags removeAllObjects];
            [self.m_aryTags addObjectsFromArray:[self.data objectForKey:@"tags"]];
            [self.m_tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        TrainDetailCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"TrainDetailCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TrainDetailCell0" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    else if (indexPath.row==1)
    {
        TrainDetailCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"TrainDetailCell1"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TrainDetailCell1" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    else if (indexPath.row==2)
    {
        TrainDetailCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"TrainDetailCell2"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TrainDetailCell2" owner:nil options:nil] objectAtIndex:0];
        }
        cell.m_aryData=self.m_aryTags;
        [cell updateView];
        return cell;
    }
    else
    {
        TrainDetailCell3 *cell=[tableView dequeueReusableCellWithIdentifier:@"TrainDetailCell3"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TrainDetailCell3" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=100;
    }
    else if (indexPath.row==1)
    {
        height=100;
    }
    else if (indexPath.row==2)
    {
        if (self.m_aryTags.count>0)
        {
            height=20+(self.m_aryTags.count/3+1)*(30+10);
        }
        else
        {
            height=0;
        }
    }
    else if (indexPath.row==3)
    {
        height=20+[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:280.0 font:[UIFont systemFontOfSize:14.0]]+20;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------- drive detail top delegate -------
-(void)showCoachDetailVC:(NSString *)coachID
{
    CoachDetailVC *vc=[[CoachDetailVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObjects:@[coachID] forKeys:@[@"coachId"]];
    [self.navigationController pushViewController:vc animated:YES];
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

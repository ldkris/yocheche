//
//  CoachListView.m
//  yocheche
//
//  Created by carcool on 1/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CoachListView.h"
#import "SchoolListVC.h"
#import "CoachSmallAvatarCell.h"
@implementation CoachListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:YCC_GrayBG];
        self.m_aryData=[NSMutableArray array];
        self.pageIndex=1;
        self.pageCount=10;
        self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, frame.size.height)];
        [self addSubview:self.m_tableView];
        [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.m_tableView setBackgroundColor:YCC_GrayBG];
        self.m_tableView.dataSource=self;
        self.m_tableView.delegate=self;
        self.m_tableView.showsVerticalScrollIndicator=NO;
        [self setupHeader];
        [self setupFooter];
    }
    return self;
}
#pragma mark ------- refresh view
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.m_tableView];
    
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
    _refreshHeader = refreshHeader;
}
-(void)headerRefresh
{
    self.pageIndex=1;
    [self.delegate updateDataForCoach];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.m_tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}
- (void)footerRefresh
{
    self.pageIndex++;
    [self.delegate updateDataForCoach];
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count>0?self.m_aryData.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        CoachSmallAvatarCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachSmallAvatarCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachSmallAvatarCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row];
        [cell updateView];
        NSString *strType=@"";
        if ([[cell.data objectForKey:@"type"] integerValue]==1)
        {
            strType=@"全科";
        }
        else if ([[cell.data objectForKey:@"type"] integerValue]==2)
        {
            strType=@"科目二";
        }
        else if ([[cell.data objectForKey:@"type"] integerValue]==3)
        {
            strType=@"科目三";
        }
        cell.labelInfo.text=[NSString stringWithFormat:@"%@ %@",strType,[cell.data objectForKey:@"distance"]];
        return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 90)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        UILabel *labelNoData=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, Screen_Width, 30)];
        [labelNoData setTextAlignment:NSTextAlignmentCenter];
        [labelNoData setTextColor:[UIColor lightGrayColor]];
        [labelNoData setFont:[UIFont systemFontOfSize:14.0]];
        labelNoData.text=@"未找到相应的教练";
        [cell addSubview:labelNoData];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.m_aryData.count>0)
    {
        [self.delegate showCoachDetailVC:[self.m_aryData objectAtIndex:indexPath.row]];
    }
//    [self.delegate showSchoolDetailVC:[self.m_aryData objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
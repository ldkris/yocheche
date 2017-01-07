//
//  MyCenterView.m
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyCenterView.h"
#import "MyCenterTopCell.h"
#import "OtherCenterActionCell.h"
#import "MySocialCenterVC.h"
#import "MyInfoNewVC.h"
@implementation MyCenterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:YCC_GrayBG];
        self.postType=0;
        self.pageIndex=1;
        self.pageCount=30;
        self.m_aryData=[NSMutableArray array];
        self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, frame.size.height)];
        [self addSubview:self.m_tableView];
        [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.m_tableView setBackgroundColor:YCC_GrayBG];
        self.m_tableView.dataSource=self;
        self.m_tableView.delegate=self;
        [self setupHeader];
        [self setupFooter];
    }
    return self;
}
- (void)dealloc
{
    if (self.refreshHeader)
    {
        [self.refreshHeader removeFromSuperview];
    }
    if (self.refreshFooter)
    {
        [self.refreshFooter removeFromSuperview];
    }
    
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

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.m_tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

-(void)headerRefresh
{
    self.pageIndex=1;
    if (self.postType==0)
    {
        [self.delegate getMyPostListPageIndex:[NSString stringWithFormat:@"%d",self.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.pageCount]];
    }
    else if (self.postType==1)
    {
        [self.delegate getMyLikePostListPageIndex:[NSString stringWithFormat:@"%d",self.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.pageCount]];
    }
    
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    if (self.postType==0)
    {
        [self.delegate getMyPostListPageIndex:[NSString stringWithFormat:@"%d",self.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.pageCount]];
    }
    else if (self.postType==1)
    {
        [self.delegate getMyLikePostListPageIndex:[NSString stringWithFormat:@"%d",self.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.pageCount]];
    }
}


#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.m_aryData.count>0)
    {
        return 1+(self.m_aryData.count-1)/3+1;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        MyCenterTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyCenterTopCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyCenterTopCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    else
    {
        OtherCenterActionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OtherCenterActionCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OtherCenterActionCell" owner:nil options:nil] objectAtIndex:0];
            cell.vcDelegate=self;
        }
        cell.m_aryData=[NSMutableArray array];
        NSInteger currentIndex=(indexPath.row-1)*3;
        NSInteger i=0;
        while (i<3)
        {
            if (currentIndex<self.m_aryData.count)
            {
                [cell.m_aryData addObject:[self.m_aryData objectAtIndex:currentIndex]];
            }
            currentIndex++;
            i++;
        }
        [cell updateView];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=210;
    }
    else
    {
        height=107;
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
#pragma mark -------- otherCenterCell delegate
-(void)showPostVCFromCenter:(NSDictionary*)preData
{
    [self.delegate showPostVC:preData];
}
-(void)showEditInfoVC
{
    MyInfoNewVC *vc=[[MyInfoNewVC alloc] init];
//    vc.preData=(NSMutableDictionary*)predata;
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

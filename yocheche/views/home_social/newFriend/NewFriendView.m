//
//  NewFriendView.m
//  yocheche
//
//  Created by carcool on 1/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "NewFriendView.h"
#import "SocialHomeVC.h"
#import "NewFriendCell.h"
#import "ChatViewController.h"
@implementation NewFriendView
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
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    appdelegate.updateLocationType=1;//new friend
    [appdelegate updateLocation];
//    [self.delegate getNewFriendLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] Pageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
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
    [self.delegate getNewFriendLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] Pageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NewFriendCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"NewFriendCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        [self.delegate showOtherCenterVC:[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"account"]];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------- event response ------------
-(void)chatWithUserChatID:(NSString *)chatAccount username:(NSString *)name userAvatar:(NSString *)avatar account:(NSString*)accountOther
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.delegate.navigationController.navigationBar.hidden=NO;
    
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:chatAccount conversationType:eConversationTypeChat];
    chatVC.accountMy=[[MyFounctions getUserInfo] objectForKey:@"account"];
    chatVC.accountOther=accountOther;
    chatVC.idMy=[[MyFounctions getUserInfo] objectForKey:@"chatAccount"];
    chatVC.idOther=chatAccount;
    chatVC.avatarURl=[[MyFounctions getUserInfo] objectForKey:@"avatar"];
    chatVC.avatarURlOther=avatar;
    chatVC.nameMy=[[MyFounctions getUserInfo] objectForKey:@"nickName"];
    chatVC.nameOther=name;
    chatVC.title =chatVC.nameOther;
    
    [self.delegate.navigationController  pushViewController:chatVC animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

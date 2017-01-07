//
//  HotCategoryView.m
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HotCategoryView.h"
#import "SocialHomeVC.h"
#import "HotCategoryCellNew.h"
@implementation HotCategoryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:YCC_GrayBG];
        self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, frame.size.height)];
        [self addSubview:self.m_tableView];
        [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.m_tableView setBackgroundColor:YCC_GrayBG];
        self.m_tableView.dataSource=self;
        self.m_tableView.delegate=self;
        self.m_tableView.showsVerticalScrollIndicator=NO;
        [self setupHeader];
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
    [self.delegate getHotCategoriesLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude]];
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCategoryCellNew *cell=[tableView dequeueReusableCellWithIdentifier:@"HotCategoryCellNew"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"HotCategoryCellNew" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate showHotPostListVC:indexPath.row];
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

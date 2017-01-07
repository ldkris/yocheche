//
//  YoView.m
//  yocheche
//
//  Created by carcool on 6/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FollowView.h"
#import "FollowAdverCell.h"
#import "PostNameCell.h"
#import "PostPicCell.h"
#import "PostInfoCell.h"
#import "PostContentCell.h"
#import "PostCommentCell.h"
#import "SocialHomeVC.h"
#import "PostTagsCell.h"
@implementation FollowView
@synthesize m_tableView;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.m_aryAdvers=[NSMutableArray array];
        self.m_aryContentHeight=[NSMutableArray array];
        self.m_aryCommentHeight=[NSMutableArray array];
        self.m_aryData=[NSMutableArray array];
        self.pageIndex=1;
        self.pageCount=10;
        self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, frame.size.height)];
        [self addSubview:self.m_tableView];
        [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.m_tableView setBackgroundColor:YCC_GrayBG];
        self.m_tableView.dataSource=self;
        self.m_tableView.delegate=self;
        [self setupHeader];
        [self setupFooter];
        self.old_y=0;
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
#pragma mark --------------- show navigationbar ----------------
//-(void)showNavigationBar
//{
//    if (self.isNaviHidden==YES)
//    {
//        self.isHiddeningOrShowing=YES;
//        [self setFrame:CGRectMake(PARENT_X(self), PARENT_Y(self)+64, PARENT_WIDTH(self), PARENT_HEIGHT(self)-64)];
//        [self.delegate.topbg setFrame:CGRectMake(PARENT_X(self.delegate.topbg), 0, PARENT_WIDTH(self.delegate.topbg), PARENT_HEIGHT(self.delegate.topbg))];
//        [self.m_tableView setFrame:CGRectMake(PARENT_X(self.m_tableView), PARENT_Y(self.m_tableView), PARENT_WIDTH(self.m_tableView), PARENT_HEIGHT(self.m_tableView)-64)];
//        self.isNaviHidden=NO;
//        self.isHiddeningOrShowing=NO;
//    }
//}

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
    [self.delegate updateFollowPostPageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self.delegate updateFollowPostPageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count*5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (indexPath.row%5==0)
        {
            PostNameCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostNameCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostNameCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
                cell.vcDelegate=self.delegate;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row/5];
            [cell updateView];
            return cell;
        }
        else if (indexPath.row%5==1)
        {
            PostPicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostPicCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostPicCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
                cell.imgDelegate=self.delegate;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row/5];
            [cell updateView];
            return cell;
        }
        else if (indexPath.row%5==2)
        {
            PostContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostContentCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostContentCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row/5];
            [cell updateView];
            return cell;
        }
        else if (indexPath.row%5==3)
        {
            PostTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostTagsCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostTagsCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row/5];
            [cell updateView];
            return cell;
        }
        else
        {
            
            PostInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostInfoCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row/5];
            [cell updateView];
            return cell;
            

        }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;

        if (indexPath.row%5==0)
        {
            height=60;
        }
        else if (indexPath.row%5==1)
        {
            if ([[[self.m_aryData objectAtIndex:(indexPath.row-1)/5] objectForKey:@"height"] integerValue]!=0)
            {
                height=[[[self.m_aryData objectAtIndex:(indexPath.row-1)/5] objectForKey:@"height"] integerValue]*320/[[[self.m_aryData objectAtIndex:(indexPath.row-1)/5] objectForKey:@"width"] integerValue];
            }
            else
            {
                height=320;
            }
        }
        else if (indexPath.row%5==2)
        {
            height=[[self.m_aryContentHeight objectAtIndex:(indexPath.row-1)/5] floatValue];
        }
        else if (indexPath.row%5==3)
        {
            NSDictionary *dic=[self.m_aryData objectAtIndex:(indexPath.row-1)/5];
            NSMutableString *tagsContent=[NSMutableString stringWithString:@""];
            for (NSString *tag in [dic objectForKey:@"tags"])
            {
                [tagsContent appendString:[NSString stringWithFormat:@"#%@ ",tag]];
            }
            float contentHeight=[MyFounctions calculateLabelHeightWithString:tagsContent Width:300 font:[UIFont systemFontOfSize:14]];
            if ([tagsContent isEqualToString:@""])
            {
                height=0;
            }
            else
            {
                height=contentHeight+10;
            }
        }
        else
        {
            height=40;

        }

    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"self.m_aryData :%@",self.m_aryData);
    [self.delegate showPostVC:[self.m_aryData objectAtIndex:indexPath.row/5]];
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

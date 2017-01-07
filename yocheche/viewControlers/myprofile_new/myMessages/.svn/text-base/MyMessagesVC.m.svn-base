//
//  MyMessagesVC.m
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyMessagesVC.h"
#import "MyMessageCell.h"
#import "MyMessageDetailVC.h"
#import "MyMessageSocialCell.h"
#import "PostDeatilVC.h"
#import "OtherCenterVC.h"
@interface MyMessagesVC ()

@end

@implementation MyMessagesVC
@synthesize m_scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的消息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    self.topLineView=[[UIView alloc] initWithFrame:CGRectMake(50,37 , 60, 3)];
    [self.topLineView setBackgroundColor:YCC_Green];
    [self.topLineView.layer setCornerRadius:2.0];
    [self.topbg addSubview:self.topLineView];
    [self.labelMyGetLikeAndComment setTextColor:[UIColor blackColor]];
    [self.labelMyMessage setTextColor:YCC_Green];
    [self.labelMyGetLikeAndComment setTextColor:YCC_TextColor];
    self.messageType=0;
    self.pageCount=10;
    self.pageIndexSocial=1;
    self.pageCountSocial=10;
    self.m_aryData=[NSMutableArray array];
    self.m_aryDataSocial=[NSMutableArray array];
    [self createScrollView];
    
    self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-40)];
    self.m_tableView.tag=0;
    [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_scrollView addSubview:self.m_tableView];
    
    [self setupHeader];
    [self setupFooter];
    [self updateData];
    [self updateDataForSocial];
    
    self.m_tableviewSocial=[[UITableView alloc] initWithFrame:CGRectMake(Screen_Width, 0, Screen_Width, Screen_Height-64-40)];
    self.m_tableviewSocial.tag=1;
    [self.m_tableviewSocial setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableviewSocial setDelegate:self];
    [self.m_tableviewSocial setDataSource:self];
    [self.m_scrollView addSubview:self.m_tableviewSocial];
}
#pragma mark ---------- create views -------------------
-(void)createScrollView
{
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, Screen_Width, Screen_Height-40-64)];
    self.m_scrollView.bounces=NO;
    self.m_scrollView.delegate=self;
    self.m_scrollView.tag=11;
    [m_scrollView setContentSize:CGSizeMake(Screen_Width*2, Screen_Height-64-49)];
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.pagingEnabled=YES;
    [m_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    self.m_scrollView.scrollEnabled=YES;
    [self.view addSubview:self.m_scrollView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [MobClick beginLogPageView:@"消息－我的消息"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"消息－我的消息"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"message/getUserMessage.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"2",[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"account",@"all",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"messages"]];
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
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];

}
-(void)updateDataForSocial
{
//    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getMyLikeCommentList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndexSocial],[NSString stringWithFormat:@"%d",self.pageCountSocial],@"110",@""] forKeys:@[@"account",@"pageindex",@"pagesize",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndexSocial==1)
            {
                [self.m_aryDataSocial removeAllObjects];
            }
            [self.m_aryDataSocial addObjectsFromArray:[req.m_data objectForKey:@"likeComments"]];
            [self.m_tableviewSocial reloadData];
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
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
    
}

#pragma  mark ------ refresh delegate
-(void)headerRefresh
{
    if (self.messageType==0)
    {
        self.pageIndex=1;
        [self updateData];
    }
    else
    {
        self.pageIndexSocial=1;
        [self updateDataForSocial];
    }
    
}
-(void)footerRefresh
{
    if (self.messageType==0)
    {
        self.pageIndex++;
        [self updateData];
    }
    else
    {
        self.pageIndexSocial++;
        [self updateDataForSocial];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0)
    {
        return self.m_aryData.count;
    }
    else
    {
        return self.m_aryDataSocial.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        MyMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyMessageCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyMessageCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row];
        [cell updateView];
        return cell;
    }
    else
    {
        MyMessageSocialCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyMessageSocialCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyMessageSocialCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[self.m_aryDataSocial objectAtIndex:indexPath.row];
        [cell updateView];
        return cell;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=60;
    if (tableView.tag==0)
    {
        height=60;
    }
    else
    {
        height=70;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MyMessageDetailVC *vc=[[MyMessageDetailVC alloc] init];
        vc.data=[self.m_aryData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        PostDeatilVC *vc=[[PostDeatilVC alloc] init];
        vc.preData=[self.m_aryDataSocial objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------- event response ----------
-(void)showOtherCenterVC:(NSString*)account
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ======= scroll delegate==============
//UIScrollViewDelegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    if (sView.tag==11)
    {
        NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.topLineView setFrame:CGRectMake(index*160+50, PARENT_Y(self.topLineView), PARENT_WIDTH(self.topLineView), PARENT_HEIGHT(self.topLineView))];
        } completion:^(BOOL finished) {
            [self setTopMenuLabelColor:index];
            self.messageType=index;
            if (self.messageType==0)
            {
                [self.refreshHeader addToScrollView:self.m_tableView];
                [self.refreshFooter addToScrollView:self.m_tableView];
            }
            else
            {
                [self.refreshHeader addToScrollView:self.m_tableviewSocial];
                [self.refreshFooter addToScrollView:self.m_tableviewSocial];
            }
        }];
    }
}

#pragma mark ------- event response ------- top menu
-(IBAction)topMenuBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<2)
    {
        [self.m_scrollView scrollRectToVisible:CGRectMake(Screen_Width*btn.tag, 0, 320, Screen_Height-64-49) animated:YES];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.topLineView setFrame:CGRectMake(50+btn.tag*160, PARENT_Y(self.topLineView), PARENT_WIDTH(self.topLineView), PARENT_HEIGHT(self.topLineView))];
        } completion:^(BOOL finished) {
            [self setTopMenuLabelColor:btn.tag];
            self.messageType=btn.tag;
            if (self.messageType==0)
            {
                [self.refreshHeader addToScrollView:self.m_tableView];
                [self.refreshFooter addToScrollView:self.m_tableView];
            }
            else
            {
                [self.refreshHeader addToScrollView:self.m_tableviewSocial];
                [self.refreshFooter addToScrollView:self.m_tableviewSocial];
            }
        }];
    }
}
-(void)setTopMenuLabelColor:(NSInteger)index
{
    [self.labelMyMessage setTextColor:YCC_TextColor];
    [self.labelMyGetLikeAndComment setTextColor:YCC_TextColor];
    switch (index)
    {
        case 0:
            [self.labelMyMessage setTextColor:YCC_Green];
            break;
        case 1:
            [self.labelMyGetLikeAndComment setTextColor:YCC_Green];
            break;
        default:
            break;
    }
    if(index==0)
    {
        [MobClick endLogPageView:@"消息－赞和评论"];
        [MobClick beginLogPageView:@"消息－我的消息"];
    }
    else if (index==1)
    {
        [MobClick endLogPageView:@"消息－我的消息"];
        [MobClick beginLogPageView:@"消息－赞和评论"];
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

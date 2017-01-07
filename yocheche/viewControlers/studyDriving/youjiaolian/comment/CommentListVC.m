//
//  CommentListVC.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CommentListVC.h"
#import "CommentCell.h"
#import "CommentVC.h"
#import "OtherCenterVC.h"
#import "CommentSummaryCell.h"
@interface CommentListVC ()

@end

@implementation CommentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryData=[NSMutableArray array];
    self.m_aryHeight=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];

//    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
//    [self.view addSubview:self.btn];
//    [self.btn addTarget:self action:@selector(showComentVC) forControlEvents:UIControlEventTouchUpInside];

    self.title=self.name;
    self.pageCount=10;
    [self updateData];
}
-(void)dealloc
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"CommentListVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"CommentListVC"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"comment.coach.get",[NSString stringWithFormat:@"%d",[[self.coachData objectForKey:@"coachid"] integerValue]],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"method",@"coachid",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSDictionary dictionaryWithDictionary:req.m_data];
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"comments"]];
            //content height
            [self.m_aryHeight removeAllObjects];
            for (NSDictionary *dic in self.m_aryData)
            {
                if ([[dic objectForKey:@"content"] isEqualToString:@""])
                {
                    [self.m_aryHeight addObject:@"0"];
                }
                else
                {
                    [self.m_aryHeight addObject:[NSString stringWithFormat:@"%f",[MyFounctions calculateLabelHeightWithString:[dic objectForKey:@"content"] Width:280 font:[UIFont systemFontOfSize:14.0]]]];
                }
            }
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
#pragma  mark ------ refresh delegate
-(void)headerRefresh
{
    self.pageIndex=1;
    [self updateData];
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
    
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        CommentSummaryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommentSummaryCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CommentSummaryCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[NSDictionary dictionaryWithDictionary:self.data];
        [cell updateView];
        return cell;
    }
    else
    {
        CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row-1];
        cell.contentHeight= [[self.m_aryHeight objectAtIndex:indexPath.row-1] floatValue];
        [cell updateView];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 130;
    }
    else
    {
        NSArray *tagsAry=[[self.m_aryData objectAtIndex:indexPath.row-1] objectForKey:@"tags"];
        float tagHeight=tagsAry.count>0?((tagsAry.count+2)/3)*(30+5):0;
        return 70+[[self.m_aryHeight objectAtIndex:indexPath.row-1] floatValue]+tagHeight+40;
    }
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
#pragma mark ------- comment cell delegate -----------
-(void)showOtherCenterVCTappedAvatar:(NSString *)account
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------- event response
-(void)showComentVC
{
    CommentVC *vc=[[CommentVC alloc] init];
    vc.coachData=self.coachData;
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
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

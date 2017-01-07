//
//  OfficialNotifyListVC.m
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OfficialNotifyListVC.h"
#import "OfficialNotifyCell.h"
@interface OfficialNotifyListVC ()

@end

@implementation OfficialNotifyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"官方通知";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.pageCount=10;
    self.m_aryData=[NSMutableArray array];
    self.m_aryContentHeight=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];
    
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [self.m_aryContentHeight removeAllObjects];
            for (NSDictionary *dic in self.m_aryData)
            {
                float height=[MyFounctions calculateLabelHeightWithString:[dic objectForKey:@"content"] Width:304 font:[UIFont systemFontOfSize:14.0]];
                [self.m_aryContentHeight addObject:[NSString stringWithFormat:@"%f",height]];
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
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
    }];
    
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfficialNotifyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OfficialNotifyCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"OfficialNotifyCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    height=30+[[self.m_aryContentHeight objectAtIndex:indexPath.row] floatValue]+15;
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------- refresh delegate
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

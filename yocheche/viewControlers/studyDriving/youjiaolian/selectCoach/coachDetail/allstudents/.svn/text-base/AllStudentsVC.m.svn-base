//
//  AllStudentsVC.m
//  yocheche
//
//  Created by carcool on 9/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AllStudentsVC.h"
#import "AllStudentCell.h"
@interface AllStudentsVC ()

@end

@implementation AllStudentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"学员";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.pageCount=30;
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self setupFooter];
    [self setupHeader];
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"AllStudentsVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"AllStudentsVC"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"student.coach.get",[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount],[[MyFounctions getUserInfo] objectForKey:@"account"],[self.delegate.coachData objectForKey:@"coachid"]] forKeys:@[@"method",@"pageindex",@"pagesize",@"account",@"coachid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"users"]];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.m_aryData.count>0)
    {
        return (self.m_aryData.count-1)/3+1;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllStudentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AllStudentCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"AllStudentCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.m_aryData=[NSMutableArray array];
    NSInteger currentIndex=indexPath.row*3;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

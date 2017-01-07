//
//  MessageVC.m
//  weixueche
//
//  Created by carcool on 1/19/15.
//  Copyright (c) 2015 carcool. All rights reserved.
//

#import "KnowledgeVC.h"
#import "myTabbarVC.h"
#import "KnowledgeHomeCell.h"
#import "MessageWebVC.h"
#import "myTabbarVC.h"
@interface KnowledgeVC ()

@end

@implementation KnowledgeVC
@synthesize m_aryDatas;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"优技巧";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryDatas=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.m_tableView setFrame:CGRectMake(0, 64+20, Screen_Width, Screen_Height-64-49)];
    self.m_tableView.scrollEnabled=NO;
    
    [self updateData];
}
-(void)viewDidAppear:(BOOL)animated
{
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"KnowledgeVC"];
}
-(void)viewWillAppear:(BOOL)animated
{
     [MobClick beginLogPageView:@"KnowledgeVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    [self startLoading];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"message.cms.get",@""] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoading];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryDatas removeAllObjects];
            NSInteger i=0;
            for (NSDictionary *dic in [req.m_data valueForKey:@"infos"])
            {
                for (NSDictionary *dic2  in [dic objectForKey:@"datas"])
                {
                    [self.m_aryDatas addObject:dic2];
                }
                i++;
                if (i<[(NSArray*)[req.m_data valueForKey:@"infos"] count])
                {
                    [self.m_aryDatas addObject:@{@"title":@"",@"url":@""}];
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
        
    }];

}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.m_aryDatas objectAtIndex:indexPath.row] objectForKey:@"title"] isEqualToString:@""])
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        KnowledgeHomeCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"KnowledgeHomeCell" owner:nil options:nil] objectAtIndex:0];
        cell.labelTitle.text=[[self.m_aryDatas objectAtIndex:indexPath.row] objectForKey:@"title"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.m_aryDatas objectAtIndex:indexPath.row] objectForKey:@"title"] isEqualToString:@""])
    {
        return 20;
    }
    else
    {
        return 55;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[[self.m_aryDatas objectAtIndex:indexPath.row] objectForKey:@"title"] isEqualToString:@""])
    {
        MessageWebVC *vc=[[MessageWebVC alloc] init];
        vc.dic=[self.m_aryDatas objectAtIndex:indexPath.row];
        [vc updateView];
        [self.navigationController pushViewController:vc animated:YES];
    }
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

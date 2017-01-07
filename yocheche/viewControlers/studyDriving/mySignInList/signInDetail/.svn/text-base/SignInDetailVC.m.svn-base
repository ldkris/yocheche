//
//  SignInDetailVC.m
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SignInDetailVC.h"
#import "SignInDetailTopCell.h"
#import "CoachDetailVC.h"
#import "CommentCell.h"
@interface SignInDetailVC ()

@end

@implementation SignInDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"签到详情";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"SignInDetailVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"SignInDetailVC"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/getSignDetail.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.preData objectForKey:@"signid"]] forKeys:@[@"account",@"signid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSDictionary dictionaryWithDictionary:req.m_data];
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
    if ([[self.data objectForKey:@"content"] isEqualToString:@""]&&[[self.data objectForKey:@"isgood"] integerValue]!=1)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        SignInDetailTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SignInDetailTopCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SignInDetailTopCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[NSDictionary dictionaryWithDictionary:self.data];
        cell.preData=self.preData;
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
        cell.data=self.data;
        //updateView
        float comtentHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:224 font:[UIFont systemFontOfSize:14.0]];
        cell.contentHeight=comtentHeight;
        [cell updateViewForSignInComment];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 140;
    }
    else
    {
        return 70+[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:224 font:[UIFont systemFontOfSize:14.0]]+40;
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
#pragma mark ----------- sign in detail top cell delegate --------
-(void)showCoachDetailVC:(NSString *)coachID
{
    CoachDetailVC *vc=[[CoachDetailVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObjects:@[coachID] forKeys:@[@"coachId"]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showOtherCenterVCTappedAvatar:(NSString *)account
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

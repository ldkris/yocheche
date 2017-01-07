//
//  InputInviteCodeVC.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "InputInviteCodeVC.h"
#import "InputInviteCodeCell0.h"
#import "InputInviteCodeCell1.h"
#import "PayVC.h"
@interface InputInviteCodeVC ()

@end

@implementation InputInviteCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"输入邀请码";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.inviteCode=@"";
    [self addTableView];
    [self.m_tableView setFrame: CGRectMake(0,64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    self.m_tableView.scrollEnabled=NO;
    
     [self.bottomView setFrame:CGRectMake(0, Screen_Height-40-100, Screen_Width, 100)];
    [self.view addSubview:self.bottomView];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        InputInviteCodeCell0 *cell=[[[NSBundle mainBundle] loadNibNamed:@"InputInviteCodeCell0" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        return cell;
    }
    else
    {
        InputInviteCodeCell1 *cell=[[[NSBundle mainBundle] loadNibNamed:@"InputInviteCodeCell1" owner:nil options:nil] objectAtIndex:0];
        self.m_inputcell1=cell;
        self.m_inputcell1.hidden=YES;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 80;
    }
    else
    {
        return 280;
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
#pragma mark ------- event response
-(void)inputDone:(NSString*)str
{
    if ([str isEqualToString:@""])
    {
        self.bottomView.hidden=NO;
        self.m_tableView.scrollEnabled=NO;
        self.m_inputcell1.hidden=YES;
    }
    else
    {
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        [req setParams:@[@"coupon.user.put",[[MyFounctions getUserInfo] objectForKey:@"account"],str] forKeys:@[@"method",@"account",@"coupon"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                self.bottomView.hidden=YES;
                self.m_tableView.scrollEnabled=YES;
                self.m_inputcell1.hidden=NO;
                self.m_inputcell1.data=req.m_data;
                [self.m_inputcell1 updateView];
                self.inviteCode=[req.m_data objectForKey:@"coupon"];
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
}
-(IBAction)nextStepBtnPressed:(id)sender
{
    NSLog(@"user :%@",[MyFounctions getUserInfo]);
    //creat order
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    NSMutableDictionary *user=(NSMutableDictionary*)[MyFounctions getUserInfo];
    [req setParams:@[@"enroll.drivingschool.order",[user objectForKey:@"account"],[[user objectForKey:@"coach"] objectForKey:@"id"],[[user objectForKey:@"fee"] objectForKey:@"id"],self.inviteCode] forKeys:@[@"method",@"account",@"coachid",@"feeid",@"coupon"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            PayVC *vc=[[PayVC alloc] init];
            vc.inviteCode=self.inviteCode;
            vc.orderID=[req.m_data objectForKey:@"orderid"];
            [self.navigationController pushViewController:vc animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

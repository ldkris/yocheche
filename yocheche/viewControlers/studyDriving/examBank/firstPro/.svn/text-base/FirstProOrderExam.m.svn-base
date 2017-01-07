//
//  FirstProOrderExam.m
//  weixueche
//
//  Created by carcool on 12/12/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "FirstProOrderExam.h"
#import "FirstProOrderExamDoneVC.h"
#import "FirstProgressVC.h"
@interface FirstProOrderExam ()

@end

@implementation FirstProOrderExam
@synthesize progressIndex,btnSubmit,btnTrainAgain;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"预约·申请考试";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnSubmit setColor:Green_btn];
    [self.btnTrainAgain setColor:[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)pricticeAgain:(id)sender
{
    [self popSelfViewContriller];
}
-(IBAction)verifySubmit:(id)sender
{
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.exam.order",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.progressIndex]] forKeys:@[@"method",@"account",@"type"]];
    [req startWithBlock:^{
        [self stopLoading];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data valueForKey:@"status"] integerValue]==0)
            {
                FirstProOrderExamDoneVC *vc=[[FirstProOrderExamDoneVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([[req.m_data valueForKey:@"status"] integerValue]==1)
            {
                [self showAlertViewWithTitle:@"已提交预约申请" message:@"您还需返回首页即时支付补考费" cancelButton:@"确定" others:nil];
            }
            
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
                self.alertView.delegate=self;
            }
            else
            {
                [self showNetworkError];
            }
            
        }
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

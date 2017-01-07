//
//  ApplyStudyVC.m
//  yocheche
//
//  Created by carcool on 3/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ApplyStudyVC.h"
#import "StudyDemandVC.h"
@interface ApplyStudyVC ()

@end

@implementation ApplyStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我要学车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnBG setClipsToBounds:YES];
    [self.btnBG.layer setCornerRadius:PARENT_WIDTH(self.btnBG)/2.0];
    
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/getGrabIndexInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
            [self updateView];
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
-(void)updateView
{
    self.labelCoachNum.text=[[self.data objectForKey:@"totalCoach"] stringValue];
    
    [self.labelAddress removeFromSuperview];
    self.labelAddress=nil;
    [self.imgLocation removeFromSuperview];
    self.imgLocation=nil;
    float contentWidth=[MyFounctions calculateTextWidth:[self.data objectForKey:@"address"] font:[UIFont systemFontOfSize:14]];
    self.labelAddress=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-contentWidth)/2.0+12, 158, contentWidth, 20)];
    [self.labelAddress setFont:[UIFont systemFontOfSize:14.0]];
    [self.labelAddress setTextColor:[UIColor darkGrayColor]];
    self.labelAddress.text=[self.data objectForKey:@"address"];
    [self.view addSubview:self.labelAddress];
    self.imgLocation=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-contentWidth)/2.0-12, 160, 14,18 )];
    [self.imgLocation setImage:[UIImage imageNamed:@"location_ycc_gray"]];
    [self.view addSubview:self.imgLocation];
}
#pragma mark ------- event response ------------
-(IBAction)studyBtnPressed:(id)sender
{
    StudyDemandVC *vc=[[StudyDemandVC alloc] init];
    vc.coachID=@"";
    [self.navigationController pushViewController:vc animated:YES];
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

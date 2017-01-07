//
//  SubmitExamVC.m
//  weixueche
//
//  Created by carcool on 1/16/15.
//  Copyright (c) 2015 carcool. All rights reserved.
//

#import "SubmitExamVC.h"
#import <ShareSDK/ShareSDK.h>
#import "SelectExamItemVC.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface SubmitExamVC ()

@end

@implementation SubmitExamVC
@synthesize passFlag,bottomView,shareButton,mainView,score,delegate,time,labelScore,labelTime;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    
    if (passFlag==1)
    {
        [self.mainView setImage:[UIImage imageNamed:@"submit_pass"]];
    }
    self.labelScore.text=[NSString stringWithFormat:@"%d",score];
    self.labelTime.text=self.time;
    
    
}
-(void)viewDidLayoutSubviews
{
    [self.bottomView setFrame:CGRectMake(PARENT_X(bottomView), Screen_Height-PARENT_HEIGHT(bottomView), PARENT_WIDTH(bottomView), PARENT_HEIGHT(bottomView))];
    [self.shareButton setFrame:CGRectMake(PARENT_X(shareButton), Screen_Height<=480?Screen_Height-47-80:Screen_Height-47-100, PARENT_WIDTH(shareButton), PARENT_HEIGHT(shareButton))];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    [MobClick beginLogPageView:@"SubmitExamVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [MobClick endLogPageView:@"SubmitExamVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----------- actions
-(IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)shareBtnPressed:(id)sender
{

        Http *req=[[Http alloc] init];
        [self startLoading];
        [req setParams:@[@"share.user.get",[[[MyFounctions getUserInfo] objectForKey:@"account"] length]>0?[[MyFounctions getUserInfo] objectForKey:@"account"]:@"",@"2",[NSString stringWithFormat:@"%d",self.delegate.delegateVC.progressIndex],[NSString stringWithFormat:@"%d",self.score]] forKeys:@[@"method",@"account",@"type",@"step",@"score"]];
        [req startWithBlock:^{
            [self stopLoading];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                [self shareWithContent:[req.m_data objectForKey:@"content"] andUrl:[req.m_data objectForKey:@"url"]];
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
-(void)shareWithContent:(NSString*)content andUrl:(NSString*)urlstr
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    appdelegate.handleURLtype=0;//set appdelegate handle type
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[[UIImage imageNamed:@"icon_aboutus"]]
                                        url:[NSURL URLWithString:urlstr]
                                      title:content
                                       type:SSDKContentTypeAuto];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
}
-(IBAction)showTestPaper
{
    SelectExamItemVC *vc=[[SelectExamItemVC alloc] init];
    vc.delegate=self.delegate;
    vc.m_aryTests=self.delegate.m_aryTests;
    vc.m_dicSelected=self.delegate.m_dicSelected;
    [vc updateViews];
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

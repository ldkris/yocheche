//
//  MyScoresVC.m
//  weixueche
//
//  Created by carcool on 1/9/15.
//  Copyright (c) 2015 carcool. All rights reserved.
//

#import "MyScoresVC.h"
#import "ScroeCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface MyScoresVC ()

@end

@implementation MyScoresVC
@synthesize delegate,m_aryScoreWithTime,m_aryShowedScoreWithTime;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"我的成绩";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"MyScoreVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"MyScoreVC"];
}
-(void)updateViews
{
    self.m_aryScoreWithTime=[NSMutableArray array];
    self.m_aryShowedScoreWithTime=[NSMutableArray array];
    self.m_aryScoreWithTime=self.delegate.m_logInfo.scoreWithTimeArray;
    
    NSInteger i=0;
    while (i<self.m_aryScoreWithTime.count)
    {
        [self.m_aryShowedScoreWithTime addObject:[self.m_aryScoreWithTime objectAtIndex:i]];
        i++;
    }
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    self.m_tableView.scrollEnabled=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryShowedScoreWithTime.count>0?self.m_aryShowedScoreWithTime.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryShowedScoreWithTime.count>0)
    {
        ScroeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ScroeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ScroeCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.labelScore.text=[NSString stringWithFormat:@"%@分",[[self.m_aryShowedScoreWithTime objectAtIndex:indexPath.row] objectForKey:@"score"]];
        if ([[[self.m_aryShowedScoreWithTime objectAtIndex:indexPath.row] objectForKey:@"score"] integerValue]>89)
        {
            [cell.labelScore setTextColor:Green_btn];
        }
        else
        {
            [cell.labelScore setTextColor:[UIColor redColor]];
        }
        cell.labelTime.text=[[self.m_aryShowedScoreWithTime objectAtIndex:indexPath.row] objectForKey:@"time"];
        return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
        [label setText:@"暂无成绩，先去模拟考试吧！"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTextColor:[UIColor grayColor]];
        [cell addSubview:label];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryShowedScoreWithTime.count==0)
    {
        return;
    }
    
//        Http *req=[[Http alloc] init];
//        [self startLoading];
//        [req setParams:@[@"share.user.get",[[[MyFounctions getUserInfo] objectForKey:@"account"] length]>0?[[MyFounctions getUserInfo] objectForKey:@"account"]:@"",@"2",[NSString stringWithFormat:@"%d",self.delegate.progressIndex],[[self.m_aryShowedScoreWithTime objectAtIndex:indexPath.row] objectForKey:@"score"]] forKeys:@[@"method",@"account",@"type",@"step",@"score"]];
//        [req startWithBlock:^{
//            [self stopLoading];
//            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
//            {
//                [self shareWithContent:[req.m_data objectForKey:@"content"] andUrl:[req.m_data objectForKey:@"url"]];
//            }
//            else
//            {
//                if ([req.m_data valueForKey:@"msg"])
//                {
//                    [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
//                }
//                else
//                {
//                    [self showNetworkError];
//                }
//                
//            }
//            
//        }];
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)shareWithContent:(NSString*)content andUrl:(NSString*)urlstr
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    appdelegate.handleURLtype=0;//set appdelegate handle type
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_aboutus@2x" ofType:@"png"];
    //构造分享内容
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

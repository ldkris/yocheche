//
//  CoachDetailVC.m
//  yocheche
//
//  Created by carcool on 7/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachDetailVC.h"
#import "CoachDetailCellPhotos.h"
#import "CoachDetailCell0.h"
#import "CoachDetailCell1.h"
#import "CoachDetailCell2.h"
#import "CoachDetailCell4.h"
#import "CoachDetailCell5.h"
#import "CoachDetailCell6.h"
#import "LookUpMapVC.h"
#import "InviteFriendVC.h"
#import "CommentListVC.h"
#import "SelectSchemeVC.h"
#import "FillStudyInfo.h"
#import <ShareSDK/ShareSDK.h>
#import "OtherCenterVC.h"
#import "StudyDemandVC.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface CoachDetailVC ()

@end

@implementation CoachDetailVC
@synthesize m_aryShowed;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnImage:[UIImage imageNamed:@"share_post"]];
    [self.rightNaviBtn addTarget:self action:@selector(shareCoach) forControlEvents:UIControlEventTouchUpInside];
    self.bundleCoachID=@"";
    self.signUpFlag=0;
    self.contentHeight=0;
    self.selectedScheme=-1;
    self.expendedArray=[NSMutableArray array];
    self.m_aryStudents=[NSMutableArray array];
    self.m_aryShowed=[NSMutableArray arrayWithObjects:@"-1",@"0",@"4",@"5",@"6", nil];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self.btnBG1 setFrame:CGRectMake(0, Screen_Height-40, 320, 40)];
    self.btnBG1.hidden=YES;
    [self.view addSubview:self.btnBG1];
    [self updateData];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"coach/getCoachDetail.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.preData objectForKey:@"coachId"]] forKeys:@[@"account",@"coachid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 处理耗时操作的代码块...
                self.coachData=req.m_data;
                if ([[req.m_data objectForKey:@"comment"] isKindOfClass:[NSString class]])
                {
                    self.commentData=[NSDictionary dictionary];
                }
                else
                {
                    self.commentData=[req.m_data objectForKey:@"comment"];
                }
                self.schoolData=nil;
                self.spaceData=[req.m_data objectForKey:@"space"];
                self.feeArray=[req.m_data objectForKey:@"feeinfos"];
                self.m_aryStudents=[NSMutableArray arrayWithArray:[req.m_data objectForKey:@"students"]];

                NSInteger i=0;
                while (i<self.feeArray.count)
                {
                    [self.m_aryShowed insertObject:@"1" atIndex:2];
                    [self.expendedArray insertObject:@"0" atIndex:0];
                    i++;
                }
                self.contentHeight=[MyFounctions calculateLabelHeightWithString:[self.commentData objectForKey:@"content"] Width:300 font:[UIFont systemFontOfSize:14.0]];
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                    
                    //reload
                    [self setNaviMiddleTitle];
                    [self.m_tableView reloadData];
                }); 
            
            });
            

            //check if show order coach
            Http *req=[[Http alloc] init];
            req.socialMethord=@"grab/checkValidOrder.yo";
            [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
            [self showLoadingWithBG];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    if ([[req.m_data objectForKey:@"status"] integerValue]==1)
                    {
                        self.btnBG1.hidden=NO;
                        [self.m_tableView setFrame:CGRectMake(PARENT_X(self.m_tableView), PARENT_Y(self.m_tableView), PARENT_WIDTH(self.m_tableView),Screen_Height-64-40)];
                    }
                    else
                    {
                        self.btnBG1.hidden=YES;
                        [self.m_tableView setFrame:CGRectMake(PARENT_X(self.m_tableView), PARENT_Y(self.m_tableView), PARENT_WIDTH(self.m_tableView),Screen_Height-64)];
                    }
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
-(void)setNaviMiddleTitle
{
    self.title=[self.coachData objectForKey:@"coachName"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"CoachDetailVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"CoachDetailVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryShowed.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"-1"])
    {
        CoachDetailCellPhotos *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellPhotos" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        [cell updateViews];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        CoachDetailCell0 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell0" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        [cell updateViews];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        CoachDetailCell1 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell1" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        NSInteger expandedNum=0;
        NSInteger i=0;
        while (i<=indexPath.row)
        {
            if ([[self.m_aryShowed objectAtIndex:i] isEqualToString:@"2"])
            {
                expandedNum++;
            }
            i++;
        }

        cell.data=[self.feeArray objectAtIndex:indexPath.row-2-expandedNum];
        cell.feeIndex=indexPath.row-2-expandedNum;
        [cell updateViews];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"2"])
    {
        CoachDetailCell2 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell2" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        NSInteger expandedNum=0;
        NSInteger i=0;
        while (i<=indexPath.row)
        {
            if ([[self.m_aryShowed objectAtIndex:i] isEqualToString:@"2"])
            {
                expandedNum++;
            }
            i++;
        }
        cell.data=[self.feeArray objectAtIndex:indexPath.row-2-expandedNum];
        [cell updateViews];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"4"])
    {
        CoachDetailCell4 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell4" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        cell.m_aryStudent=self.m_aryStudents;
        [cell updateViews];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"5"])
    {
        CoachDetailCell5 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell5" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        [cell updateViews];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"6"])
    {
        CoachDetailCell6 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell6" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        [cell updateViews];
        return cell;
    }

    else
    {
        return [[UITableViewCell alloc] init];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"-1"])
    {
        if ([(NSArray*)[self.coachData objectForKey:@"imgurls"] count]>0)
        {
            height=210;
        }
        else
        {
            height=0;
        }
        
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        height=110;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        height=40;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"2"])
    {
        height=180;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"4"])
    {
        if (self.m_aryStudents.count<=0)
        {
            height=0;
        }
        else
        {
            height=20+70+(self.m_aryStudents.count-1)/4*70;
            if (height>20+70*3)
            {
                height=20+70*3;
            }
        }
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"5"])
    {
        if ([[self.commentData objectForKey:@"date"] isEqualToString:@""]||![self.commentData objectForKey:@"date"])
        {
            height=0;
        }
        else
        {
            height=60+self.contentHeight+5+60;
        }
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"6"])
    {
        height=260;
    }
    return height;
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
#pragma mark ------ event response
-(void)showLookupMapVC
{
    LookUpMapVC *vc=[[LookUpMapVC alloc] init];
    vc.m_userLocation=(CLLocationCoordinate2D){[[self.spaceData objectForKey:@"lat"] floatValue],[[self.spaceData objectForKey:@"lng"] floatValue]};
    vc.address=[self.spaceData objectForKey:@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showInviteFriendVC
{
//    InviteFriendVC *vc=[[InviteFriendVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self shareInviteCode];
}
-(void)showStudentCenterVC:(NSString*)account
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --------- event response
-(void)shareCoach
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"share/putInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"2",[self.preData objectForKey:@"coachId"],@"1"] forKeys:@[@"account",@"type",@"infoId",@"shareto"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //share
            NSString *imageUrl = [self.coachData objectForKey:@"photourl"];
            
            //构造分享内容
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@，已获得%@次学员点赞，态度好，考试通过快，学车看过来噢～",[self.coachData objectForKey:@"name"],[[self.coachData objectForKey:@"good"] stringValue]]
                                             images:@[imageUrl]
                                                url:[NSURL URLWithString:[req.m_data objectForKey:@"shareurl"]]
                                              title:[NSString stringWithFormat:@"%@，已获得%@次学员点赞，态度好，考试通过快，学车看过来噢～",[self.coachData objectForKey:@"name"],[[self.coachData objectForKey:@"good"] stringValue]]
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
-(void)shareInviteCode
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/shareUserInvitationCode.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"1"] forKeys:@[@"account",@"shareto"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //share
            NSString *imageUrl = [[NSBundle mainBundle] pathForResource:@"icon_inapp2" ofType:@"png"];
            
            //构造分享内容
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@"小伙伴快来一起学车吧，盛情难却，你就从了吧"
                                             images:@[imageUrl]
                                                url:[NSURL URLWithString:[req.m_data objectForKey:@"shareurl"]]
                                              title:@"优车车"
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

-(void)showCommentVC
{
    CommentListVC *vc=[[CommentListVC alloc] init];
    vc.name=[self.coachData objectForKey:@"coachName"];
    vc.school=[self.coachData objectForKey:@"dsname"];
    vc.coachData=self.coachData;
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)ShowSelectSchemeVC:(id)sender
{
    if(self.selectedScheme<0)
    {
        [self showMessage:@"请选择学车方案"];
        return;
    }
    FillStudyInfo *vc=[[FillStudyInfo alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)callThePhone:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"4006909879"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
-(IBAction)showStudyDemandVC:(id)sender
{
    StudyDemandVC *vc=[[StudyDemandVC alloc] init];
    vc.coachID=[NSString stringWithFormat:@"%d",[[self.preData objectForKey:@"coachId"] integerValue]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)bundleCoach
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"coach.user.bind",[[MyFounctions getUserInfo] objectForKey:@"account"],[self.coachData objectForKey:@"id"]] forKeys:@[@"method",@"account",@"coachid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showMessage:@"成功绑定为该教练学员"];
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
#pragma mark ----------- expand operate
-(void)feeExpandBtnPressed:(NSInteger)feeIndex expend:(NSString*)expended
{
    [self.expendedArray replaceObjectAtIndex:feeIndex withObject:expended];
    NSInteger currentFeeIndex=-1;
    NSInteger i=0;
    while (i<self.m_aryShowed.count)
    {
        if ([[self.m_aryShowed objectAtIndex:i] isEqualToString:@"1"])
        {
            currentFeeIndex++;
            if (feeIndex==currentFeeIndex)
            {
                break;
            }
        }
        i++;
    }
    NSLog(@"i :%d",i);
    [self showPlace:i];
}
#pragma mark -------------- actions
-(void)showPlace:(NSInteger)index
{
    //hide all fee detail
//    NSInteger i=0;
//    NSInteger needHideRowIndex=-1;
//    for (NSString *str in self.m_aryShowed)
//    {
//        if ([str isEqualToString:@"2"])
//        {
//            needHideRowIndex=i-1;
//        }
//        i++;
//    }
//    if (needHideRowIndex>-1)
//    {
//        [self hidePlace:needHideRowIndex];
//        return;
//    }
    
    if (index+1<self.m_aryShowed.count&&[[self.m_aryShowed objectAtIndex:index+1] isEqualToString:@"2"])
    {
        [self hidePlace:index];
    }
    else
    {
        if (index<self.m_aryShowed.count-1)
        {
            [self.m_aryShowed insertObject:@"2" atIndex:index+1];
        }
        else
        {
            [self.m_aryShowed addObject:@"2"];
        }
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:
                                     [NSIndexPath indexPathForRow:index+1 inSection:0],
                                     nil];
        [self.m_tableView beginUpdates];
        [self.m_tableView insertRowsAtIndexPaths:insertIndexPaths
                                withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.m_tableView endUpdates];
    }
    
}
-(void)hidePlace:(NSInteger)index
{
    [self.m_aryShowed removeObjectAtIndex:index+1];
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:
                                 [NSIndexPath indexPathForRow:index+1 inSection:0],
                                 nil];
    [self.m_tableView beginUpdates];
    [self.m_tableView deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.m_tableView endUpdates];
    
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

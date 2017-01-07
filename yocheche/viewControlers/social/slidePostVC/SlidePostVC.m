//
//  SlidePostVC.m
//  yocheche
//
//  Created by carcool on 9/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SlidePostVC.h"
#import "OtherCenterVC.h"
#import "PostDeatilVC.h"
@interface SlidePostVC ()

@end

@implementation SlidePostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"翻牌子";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"searchSex"] isEqual:[NSNull null]])
    {
        self.searchSex=@"0";
    }
    else
    {
        self.searchSex=[[NSUserDefaults standardUserDefaults] stringForKey:@"searchSex"];
    }
    [self creatSearchFriendsView];
    [self createChooseSexView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"SlidePostVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"SlidePostVC"];
}
-(void)creatSearchFriendsView
{
    self.m_searchView=[[[NSBundle mainBundle]loadNibNamed:@"SlideView" owner:nil options:nil] objectAtIndex:0];
    self.m_searchView.delegate=self;
    if (Screen_Height<=480)
    {
        [self.m_searchView setFrame:CGRectMake(0, 5, Screen_Width, 480)];
    }
    else
    {
        [self.m_searchView setFrame:CGRectMake(0, 64, Screen_Width, 480)];
    }
    [self.view addSubview:self.m_searchView];
}
-(void)createChooseSexView
{
    //bg
    self.screenBlackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.screenBlackBG setBackgroundColor:[UIColor darkGrayColor]];
    [self.screenBlackBG setAlpha:0.4];
    UIButton *btnRemoveSexView=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRemoveSexView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnRemoveSexView addTarget:self action:@selector(removeSexBG) forControlEvents:UIControlEventTouchUpInside];
    [self.screenBlackBG addSubview:btnRemoveSexView];
    
    [self.chooseSexBG setFrame:CGRectMake(10, Screen_Height-30-PARENT_HEIGHT(self.chooseSexBG), PARENT_WIDTH(self.chooseSexBG), PARENT_HEIGHT(self.chooseSexBG))];
    [self.chooseSexBG.layer setCornerRadius:4.0];
    [self.chooseSexBG setClipsToBounds:YES];
    
    [self.btnUnlimited setColor:[UIColor whiteColor]];
    [self.btnUnlimited.titleLabel setTextColor:[UIColor lightGrayColor]];
    [self.btnUnlimited.layer setBorderWidth:0.5];
    [self.btnUnlimited.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.btnBoy setColor:[UIColor whiteColor]];
    [self.btnBoy.titleLabel setTextColor:[UIColor lightGrayColor]];
    [self.btnBoy.layer setBorderWidth:0.5];
    [self.btnBoy.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.btnGirl setColor:[UIColor whiteColor]];
    [self.btnGirl.titleLabel setTextColor:[UIColor lightGrayColor]];
    [self.btnGirl.layer setBorderWidth:0.5];
    [self.btnGirl.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    NSLog(@"self.searchSex :%@",self.searchSex);
    if ([self.searchSex integerValue]==0)
    {
        [self.btnUnlimited setColor:YCC_Green];
        [self.btnUnlimited setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if ([self.searchSex integerValue]==1)
    {
        [self.btnBoy setColor:YCC_Green];
        [self.btnBoy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if ([self.searchSex integerValue]==2)
    {
        [self.btnGirl setColor:YCC_Green];
        [self.btnGirl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if ([self.searchSex isEqual:[NSNull null]]||!self.searchSex||[self.searchSex isEqualToString:@""])
    {
        [self.btnUnlimited setColor:YCC_Green];
        [self.btnUnlimited setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"searchSex"];
    }
}
-(IBAction)chooseSexBtnPressed:(id)sender
{
    MyButton *btnSex=(MyButton*)sender;
    self.searchSex=[NSString stringWithFormat:@"%d",btnSex.tag];
    [[NSUserDefaults standardUserDefaults] setObject:self.searchSex forKey:@"searchSex"];
    [self removeSexBG];
    
    if (btnSex.tag==0)
    {
        self.m_searchView.imgBoyAndGirl.hidden=NO;
        self.m_searchView.imgBoy.hidden=YES;
        self.m_searchView.imgGirl.hidden=YES;
    }
    else if (btnSex.tag==1)
    {
        self.m_searchView.imgBoyAndGirl.hidden=YES;
        self.m_searchView.imgBoy.hidden=NO;
        self.m_searchView.imgGirl.hidden=YES;
    }
    else if (btnSex.tag==2)
    {
        self.m_searchView.imgBoyAndGirl.hidden=YES;
        self.m_searchView.imgBoy.hidden=YES;
        self.m_searchView.imgGirl.hidden=NO;
    }
    self.m_searchView.currentIndex=0;
    self.m_searchView.showedIndex=0;
    self.m_searchView.pageIndex=1;
    [self.m_searchView.m_aryData removeAllObjects];
    [self.m_searchView.swipeableView discardAllSwipeableViews];
    [self.m_searchView getSomePictures];
    
}
-(void)showChooseSex
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.window addSubview:self.screenBlackBG];
    [appdelegate.window addSubview:self.chooseSexBG];
    
    [self.btnUnlimited setColor:[UIColor whiteColor]];
    [self.btnUnlimited.titleLabel setTextColor:[UIColor lightGrayColor]];
    [self.btnBoy setColor:[UIColor whiteColor]];
    [self.btnBoy.titleLabel setTextColor:[UIColor lightGrayColor]];
    [self.btnGirl setColor:[UIColor whiteColor]];
    [self.btnGirl.titleLabel setTextColor:[UIColor lightGrayColor]];
    if ([self.searchSex integerValue]==0)
    {
        [self.btnUnlimited setColor:YCC_Green];
        [self.btnUnlimited.titleLabel setTextColor:[UIColor whiteColor]];
    }
    else if ([self.searchSex integerValue]==1)
    {
        [self.btnBoy setColor:YCC_Green];
        [self.btnBoy.titleLabel setTextColor:[UIColor whiteColor]];
        [self.btnBoy.titleLabel setTextColor:[UIColor whiteColor]];
    }
    else if ([self.searchSex integerValue]==2)
    {
        [self.btnGirl setColor:YCC_Green];
        [self.btnGirl.titleLabel setTextColor:[UIColor whiteColor]];
        [self.btnGirl.titleLabel setTextColor:[UIColor whiteColor]];
    }

}
-(void)removeSexBG
{
    [self.screenBlackBG removeFromSuperview];
    [self.chooseSexBG removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/////////////////// search friends ///////////////////
-(void)updateSlideViewDataLat:(NSString*)latitude Lng:(NSString*)longitude PageIndex:(NSString*)pageIndex PageSize:(NSString*)pageSize Type:(NSString*)type
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/getNearbyInvitationList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],latitude,longitude,@"600",@"",pageIndex,pageSize,type,[self.searchSex integerValue]==0?@"":self.searchSex] forKeys:@[@"account",@"lat",@"lng",@"imgWidth",@"imgHeight",@"pageindex",@"pagesize",@"type",@"sex"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_searchView.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"invitations"]];
            if (req.m_data.count>0)
            {
                [self.m_searchView.swipeableView loadNextSwipeableViewsIfNeeded];
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

-(void)showSelectSearchSexActionSheet
{
    if (self.m_actionSheet)
    {
        [self.m_actionSheet removeFromSuperview];
        self.m_actionSheet=nil;
    }
    self.m_actionSheet = [[UIActionSheet alloc]
                          initWithTitle:@"搜索对象"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"只看女", @"只看男",@"全部",nil];
    self.m_actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [self.m_actionSheet showInView:self.view];
}
-(void)likePostOperateInvitationId:(NSString*)invitationId type:(NSString*)liketype
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/likeUserInvitation.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],invitationId,liketype] forKeys:@[@"account",@"invitationId",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([liketype integerValue]==1)
            {
                NSLog(@"赞");
            }
            else
            {
                NSLog(@"取消赞");
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
#pragma mark ----------- action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        self.searchSex=@"";
    }
    else if (buttonIndex==1)
    {
        self.searchSex=@"";
    }
    else if (buttonIndex==2)
    {
        self.searchSex=@"";
    }
}

-(void)showOtherCenterVC:(NSDictionary *)preData
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=preData;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showPostVC:(NSDictionary*)preData
{
    PostDeatilVC *vc=[[PostDeatilVC alloc] init];
    vc.preData=preData;
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

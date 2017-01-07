//
//  HomeVC.m
//  yocheche
//
//  Created by carcool on 6/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTabView.h"
#import "SelectProgressVC.h"
#import "WelcomeVC.h"
#import "LocateVC.h"
#import "KnowledgeVC.h"
#import "OrderTrainDriveVC.h"
#import "MyInfoNewVC.h"
#import "ChooseReleaseTypeVC.h"
#import "ZLSwipeableView.h"
#import "OtherCenterVC.h"
#import "PostDeatilVC.h"
#import "PostInfoCell.h"
#import "HotPostListVC.h"
#import "FansListVC.h"
#import "LikeListVC.h"
#import "CommentMyListVC.h"
#import "OfficialNotifyListVC.h"
#import <ShareSDK/ShareSDK.h>
#import "MyInvitesVC.h"
#import "MyMessagesVC.h"
#import "CoachListVC.h"
#import "MyOrderDriveListVC.h"
#import "JPUSHService.h"
#import "MyTrainAndOrderListVC.h"
#import "StudyViewCell.h"
#import "HomeVCCell0.h"
#import "StudyHomeVC.h"
#import "InputInvitationCodeVC.h"
#import "SchoolListVC.h"
#import "ChatViewController.h"
#import "FillStudentInfoVC.h"
#import "StudyManageVC.h"
#import "OrderTrainingVC.h"
#import "WebViewVC.h"
#import "ApplyStudyVC.h"
#import "MyGrabedListVC.h"
#import "PayGuaranteeSuccessVC.h"
#import "StudyDemandVC.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface HomeVC ()

@end

@implementation HomeVC
@synthesize m_scrollView,m_followView,m_searchView,m_hotView,m_studyView,m_profileView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=YES;
//    self.navigationController.delegate=self;
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.isLogged=NO;
    [self creatDrivingTest];
//    [self creatStudyView];
    [self createCityCode];
    [self showWelcomeVC];
    //check version
    [self checkVersion];
    [self showGuideView];
    self.m_aryData=[NSMutableArray array];
    self.m_aryAdversHome=[NSMutableArray array];
    self.m_aryContentHeight=[NSMutableArray array];
    self.m_aryPicHeight=[NSMutableArray array];
    self.m_aryTagHeight=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-49-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];
    
    //creat study info view
    self.infoView.clipsToBounds=YES;
    [self.infoView.layer setCornerRadius:3.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.btnKe2.layer setBorderWidth:1.0];
    [self.btnKe2.layer setBorderColor:[YCC_Green CGColor]];
    [self.btnKe2 setTitleColor:YCC_Green forState:UIControlStateNormal];
    [self.btnKe3.layer setBorderWidth:1.0];
    [self.btnKe3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.btnKe3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
//    [self getAdvertisement];
}
-(void)doLogin
{
    if ([[MyFounctions getUserInfo] objectForKey:@"account"]&&[[MyFounctions getUserInfo] objectForKey:@"password"])
    {
        Http *req=[[Http alloc] init];
        [req setParams:@[@"user.login",[[MyFounctions getUserInfo] objectForKey:@"account"],[[MyFounctions getUserInfo] objectForKey:@"password"]] forKeys:@[@"method",@"account",@"password"]];
        [req startWithBlock:^{
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                NSLog(@"login success.");
                self.isLogged=YES;
                [self getAdvertisement];
                [self getChatInfo];
                [self updateFollowPostPageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
                
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
-(void)getChatInfo
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getChatAccount.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self.refreshFooter endRefreshing];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSMutableDictionary *userInfo=[NSMutableDictionary dictionaryWithDictionary:[MyFounctions getUserInfo]];
            [userInfo setObject:[req.m_data objectForKey:@"chatAccount"] forKey:@"chatAccount"];
            [userInfo setObject:[req.m_data objectForKey:@"nickname"] forKey:@"nickName"];
            [userInfo setObject:[req.m_data objectForKey:@"headImgUrl"] forKey:@"avatar"];
            [MyFounctions saveUserInfo:userInfo];
            
            [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:[[MyFounctions getUserInfo] objectForKey:@"chatAccount"] password:@"111111" withCompletion:^(NSString *username, NSString *password, EMError *error)
            {
                NSLog(@"%@",error);
                if (!error) {
                    NSLog(@"注册成功");
                }
                
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[MyFounctions getUserInfo] objectForKey:@"chatAccount"] password:@"111111" completion:^(NSDictionary *loginInfo, EMError *error)
                {
                    NSLog(@"%@",error);
                    if (!error && loginInfo)
                    {
                        NSLog(@"登陆成功");
                        NSLog(@"%@",loginInfo);
                        //获取数据库中数据
                        [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                    }
                    //update message data
                    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate updateMessageData];
                    //ease push
                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.nickname=[req.m_data objectForKey:@"nickname"];
                    options.displayStyle=ePushNotificationDisplayStyle_simpleBanner;
                    options.noDisturbStatus=ePushNotificationNoDisturbStatusClose;
                    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options completion:^(EMPushNotificationOptions *options, EMError *error) {
                        
                    } onQueue:nil];
                } onQueue:nil];
                
            } onQueue:nil];
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

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController showTabBar];
    self.navigationController.navigationBar.hidden=YES;
    
    if (appdelegate.initialDone==YES)
    {
        [self uploadJPushID];
        //    [self uploadLocation];
        [appdelegate updateLocation];
        if (self.isLogged==NO)
        {
            [self doLogin];
        }
        [MobClick beginLogPageView:@"homeVC"];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"homeVC"];
}
-(void)viewDidAppear:(BOOL)animated
{
//    [self showInputInvitationCodeVC];
}
-(void)uploadJPushID
{
    NSLog(@"[APService registrationID] :%@",[JPUSHService registrationID]);
    if ([[JPUSHService registrationID] isEqualToString:@""]||![[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        return;
    }
    AppDelegate *appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    Http *req=[[Http alloc] init];
    [req setParams:@[@"registrationid.jpush.put",[[MyFounctions getUserInfo] objectForKey:@"account"],[JPUSHService registrationID],appdelegate.isEnterprise==NO?@"":@"1"] forKeys:@[@"method",@"account",@"registrationid",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
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
-(void)uploadLocation
{
    if (![[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        return;
    }
    AppDelegate *appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    if(appdelegate.m_currentLocation.latitude>0)
    {
        Http *req=[[Http alloc] init];
        req.socialMethord=@"user/putUserLocation.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude]] forKeys:@[@"account",@"lng",@"lat"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
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

-(void)viewDidDisappear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1+self.m_aryData.count*5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        HomeVCCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeVCCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeVCCell0" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        [cell updateView];
        return cell;
    }
    else
    {
        NSInteger index=indexPath.row-1;
        if (index%5==0)
        {
            PostNameCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostNameCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostNameCell" owner:nil options:nil] objectAtIndex:0];
                cell.vcDelegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:index/5];
            [cell updateView];
            return cell;
        }
        else if (index%5==1)
        {
            PostContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostContentCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostContentCell" owner:nil options:nil] objectAtIndex:0];
                //                cell.delegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:index/5];
            [cell updateView];
            return cell;
        }
        else if (index%5==2)
        {
            if ([[[self.m_aryData objectAtIndex:index/5] objectForKey:@"skipUrl"] isEqualToString:@""])//picture or pure text
            {
                PostPicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostPicCell"];
                if (cell==nil)
                {
                    cell=[[[NSBundle mainBundle] loadNibNamed:@"PostPicCell" owner:nil options:nil] objectAtIndex:0];
                    cell.imgDelegate=self;
                }
                cell.data=[self.m_aryData objectAtIndex:index/5];
                [cell updateView];
                return cell;
            }
            else//article
            {
                PostArticleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostArticleCell"];
                if (cell==nil)
                {
                    cell=[[[NSBundle mainBundle] loadNibNamed:@"PostArticleCell" owner:nil options:nil] objectAtIndex:0];
                    cell.delegate=self;
                }
                cell.data=[self.m_aryData objectAtIndex:index/5];
                [cell updateView];
                return cell;
            }
        }
        else if (index%5==3)
        {
            PostTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostTagsCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostTagsCell" owner:nil options:nil] objectAtIndex:0];
//                cell.vcDelegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:index/5];
            [cell updateView];
            return cell;
        }
        else
        {
            PostInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostInfoCell" owner:nil options:nil] objectAtIndex:0];
                cell.vcDelegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:index/5];
            [cell updateView];
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=250;
    }
    else
    {
        NSInteger index=indexPath.row-1;
        if (index%5==0)
        {
            height=60;
        }
        else if (index%5==1)
        {
            height=[[self.m_aryContentHeight objectAtIndex:index/5] floatValue];
        }
        else if (index%5==2)
        {
            if ([[[self.m_aryData objectAtIndex:index/5] objectForKey:@"skipUrl"] isEqualToString:@""])//picture or pure text
            {
                height=[[self.m_aryPicHeight objectAtIndex:index/5] floatValue];
            }
            else//article
            {
                height=70;
            }
            
        }
        else if (index%5==3)
        {
            height=[[self.m_aryTagHeight objectAtIndex:index/5] floatValue];
        }
        else
        {
            height=40;
            
        }

    }
    return height += 0.001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0)
    {
        [self showPostVC:[self.m_aryData objectAtIndex:(indexPath.row-1)/5]];

    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma  mark ------ refresh delegate
-(void)headerRefresh
{
    self.pageIndex=1;
    [self updateFollowPostPageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateFollowPostPageindex:[NSString stringWithFormat:@"%d",self.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.pageCount]];
    
}
#pragma mark --------------- welcome pages -----------------
-(void)showGuideView
{
    //guide new
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Myguide",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0]]])
    {
        [self creatPageScrollview];
    }
}
-(void)disappearGuideViews
{
    [self.imagePlayerView removeFromSuperview];
    self.imagePlayerView=nil;
    //save  data
    NSData *mydata=[[NSData alloc] init];
    NSArray *array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString *path = [NSString stringWithFormat:@"%@/Myguide",[array objectAtIndex: 0]];
    [mydata writeToFile:path atomically:NO];
}

-(void)creatPageScrollview
{
    self.m_aryAdvers=[NSMutableArray arrayWithObjects:@"1",@"1",@"1",nil];
    
    self.imagePlayerView=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width, Screen_Height)];
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:self.m_aryAdvers.count delegate:self];
    self.imagePlayerView.scrollInterval = 999.0f;
    self.imagePlayerView.autoScroll=NO;
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
    self.imagePlayerView.pageControl.currentPageIndicatorTintColor = YCC_Green;
    self.imagePlayerView.pageControl.pageIndicatorTintColor = YCC_GrayBG;
    
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.window addSubview:self.imagePlayerView];
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
//    [imageView setWebImageViewWithURL:[NSURL URLWithString:[[self.m_aryAdvers objectAtIndex:index] objectForKey:@"url"]]];
    if (Screen_Height<=480)
    {
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guid%d_960.jpg",index+1]]];
    }
    else
    {
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guid%d_1136.jpg",index+1]]];
    }
    if (index==2)
    {
        UIButton *btnGo=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnGo setBackgroundImage:[UIImage imageNamed:@"goBtn_guide"] forState:UIControlStateNormal];
        [btnGo addTarget:self action:@selector(disappearGuideViews) forControlEvents:UIControlEventTouchUpInside];
        [btnGo setFrame:CGRectMake((Screen_Width-96)/2.0, Screen_Height-30-38, 96, 38)];
        [imageView addSubview:btnGo];
    }
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}

-(void)createCityCode
{
    //citycode
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/citycode",[array objectAtIndex: 0]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [self setCitycodeTextToArray];
    }
}
-(void)setCitycodeTextToArray
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"citycode" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *arr = [content componentsSeparatedByString:@"\n"];
    NSMutableArray *ArrayWithArray=[NSMutableArray array];
    NSMutableArray *arrayWithDictionary=[NSMutableArray array];
    for (NSString *str in arr)
    {
        NSMutableArray *subAry=[NSMutableArray arrayWithArray:[str componentsSeparatedByString:@" "]];
        while (subAry.count>10)
        {
            [subAry removeLastObject];
        }
        [ArrayWithArray addObject:subAry];
    }
    for (NSArray *subAry in ArrayWithArray)
    {
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:subAry forKeys:@[@"code",@"city"]];
        [arrayWithDictionary addObject:dic];
        NSLog(@"%@",[subAry objectAtIndex:0]);
    }
    //save
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/citycode",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:arrayWithDictionary toFile:savePath];
}
-(void)creatDrivingTest
{
    //project 1 科目一
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/pro1",[array objectAtIndex: 0]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [self setTextToArray];
    }
    //project 4 科目四
    NSArray* array2 = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString* savePath2 = [NSString stringWithFormat:@"%@/pro4",[array2 objectAtIndex: 0]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:savePath2])
    {
        [self setTextToArrayPro4];
    }

}
-(void)setTextToArray
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"pro1" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *arr = [content componentsSeparatedByString:@"\r"];
//    NSLog(@"arr :%@",arr);
    NSMutableArray *ArrayWithArray=[NSMutableArray array];
    NSMutableArray *arrayWithDictionary=[NSMutableArray array];
    for (NSString *str in arr)
    {
        NSMutableArray *subAry=[NSMutableArray arrayWithArray:[str componentsSeparatedByString:@","]];
        while (subAry.count>10)
        {
            [subAry removeLastObject];
        }
        [ArrayWithArray addObject:subAry];
    }
    for (NSArray *subAry in ArrayWithArray)
    {
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:subAry forKeys:@[@"index",@"question",@"img",@"a",@"b",@"c",@"d",@"answer",@"type",@"explain"]];
        [arrayWithDictionary addObject:dic];
//        NSLog(@"%@",[subAry objectAtIndex:0]);
    }
    //save
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/pro1",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:arrayWithDictionary toFile:savePath];
    
}
-(void)setTextToArrayPro4
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"pro4" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *arr = [content componentsSeparatedByString:@"\n"];
    NSMutableArray *ArrayWithArray=[NSMutableArray array];
    NSMutableArray *arrayWithDictionary=[NSMutableArray array];
    for (NSString *str in arr)
    {
        NSMutableArray *subAry=[NSMutableArray arrayWithArray:[str componentsSeparatedByString:@","]];
        while (subAry.count>10)
        {
            [subAry removeLastObject];
        }
        [ArrayWithArray addObject:subAry];
    }
    for (NSArray *subAry in ArrayWithArray)
    {
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:subAry forKeys:@[@"index",@"question",@"img",@"a",@"b",@"c",@"d",@"answer",@"type",@"explain"]];
        [arrayWithDictionary addObject:dic];
//        NSLog(@"%@",[subAry objectAtIndex:0]);
    }
    //save
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/pro4",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:arrayWithDictionary toFile:savePath];
    
}

-(void)createScrollView
{
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, Screen_Height-49-20)];
    self.m_scrollView.bounces=NO;
    self.m_scrollView.delegate=self;
    self.m_scrollView.tag=11;
    [m_scrollView setContentSize:CGSizeMake(Screen_Width, Screen_Height-64)];
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.pagingEnabled=YES;
    [m_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.m_scrollView];

}

//social
-(void)creatFollowView
{
    self.m_followView=[[FollowView alloc]
                            initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    self.m_followView.delegate=self;
    [self.m_scrollView addSubview:m_followView];
    if ([[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        [self updateFollowPostPageindex:[NSString stringWithFormat:@"%d",self.m_followView.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.m_followView.pageCount]];
    }
}
-(void)creatHotView
{
    self.m_hotView=[[HotCategoryView alloc]
                       initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    self.m_hotView.delegate=self;
    [self.m_scrollView addSubview:m_hotView];
}

-(void)creatSearchFriendsView
{
    self.m_searchView=[[[NSBundle mainBundle]loadNibNamed:@"SlideView" owner:nil options:nil] objectAtIndex:0];
    self.m_searchView.delegate=self;
    [self.m_searchView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    [self.m_scrollView addSubview:m_searchView];
}
//study driving
-(void)creatStudyView
{
    self.m_studyView=[[StudyView alloc]
                         initWithFrame:CGRectMake(0, 20, Screen_Width, Screen_Height-64)];
    self.m_studyView.delegate=self;
    [self.view addSubview:m_studyView];
}
#pragma mark -------- show others VC
-(void)showWelcomeVC
{
    if (![[MyFounctions getUserInfo] objectForKey:@"account"]||![[MyFounctions getUserInfo] objectForKey:@"password"])
    {
        WelcomeVC *vc=[[WelcomeVC alloc] init];
        [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:NO completion:^{
            
        }];
    }
}
#pragma mark ---------------- system launch api -------------
-(void)checkVersion
{
    Http *req=[[Http alloc] init];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //version
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //build
    //    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    [req setParams:@[@"version.app.get",[[[MyFounctions getUserInfo] objectForKey:@"account"] length]>0?[[MyFounctions getUserInfo] objectForKey:@"account"]:@"",currentVersion,@"ios"] forKeys:@[@"method",@"account",@"versionname",@"platform"]];
    [req startWithBlock:^{
        [self stopLoading];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"versionname"] compare:currentVersion options:NSNumericSearch]==NSOrderedDescending)
            {
                if ([[req.m_data objectForKey:@"isforce"] integerValue]!=1)
                {
                    self.trackUrl=[req.m_data objectForKey:@"downloadpath"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"版本更新" message:[req.m_data objectForKey:@"content"] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"去更新", nil];
                    alert.tag=22;
                    [alert show];
                }
                else//force update
                {
                    self.trackUrl=[req.m_data objectForKey:@"downloadpath"];
                    self.updateContent=[req.m_data objectForKey:@"content"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"版本更新" message:self.updateContent delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                    alert.tag=23;
                    [alert show];
                }
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
-(void)showInputInvitationCodeVC
{
    NSLog(@"account :%@   code :%@",[[MyFounctions getUserInfo] objectForKey:@"account"],[[NSUserDefaults standardUserDefaults] objectForKey:@"inviteVCShowed"]);
    if ([[MyFounctions getUserInfo] objectForKey:@"account"]&&![[NSUserDefaults standardUserDefaults] objectForKey:@"inviteVCShowed"])
    {
        Http *req=[[Http alloc] init];
        req.socialMethord=@"user/getUserIntegral.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
        [req startWithBlock:^{
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if ([[req.m_data objectForKey:@"invitedCode"] isEqualToString:@""])
                {
                    [self performSelectorOnMainThread:@selector(delayShowInputInvitationCodeVC) withObject:nil waitUntilDone:YES];
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
}
-(void)delayShowInputInvitationCodeVC
{
    InputInvitationCodeVC *vc=[[InputInvitationCodeVC alloc] init];
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}
#pragma mark -------------- alert view delegate ----------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==22)//更新
    {
        if (buttonIndex==1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackUrl]];
        }
    }
    else if (alertView.tag==23)//强制更新
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackUrl]];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"版本更新" message:self.updateContent delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
        alert.tag=23;
        [alert show];
    }
}
#pragma mark -------------- social -------------
-(IBAction)showReleasePostVC:(id)sender
{
    ChooseReleaseTypeVC *vc=[[ChooseReleaseTypeVC alloc] init];
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}
/////////////////// update follows' post ///////////////
-(void)getAdvertisement
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"advertising/getIndexAdvertisingList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"640",@""] forKeys:@[@"account",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryAdversHome removeAllObjects];
            self.m_aryAdversHome=[req.m_data objectForKey:@"advertisings"];
            [self.m_tableView reloadData];
            //get my profile view data
            if([[MyFounctions getUserInfo] objectForKey:@"uid"])
            {
                [self updateMyInfo];
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
-(void)updateFollowPostPageindex:(NSString*)Index pageSize:(NSString*)Count
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getUserFocusTaList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],Index,Count,@"600",@""] forKeys:@[@"account",@"pageindex",@"pagesize",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([Index integerValue]==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryContentHeight removeAllObjects];
            [self.m_aryPicHeight removeAllObjects];
            [self.m_aryTagHeight removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"userFocusTas"]];
            for (NSDictionary *postData in self.m_aryData)
            {
                float height=0;
                height=[MyFounctions calculateLabelHeightWithString:[postData objectForKey:@"content"] Width:240 font:[UIFont systemFontOfSize:14]]+10;
                if ([[postData objectForKey:@"content"] isEqualToString:@""])
                {
                    height=0;
                }
                [self.m_aryContentHeight addObject:[NSString stringWithFormat:@"%f",height]];
                
                //picture height
                height=0;
                if ([[postData objectForKey:@"height"] integerValue]!=0)
                {
                    if ([[postData objectForKey:@"width"] floatValue]*185.0/[[postData objectForKey:@"height"] floatValue]<=240.0)
                    {
                        height=185;
                    }
                    else
                    {
                        height=[[postData objectForKey:@"height"] floatValue]*240.0/[[postData objectForKey:@"width"] floatValue];
                    }
                }
                [self.m_aryPicHeight addObject:[NSString stringWithFormat:@"%f",height]];
                //tag height
                height=0;
                NSMutableString *tagsContent=[NSMutableString stringWithString:@""];
                for (NSString *tag in [postData objectForKey:@"tags"])
                {
                    [tagsContent appendString:[NSString stringWithFormat:@"#%@ ",tag]];
                }
                float contentHeight=[MyFounctions calculateLabelHeightWithString:tagsContent Width:240 font:[UIFont systemFontOfSize:14]];
                if ([(NSArray*)[postData objectForKey:@"tags"] count]<1)
                {
                    height=0;
                }
                else
                {
                    height=contentHeight+10;
                }
                [self.m_aryTagHeight addObject:[NSString stringWithFormat:@"%f",height]];
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
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
        
    }];

}
/////////////////// search friends ///////////////////
-(void)updateSlideViewDataLat:(NSString*)latitude Lng:(NSString*)longitude PageIndex:(NSString*)pageIndex PageSize:(NSString*)pageSize
{
//    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/getNearbyInvitationList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],latitude,longitude,@"600",@"600",pageIndex,pageSize] forKeys:@[@"account",@"lat",@"lng",@"imgWidth",@"imgHeight",@"pageindex",@"pagesize"]];
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

#pragma mark ------- event response ------- study driving
-(void)showApplyStudyVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    StudyDemandVC *vc=[[StudyDemandVC alloc] init];
    vc.coachID=@"";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyGrabedListVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    MyGrabedListVC *vc=[[MyGrabedListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)checkToApplyOrApplyedStatus
{
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
                [self showApplyStudyVC];
            }
            else if ([[req.m_data objectForKey:@"status"] integerValue]==2)
            {
                [self showMyGrabedListVC];
            }
            else if ([[req.m_data objectForKey:@"status"] integerValue]==3)
            {
                AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.tabBarController hideTabBar];
                self.navigationController.navigationBar.hidden=NO;
                
                PayGuaranteeSuccessVC *vc=[[PayGuaranteeSuccessVC alloc] init];
                vc.did=[req.m_data objectForKey:@"did"];
                vc.orderNo=[req.m_data objectForKey:@"orderNo"];
                [self.navigationController pushViewController:vc animated:YES];
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
-(void)showSelectProgressVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    SelectProgressVC *vc=[[SelectProgressVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showSchoolListVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    SchoolListVC *vc=[[SchoolListVC alloc] init];
    vc.from=0;//school
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)showCoachListVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    SchoolListVC *vc=[[SchoolListVC alloc] init];
    vc.from=1;//coach
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showKnowledgevc
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    KnowledgeVC *vc=[[KnowledgeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)orderTrainDrive
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    OrderTrainingVC *vc=[[OrderTrainingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showSignInScanVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    EmbedReaderViewController *vc=[[EmbedReaderViewController alloc] init];
    vc.m_delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showStudyManageVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    StudyManageVC *vc=[[StudyManageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showFenqiVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=@"要分期";
    vc.urlStr=@"http://www.yocheche.com:88/aging/index.html";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showOrderExamVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=@"自约考";
    vc.urlStr=@"http://cq.122.gov.cn/";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --------------- my profile new ---------------------
-(void)showMyInvitesVC
{
    MyInvitesVC *vc=[[MyInvitesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyMessagesVC
{
    MyMessagesVC *vc=[[MyMessagesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyinfoVC:(NSDictionary*)predata
{
    MyInfoNewVC *vc=[[MyInfoNewVC alloc] init];
    vc.preData=predata;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --------------- event response --------- my profile
-(void)updateMyInfo
{
    if([[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        Http *req=[[Http alloc] init];
        [req setParams:@[@"info.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                self.m_profileView.data=req.m_data;
                [self.m_profileView.m_tableView reloadData];
                [self uploadJPushID];
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
-(void)showMyFansListVC
{
    FansListVC *vc=[[FansListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showLikeMyListVC
{
    LikeListVC *vc=[[LikeListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showCommentMyListVC
{
    CommentMyListVC *vc=[[CommentMyListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showNotificationVC
{
    OfficialNotifyListVC *vc=[[OfficialNotifyListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---------- scane sign in info ---------
-(void)creatInfoView
{
    [self addBlackBGViewOnKeywindow];
    [self.infoView setFrame:CGRectMake(30, (Screen_Height-PARENT_HEIGHT(self.infoView))/2.0, PARENT_WIDTH(self.infoView), PARENT_HEIGHT(self.infoView))];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.window addSubview:self.infoView];
}
-(void)updateInfoView
{
    [self.avaterCoach setWebImageViewWithURL:[NSURL URLWithString:[self.dataSignIn objectForKey:@"headImgurl"]]];
    if ([[self.dataSignIn objectForKey:@"type"] integerValue]==1)
    {
        self.labelClass.text=@"全科";
        self.selectedClass=2;
        self.btnKe2.hidden=NO;
        self.btnKe3.hidden=NO;
    }
    else if ([[self.dataSignIn objectForKey:@"type"] integerValue]==2)
    {
        self.labelClass.text=@"科目二";
        self.selectedClass=2;
        self.btnKe2.hidden=NO;
        self.btnKe3.hidden=YES;
    }
    else if ([[self.dataSignIn objectForKey:@"type"] integerValue]==3)
    {
        self.labelClass.text=@"科目三";
        self.selectedClass=3;
        self.btnKe2.hidden=YES;
        self.btnKe3.hidden=NO;
    }
    self.labelName.text=[self.dataSignIn objectForKey:@"coachname"];
    self.labelSchool.text=[self.dataSignIn objectForKey:@"dsname"];
    if (self.selectedClass==2)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe2 setTitleColor:YCC_Green forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else if (self.selectedClass==3)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe3 setTitleColor:YCC_Green forState:UIControlStateNormal];
    }
}
#pragma mark -------- info view response ------------
-(IBAction)classBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    self.selectedClass=btn.tag;
    if (self.selectedClass==2)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe2 setTitleColor:YCC_Green forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else if (self.selectedClass==3)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe3 setTitleColor:YCC_Green forState:UIControlStateNormal];
    }
    
}
-(IBAction)doneBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self.infoView removeFromSuperview];
        [self removeBLackBGView];
    }
    else if (btn.tag==1)
    {
        [self.infoView removeFromSuperview];
        [self removeBLackBGView];
        
        Http *req=[[Http alloc] init];
        req.socialMethord=@"sign/checkStudentInfo.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if ([[req.m_data objectForKey:@"status"] integerValue]==1)
                {
                    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.tabBarController hideTabBar];
                    self.navigationController.navigationBar.hidden=NO;
                    
                    FillStudentInfoVC *vc=[[FillStudentInfoVC alloc] init];
                    vc.dataSignIn=[NSDictionary dictionaryWithDictionary:self.dataSignIn];
                    vc.selectedClass=self.selectedClass;
                    vc.coachID=self.coachID;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [self submitSignIn];
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
}
-(void)submitSignIn
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/putSignInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.coachID,[NSString stringWithFormat:@"%d",self.selectedClass]] forKeys:@[@"account",@"coachid",@"teaching_item"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"签到成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate=self;
            [alert show];
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
#pragma mark -------- embeded reader QRCode VC delegate ------
-(void)scaneSuccess:(NSString *)result
{
    self.coachID=result;
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/getCoachInfoById.yo";
    [req setParams:@[result] forKeys:@[@"coachid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.dataSignIn=[NSDictionary dictionaryWithDictionary:req.m_data];
            [self creatInfoView];
            [self updateInfoView];
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
#pragma mark ----------- post name cell protacal ---------
-(void)showOtherCenterVCTappedNameCell:(NSString *)account
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showPostVC:(NSDictionary*)preData
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    PostDeatilVC *vc=[[PostDeatilVC alloc] init];
    vc.preData=preData;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ----------- post pic cell protacal ---------
-(void)showScreenView:(UIImage *)img
{
    if (self.screenBlackBG)
    {
        [self.screenBlackBG removeFromSuperview];
        self.screenBlackBG=nil;
        [self.bigView removeFromSuperview];
        self.bigView=nil;
    }
    
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //bg
    self.screenBlackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.screenBlackBG setBackgroundColor:[UIColor blackColor]];
    [self.screenBlackBG setAlpha:1.0];
    [appdelegate.window addSubview:self.screenBlackBG];
    
    self.bigView=[[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) andImage:img];
    self.bigView.autoresizingMask = (1 << 6) -1;
    [appdelegate.window addSubview:self.bigView];
    
    
    UIButton *btnRemoveSexView=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRemoveSexView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnRemoveSexView addTarget:self action:@selector(removeSexBG) forControlEvents:UIControlEventTouchUpInside];
    [self.bigView addSubview:btnRemoveSexView];
}
-(void)removeSexBG
{
    [self.screenBlackBG removeFromSuperview];
    self.screenBlackBG=nil;
    [self.bigView removeFromSuperview];
    self.bigView=nil;
}
#pragma mark ----------- post article cell protacal -------
-(void)showArticleVC:(NSDictionary *)postdata
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=[postdata objectForKey:@"title"];
    vc.urlStr=[postdata objectForKey:@"skipUrl"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---------- post info cell protacal -------
-(void)likePostOperate:(NSMutableDictionary*)postData postCell:(PostInfoCell*)followCell
{
    [followCell.data setObject:@"0" forKey:@"follow"];//只可连续赞 不可取消
    [self stopLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/likeUserInvitation.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[postData objectForKey:@"invitationId"],[[postData objectForKey:@"follow"] integerValue]==0?@"1":@"0"] forKeys:@[@"account",@"invitationId",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[postData objectForKey:@"follow"] integerValue]==1)//取消赞
            {
                [followCell.data setObject:@"0" forKey:@"follow"];
                [followCell.data setObject:[NSString stringWithFormat:@"%d",[[postData objectForKey:@"heat_count"] integerValue]-1] forKey:@"heat_count"];
            }
            else//赞
            {
                [followCell.data setObject:@"1" forKey:@"follow"];
                [followCell.data setObject:[NSString stringWithFormat:@"%d",[[postData objectForKey:@"heat_count"] integerValue]+1] forKey:@"heat_count"];
            }
            [followCell updateView];
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
-(void)sharePostDetail:(NSDictionary*)invitationData
{
    NSLog(@"invitationData :%@",invitationData);
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/shareUserInvitation.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[invitationData objectForKey:@"invitationId"],@"1"] forKeys:@[@"account",@"invitationId",@"shareto"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //share
            NSString *imageUrl = [invitationData objectForKey:@"imgurl"];
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:[invitationData objectForKey:@"content"]
                                             images:@[imageUrl]
                                                url:[NSURL URLWithString:[req.m_data objectForKey:@"shareurl"]]
                                              title:[[invitationData objectForKey:@"title"] isEqualToString:@""]?[invitationData objectForKey:@"content"]:[invitationData objectForKey:@"title"]
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
-(void)CommentPostDetail:(NSDictionary *)invitationData
{
    [self showPostVC:invitationData];
}
-(void)ChatPostDetail:(NSDictionary *)invitationData
{
    
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:[invitationData objectForKey:@"chatAccount"] conversationType:eConversationTypeChat];
    chatVC.accountMy=[[MyFounctions getUserInfo] objectForKey:@"account"];
    chatVC.accountOther=[invitationData objectForKey:@"account"];
    chatVC.idMy=[[MyFounctions getUserInfo] objectForKey:@"chatAccount"];
    chatVC.idOther=[invitationData objectForKey:@"chatAccount"];
    chatVC.avatarURl=[[MyFounctions getUserInfo] objectForKey:@"avatar"];
    chatVC.avatarURlOther=[invitationData objectForKey:@"userpic"];
    chatVC.nameMy=[[MyFounctions getUserInfo] objectForKey:@"nickName"];
    chatVC.nameOther=[invitationData objectForKey:@"nikename"];
    chatVC.title =chatVC.nameOther;
    [self.navigationController  pushViewController:chatVC animated:YES];
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

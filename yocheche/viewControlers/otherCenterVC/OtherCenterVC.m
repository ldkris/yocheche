//
//  OtherCenterVC.m
//  yocheche
//
//  Created by carcool on 8/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OtherCenterVC.h"
#import "OtherCenterActionCell.h"
#import "OtherCenterTopCell.h"
#import "PostDeatilVC.h"
#import "FansListVC.h"
#import "FollowListVC.h"
#import "MyInfoNewVC.h"
#import "ChatViewController.h"
//post cell
#import "PostNameCell.h"
#import "PostPicCell.h"
#import "WebViewVC.h"
#import "PostInfoCell.h"
#import "PostContentCell.h"
#import "PostTagsCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface OtherCenterVC ()

@end

@implementation OtherCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人主页";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.postType=0;
    self.pageCount=10;
    self.m_aryData=[NSMutableArray array];
    self.m_aryContentHeight=[NSMutableArray array];
    self.m_aryPicHeight=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupFooter];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    [self updateView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"otherCenterVC"];
    self.pageIndex=1;
    [self updateData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"otherCenterVC"];
}
-(void)updateData
{
    [self stopLoadingWithBG];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/userinfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.fromMyCenter==1?[self.preData objectForKey:@"account"]:__BASE64([self.preData objectForKey:@"account"]),@"2"] forKeys:@[@"account",@"otheraccount",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
            if (self.postType==0)
            {
                [self getPostList];
            }
            else if (self.postType==1)
            {
                [self getMyLikePostList];
            }
            
            [self getChatInfo];
            
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
-(void)getPostList
{
    [self stopLoadingWithBG];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/userInvitationList.yo";
    [req setParams:@[self.fromMyCenter==1?[self.preData objectForKey:@"account"]:__BASE64([self.preData objectForKey:@"account"]),[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount],@"600",@""] forKeys:@[@"account",@"pageindex",@"pagesize",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"invitations"]];
            NSLog(@"self.m_aryData :%@",self.m_aryData);
            [self.m_aryContentHeight removeAllObjects];
            [self.m_aryPicHeight removeAllObjects];
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
    }];

}
-(void)getMyLikePostList
{
    [self stopLoadingWithBG];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getMyLikeInvitationList.yo";
    [req setParams:@[self.fromMyCenter==1?[self.preData objectForKey:@"account"]:__BASE64([self.preData objectForKey:@"account"]),[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount],@"600",@""] forKeys:@[@"account",@"pageindex",@"pagesize",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^
    {
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"invitations"]];
            
            [self.m_aryContentHeight removeAllObjects];
            [self.m_aryPicHeight removeAllObjects];
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
    }];
    
}
-(void)getChatInfo
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getChatAccount.yo";
    [req setParams:@[self.fromMyCenter==1?[self.preData objectForKey:@"account"]:__BASE64([self.preData objectForKey:@"account"])] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self.refreshFooter endRefreshing];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.chatInfo=req.m_data;
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
    if ([self.fromMyCenter==1?[self.preData objectForKey:@"account"]:__BASE64([self.preData objectForKey:@"account"]) isEqualToString:[[MyFounctions getUserInfo] objectForKey:@"account"]])
    {
        [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
        self.btn.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.m_aryData.count>0)
    {
        return 1+self.m_aryData.count*5;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        self.picCell=[tableView dequeueReusableCellWithIdentifier:@"OtherCenterTopCell"];
        if (self.picCell==nil)
        {
            self.picCell=[[[NSBundle mainBundle] loadNibNamed:@"OtherCenterTopCell" owner:nil options:nil] objectAtIndex:0];
            self.picCell.delegate=self;
        }
        self.picCell.data=[NSDictionary dictionaryWithDictionary:self.data];
        [self.picCell updateView];
        return self.picCell;
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
        height=200;
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
            NSDictionary *dic=[self.m_aryData objectAtIndex:index/5];
            NSMutableString *tagsContent=[NSMutableString stringWithString:@""];
            for (NSString *tag in [dic objectForKey:@"tags"])
            {
                [tagsContent appendString:[NSString stringWithFormat:@"#%@ ",tag]];
            }
            float contentHeight=[MyFounctions calculateLabelHeightWithString:tagsContent Width:240 font:[UIFont systemFontOfSize:14]];
            if ([(NSArray*)[dic objectForKey:@"tags"] count]<1)
            {
                height=0;
            }
            else
            {
                height=contentHeight+10;
            }
        }
        else
        {
            height=40;
            
        }
    }
    return height+= 0.001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0)
    {
        PostDeatilVC *vc=[[PostDeatilVC alloc] init];
        vc.preData=[self.m_aryData objectAtIndex:(indexPath.row-1)/5];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ------------- show avatar all screen ----------
-(void)createScreenView
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
    //    self.bigImg=[[WebImageViewNormal alloc] init];
    //    [self.bigImg setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
    //    [self.bigImg setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.bigView=[[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) andImage:self.picCell.avatar.image];
    self.bigView.autoresizingMask = (1 << 6) -1;
    [appdelegate.window addSubview:self.bigView];
    
    
    UIButton *btnRemoveSexView=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRemoveSexView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnRemoveSexView addTarget:self action:@selector(removeAvatarBG) forControlEvents:UIControlEventTouchUpInside];
    [self.bigView addSubview:btnRemoveSexView];
    
}
-(void)removeAvatarBG
{
    [self.screenBlackBG removeFromSuperview];
    self.screenBlackBG=nil;
    [self.bigView removeFromSuperview];
    self.bigView=nil;
}
#pragma  mark ------ refresh delegate
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
    
}
#pragma mark -------- otherCenterCell delegate
-(void)showPostVCFromCenter:(NSDictionary*)preData
{
    PostDeatilVC *vc=[[PostDeatilVC alloc] init];
    vc.preData=preData;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---------- event response
-(void)followTheUser
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/focusTa.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.fromMyCenter==1?[self.preData objectForKey:@"account"]:__BASE64([self.preData objectForKey:@"account"]),[[self.data objectForKey:@"follow"] integerValue]==1?@"2":@"1"] forKeys:@[@"account",@"focusAccount",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self updateData];
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
-(void)showEditInfoVC
{
    MyInfoNewVC *vc=[[MyInfoNewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showFollowOtherList
{
    FollowListVC *vc=[[FollowListVC alloc] init];
    vc.account=__BASE64([self.data objectForKey:@"account"]);
    vc.otherAccount=[[MyFounctions getUserInfo] objectForKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showFansList
{
    FansListVC *vc=[[FansListVC alloc] init];
    vc.account=__BASE64([self.data objectForKey:@"account"]);
    vc.otherAccount=[[MyFounctions getUserInfo] objectForKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)chatBtnPressed:(id)sender
{
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:[self.chatInfo objectForKey:@"chatAccount"] conversationType:eConversationTypeChat];
    chatVC.accountMy=[[MyFounctions getUserInfo] objectForKey:@"account"];
    chatVC.accountOther=[self.chatInfo objectForKey:@"account"];
    chatVC.idMy=[[MyFounctions getUserInfo] objectForKey:@"chatAccount"];
    chatVC.idOther=[self.chatInfo objectForKey:@"chatAccount"];
    chatVC.avatarURl=[[MyFounctions getUserInfo] objectForKey:@"avatar"];
    chatVC.avatarURlOther=[self.chatInfo objectForKey:@"headImgUrl"];
    chatVC.nameMy=[[MyFounctions getUserInfo] objectForKey:@"nickName"];
    chatVC.nameOther=[self.chatInfo objectForKey:@"nickname"];
    chatVC.title =chatVC.nameOther;
    
    [self.navigationController  pushViewController:chatVC animated:YES];

}

#pragma mark ----------- post name cell protacal ---------
-(void)showOtherCenterVCTappedNameCell:(NSString *)account
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
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
    
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=[postdata objectForKey:@"title"];
    vc.urlStr=[postdata objectForKey:@"skipUrl"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---------- post info cell delegate
-(void)likePostOperate:(NSMutableDictionary*)postData postCell:(PostInfoCell*)followCell
{
    [followCell.data setObject:@"0" forKey:@"follow"];//只可连续赞 不可取消
    [self stopLoadingWithBG];
    [self showLoadingWithBG];
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
    //    [self showLoadingWithBG];
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
    PostDeatilVC *vc=[[PostDeatilVC alloc] init];
    vc.preData=invitationData;
    [self.navigationController pushViewController:vc animated:YES];
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

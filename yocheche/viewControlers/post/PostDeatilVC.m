//
//  PostVC.m
//  yocheche
//
//  Created by carcool on 8/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostDeatilVC.h"
#import "PostDetailCommentCell.h"
#import "PostNameCell.h"
#import "PostPicCell.h"
#import "PostInfoCell.h"
#import "PostTagsCell.h"
#import "PostContentCell.h"
#import "OtherCenterVC.h"
#import <ShareSDK/ShareSDK.h>
#import "ChatViewController.h"
#import "WebViewVC.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface PostDeatilVC ()

@end

@implementation PostDeatilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"贴子详情";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.pageCount=10;
    self.m_aryData=[NSMutableArray array];
    self.commentType=@"1";
    self.replyNickname=@"";
    self.replyAccount=@"";
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self.CommentBG setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.CommentBG.layer setBorderWidth:0.5];
    [self.CommentBG.layer setBorderColor:[YCC_GrayBG CGColor]];
    [self.view addSubview:self.CommentBG];
    [self.btnComment setColor:YCC_Green];
    [self.commentLineView setBackgroundColor:YCC_TextColor];
    self.textFieldComment.delegate=self;
    self.textFieldComment.returnKeyType=UIReturnKeyDone;
    [self setupFooter];
    [self updateData];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"PsotDetailVC"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangedFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    [MobClick beginLogPageView:@"PsotDetailVC"];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidChangeFrameNotification
                                                  object:nil];
}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSLog(@"userInfo :%@",userInfo);
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.CommentBG setFrame:CGRectMake(0, Screen_Height-40-keyboardRect.size.height, Screen_Width, 40)];
}
- (void)keyboardWillHide:(NSNotification *)aNotification
{
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSLog(@"userInfo :%@",userInfo);
//    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.CommentBG setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
}
-(void)keyboardChangedFrame:(NSNotification *)aNotification
{
    if ([self.textFieldComment isFirstResponder])
    {
        NSDictionary *userInfo = [aNotification userInfo];
        NSLog(@"userInfo :%@",userInfo);
        CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self.CommentBG setFrame:CGRectMake(0, Screen_Height-40-keyboardRect.size.height, Screen_Width, 40)];
    }
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/getInvitationDetail.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.preData objectForKey:@"invitationId"],@"640",@""] forKeys:@[@"account",@"invitationId",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
            [self getCommetList];
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
-(void)getCommetList
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/getInvitationCommentList.yo";
    [req setParams:@[[self.preData objectForKey:@"invitationId"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"invitationId",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"userComments"]];
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
-(void)submitCommentData:(NSString*)comment
{
    if ([self.commentType integerValue]==1)
    {
        self.replyAccount=@"";
        self.replyNickname=@"";
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/commentUserInvitation.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.preData objectForKey:@"invitationId"],comment,self.replyAccount,self.replyNickname,self.commentType] forKeys:@[@"account",@"invitationId",@"content",@"replyAccount",@"replyNickname",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showMessage:@"发表评论成功！"];
            self.pageIndex=1;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark ------ refresh delegate
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
    
}

#pragma mark ----------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField.text isEqualToString:@""])
    {
        textField.placeholder=@"添加评论";
        self.commentType=@"1";
        self.replyNickname=@"";
        self.replyAccount=@"";
    }
    return YES;
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5+self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        PostNameCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostNameCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"PostNameCell" owner:nil options:nil] objectAtIndex:0];
            cell.btnMore.hidden=NO;
            cell.vcDelegate=self;
        }
        cell.data=(NSMutableDictionary*)self.data;
        [cell updateView];
        return cell;
    }
    else if (indexPath.row==1)
    {
        PostContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostContentCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"PostContentCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=(NSMutableDictionary*)self.data;
        [cell updateView];
        return cell;
    }
    else if (indexPath.row==2)
    {
        if([[self.data objectForKey:@"skipUrl"] isEqualToString:@""])//picture or pure text
        {
            self.picCell=[tableView dequeueReusableCellWithIdentifier:@"PostPicCell"];
            if (self.picCell==nil)
            {
                self.picCell=[[[NSBundle mainBundle] loadNibNamed:@"PostPicCell" owner:nil options:nil] objectAtIndex:0];
                self.picCell.detailDelegate=self;
                self.picCell.imgDelegate=self;
            }
            self.picCell.data=(NSMutableDictionary*)self.data;
            [self.picCell updateView];
            return self.picCell;
        }
        else
        {
            PostArticleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostArticleCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"PostArticleCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=(NSMutableDictionary*)self.data;
            [cell updateView];
            return cell;
        }
        
    }
    else if (indexPath.row==3)
    {
        PostTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostTagsCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"PostTagsCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=(NSMutableDictionary*)self.data;
        [cell updateView];
        return cell;
    }
    else if(indexPath.row==4)
    {
        PostInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"PostInfoCell" owner:nil options:nil] objectAtIndex:0];
            cell.vcDelegate=self;
        }
        cell.data=(NSMutableDictionary*)self.data;
        [cell updateView];
        return cell;
        
    }
    else
    {
        PostDetailCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PostDetailCommentCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"PostDetailCommentCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row-5];
        if (indexPath.row-5==self.m_aryData.count-1)
        {
            cell.isLastOne=1;
        }
        else
        {
            cell.isLastOne=0;
        }
        [cell updateView];
        return cell;

    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    
    float textContentHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:240 font:[UIFont systemFontOfSize:14]]+10;
    if ([[self.data objectForKey:@"content"] isEqualToString:@""])
    {
        textContentHeight=0;
    }
    
    NSInteger index=indexPath.row;
    if (index==0)
    {
        height=60;
    }
    else if (index==1)
    {
        height=textContentHeight;
    }
    else if (index==2)
    {
        if ([[self.data objectForKey:@"skipUrl"] isEqualToString:@""])//picture or text
        {
            if ([[self.data objectForKey:@"height"] integerValue]!=0)
            {
                if ([[self.data objectForKey:@"width"] floatValue]*185.0/[[self.data objectForKey:@"height"] floatValue]<=240.0)
                {
                    height=185;
                }
                else
                {
                    height=[[self.data objectForKey:@"height"] floatValue]*240.0/[[self.data objectForKey:@"width"] floatValue];
                }
            }
            else
            {
                height=0;
            }
        }
        else//article
        {
            height=70;
        }
        
    }
    else if (index==3)
    {
        NSDictionary *dic=self.data;
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
    else if (index==4)
    {
        height=40;
    }
    else
    {
        NSString *contentStr=@"";
        NSDictionary *dic=[self.m_aryData objectAtIndex:indexPath.row-5];
        
        if ([[dic objectForKey:@"type"] integerValue]==1)
        {
            contentStr=[dic objectForKey:@"content"];
        }
        else if ([[dic objectForKey:@"type"] integerValue]==2)
        {
            contentStr=[NSString stringWithFormat:@"回复%@:%@",[dic objectForKey:@"replyNickname"],[dic objectForKey:@"content"]];
        }
         float contentHeight=[MyFounctions calculateLabelHeightWithString:contentStr Width:230 font:[UIFont systemFontOfSize:14.0]];
        height=23+contentHeight+15;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row-5>=0)
    {
        self.textFieldComment.placeholder=[NSString stringWithFormat:@"回复%@",[[self.m_aryData objectAtIndex:indexPath.row-5] objectForKey:@"nikename"]];
        self.replyAccount=[[self.m_aryData objectAtIndex:indexPath.row-5] objectForKey:@"account"];
        self.replyNickname=[[self.m_aryData objectAtIndex:indexPath.row-5] objectForKey:@"nikename"];
        self.commentType=@"2";
        [self.textFieldComment becomeFirstResponder];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)showMyActionSheet
{
    if (self.m_actionSheet)
    {
        [self.m_actionSheet removeFromSuperview];
        self.m_actionSheet=nil;
    }
    if([[self.data objectForKey:@"self"] integerValue]==0)//0:self 1:not self
    {
        self.m_actionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"删除帖子",nil];
    }
    else if ([[self.data objectForKey:@"self"] integerValue]==1)
    {
        self.m_actionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"举报不良内容",nil];
    }
    for (id obj in self.m_actionSheet.subviews) {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *btn=(UIButton *)obj;
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        }
    }
    self.m_actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [self.m_actionSheet showInView:self.view];
}
#pragma mark ----------- action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex :%d",buttonIndex);
    if (buttonIndex==0)
    {
        if([[self.data objectForKey:@"self"] integerValue]==0)
        {
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            req.socialMethord=@"invitation/delByInvitationId.yo";
            [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.data objectForKey:@"invitationId"]] forKeys:@[@"account",@"invitationId"]];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    [self showMessage:@"删除帖子成功"];
                    [self popSelfViewContriller];
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
        else if ([[self.data objectForKey:@"self"] integerValue]==1)
        {
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            req.socialMethord=@"report/putReport.yo";
            [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.data objectForKey:@"invitationId"],@"1",@"举报"] forKeys:@[@"account",@"invitationId",@"type",@"content"]];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    [self showMessage:@"举报成功"];
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
}

-(void)showMoreOperationMenuSheet
{
    [self showMyActionSheet];
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
            
            //构造分享内容
            
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
//    PostDeatilVC *vc=[[PostDeatilVC alloc] init];
//    vc.preData=invitationData;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.textFieldComment becomeFirstResponder];
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
#pragma mark -------- event response
-(IBAction)submitComment:(id)sender
{
    [self.textFieldComment resignFirstResponder];
    if (![self.textFieldComment.text isEqualToString:@""])
    {
        [self submitCommentData:self.textFieldComment.text];
    }
    else
    {
        [self showMessage:@"评论不能为空"];
    }
    self.textFieldComment.text=@"";
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

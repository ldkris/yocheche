//
//  InviteFriendVC.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "InviteFriendVC.h"
#import "InviteFriendCell.h"
#import <ShareSDK/ShareSDK.h>
#import "MyInvitesVC.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface InviteFriendVC ()

@end

@implementation InviteFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"邀请好友";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"查看邀请"];
    [self.rightNaviBtn addTarget:self action:@selector(showMyInviteVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self updateData];
}
-(void)showMyInviteVC
{
    MyInvitesVC *vc=[[MyInvitesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"coupon.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
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
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InviteFriendCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"InviteFriendCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=self.data;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 726;
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
#pragma mark --------- event response
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
            [shareParams SSDKSetupShareParamsByText:@"优车车优惠码，史上超低价学车，小伙伴快来一起学车吧"
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

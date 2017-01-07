//
//  WelcomeVC.m
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "WelcomeVC.h"
#import "RegisterVC.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "RegisterNewVC.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
@interface WelcomeVC ()

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.textFieldPhone.delegate=self;
    self.textFieldPassword.delegate=self;
    self.textFieldPassword.secureTextEntry=YES;
    self.textFieldPhone.returnKeyType=UIReturnKeyDone;
    self.textFieldPassword.returnKeyType=UIReturnKeyDone;
    self.labelweixin.hidden=YES;
    self.imgweixin.hidden=YES;
    self.btnweixin.hidden=YES;
    self.labelweibo.hidden=YES;
    self.imgweibo.hidden=YES;
    self.btnweibo.hidden=YES;
//    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
//    {
//        self.labelweixin.hidden=YES;
//        self.imgweixin.hidden=YES;
//        self.btnweixin.hidden=YES;
//    }
//    if (![WeiboSDK isWeiboAppInstalled])
//    {
//        self.labelweibo.hidden=YES;
//        self.imgweibo.hidden=YES;
//        self.btnweibo.hidden=YES;
//    }
    [self checkThirthPartLogin];
    
}
-(void)checkThirthPartLogin
{
    Http *req=[[Http alloc] init];
    [req setParams:@[@"way.login.get"] forKeys:@[@"method"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"open"] integerValue]==1)
            {
                self.labelweixin.hidden=NO;
                self.imgweixin.hidden=NO;
                self.btnweixin.hidden=NO;
                self.labelweibo.hidden=NO;
                self.imgweibo.hidden=NO;
                self.btnweibo.hidden=NO;
            }
            else
            {
                self.labelweixin.hidden=YES;
                self.imgweixin.hidden=YES;
                self.btnweixin.hidden=YES;
                self.labelweibo.hidden=YES;
                self.imgweibo.hidden=YES;
                self.btnweibo.hidden=YES;
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
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doWeixinLogin:) name:@"weixinLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doWeiboLogin:) name:@"weiboLogin" object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------- event response
-(IBAction)loginBtnPressed:(id)sender
{
    if ([self.textFieldPhone.text isEqualToString:@""])
    {
        [self showMessage:@"请输入手机号"];
        return;
    }
    else if ([self.textFieldPassword.text isEqualToString:@""])
    {
        [self showMessage:@"请输入密码"];
        return;
    }
    [self.textFieldPhone resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.login",__BASE64(self.textFieldPhone.text),[MyFounctions md5:self.textFieldPassword.text]] forKeys:@[@"method",@"account",@"password"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(self.textFieldPhone.text),[MyFounctions md5:self.textFieldPassword.text]] forKeys:@[@"account",@"password"]]];
            [self dismissViewControllerAnimated:YES completion:^{
                [MobClick profileSignInWithPUID:__BASE64(self.textFieldPhone.text)];
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
-(IBAction)forgetPassword:(id)sender
{
    RegisterNewVC *vc=[[RegisterNewVC alloc] init];
    vc.delegate=self;
    vc.registerOrForget=1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- event response
-(IBAction)registerBtnPressed:(id)sender
{
    RegisterNewVC *vc=[[RegisterNewVC alloc] init];
    vc.delegate=self;
    vc.registerOrForget=0;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark -------------- weixin login ------------------
-(IBAction)WeixinLogin:(id)sender
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    appdelegate.handleURLtype=11;
    [self sendAuthRequest];
}
-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}
-(void)doWeixinLogin:(NSNotification*)notify
{
    
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"wx/getWxUser.yo";
    [req setParams:@[[notify.userInfo objectForKey:@"code"]] forKeys:@[@"code"]];
    [req startWithBlock:^{
        
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.weixindata=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
            
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            [req setParams:@[@"user.register",__BASE64([self.weixindata objectForKey:@"account"]),[MyFounctions md5:@"111111"],@"2",[self.weixindata objectForKey:@"headurl"],[self.weixindata objectForKey:@"nickname"]] forKeys:@[@"method",@"account",@"password",@"type",@"img",@"nickname"]];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64([self.weixindata objectForKey:@"account"]),[MyFounctions md5:@"111111"]] forKeys:@[@"account",@"password"]]];
                    [self dismissViewControllerAnimated:YES completion:^{
                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                        [MobClick profileSignInWithPUID:__BASE64([self.weixindata objectForKey:@"account"])];
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
#pragma mark -------- weibo ---------------
-(IBAction)SinaLogin:(id)sender
{
//    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    appdelegate.handleURLtype=12;
//    
//    WBAuthorizeRequest *request=[WBAuthorizeRequest request];
//    request.redirectURI=@"http://www.yocheche.com";
//    request.scope=@"all";
//    [WeiboSDK sendRequest:request];
    
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             [self doSinaWeiBoLogin:user];
             
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

-(void)doSinaWeiBoLogin:(SSDKUser *)user{
  //  WeiboUser *user= user;
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.register",__BASE64(user.uid),[MyFounctions md5:@"111111"],@"3",user.icon,user.nickname] forKeys:@[@"method",@"account",@"password",@"type",@"img",@"nickname"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(user.uid),[MyFounctions md5:@"111111"]] forKeys:@[@"account",@"password"]]];
            [self dismissViewControllerAnimated:YES completion:^{
                [MobClick profileSignInWithPUID:__BASE64(user.uid)];
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
-(void)doWeiboLogin:(NSNotification*)notify
{
    WeiboUser *user=[notify.userInfo objectForKey:@"userInfo"];
    
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.register",__BASE64(user.userID),[MyFounctions md5:@"111111"],@"3",user.avatarLargeUrl,user.name] forKeys:@[@"method",@"account",@"password",@"type",@"img",@"nickname"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(user.userID),[MyFounctions md5:@"111111"]] forKeys:@[@"account",@"password"]]];
            [self dismissViewControllerAnimated:YES completion:^{
                [MobClick profileSignInWithPUID:__BASE64(user.userID)];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

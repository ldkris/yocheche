//
//  ComplaintCoachVC.m
//  yocheche
//
//  Created by carcool on 11/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ComplaintCoachVC.h"

@interface ComplaintCoachVC ()

@end

@implementation ComplaintCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我要投诉";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitleWithTwoWords:@"提交"];
    [self.rightNaviBtn addTarget:self action:@selector(submitComplaint) forControlEvents:UIControlEventTouchUpInside];
    
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    
    [self updateData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"ComplaintCoachVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"ComplaintCoachVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"report/getDsComplaintMobile.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"mobile"] isEqualToString:@""])
            {
                self.mobileBG.hidden=YES;
            }
            else
            {
                self.mobileBG.hidden=NO;
                self.mobile=[req.m_data objectForKey:@"mobile"];
                self.labelMobile.text=[NSString stringWithFormat:@"投诉电话：%@",[req.m_data objectForKey:@"mobile"]];
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

#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
            self.textViewContent.text=@"";
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(IBAction)contentBtnPressed:(id)sender
{
    if (![self.textViewContent isFirstResponder])
    {
        [self.textViewContent becomeFirstResponder];
        self.labelContentDefault.hidden=YES;
    }
    else
    {
        [self.textViewContent resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
    }
}
#pragma mark --------- event response ---------------
-(IBAction)callThePhone
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.mobile]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
-(void)submitComplaint
{
    if ([self.textViewContent.text isEqualToString:@""])
    {
        [self showMessage:@"请输入投诉内容"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"report/putUserComplaint.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textViewContent.text] forKeys:@[@"account",@"message"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"投诉成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag=11;
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
#pragma mark -------- alert view delegate -------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self popSelfViewContriller];
    }
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

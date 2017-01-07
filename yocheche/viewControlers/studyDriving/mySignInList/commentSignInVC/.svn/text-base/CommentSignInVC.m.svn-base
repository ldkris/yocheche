//
//  CommentSignInVC.m
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CommentSignInVC.h"

@interface CommentSignInVC ()

@end

@implementation CommentSignInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"评论";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(dismissMySelfVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    self.goodFlag=0;
    [self.imgGood setImage:[UIImage imageNamed:@"goodThumb_off"]];
    [self.btnSubmit setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btnSubmit];
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"CommentSignInVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"CommentSignInVC"];
}
-(void)dismissMySelfVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    float textfiled_y=[textView convertRect:self.view.frame toView:nil].origin.y;
    if (textfiled_y+150>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y-150;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),PARENT_Y(self.view)+_y , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        
        //keyboard back reset view frame
        [self.view setFrame:CGRectMake(PARENT_X(self.view),0, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
        
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
#pragma mark -------- event response -----------
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
-(IBAction)goodBtnPressed:(id)sender
{
    if (self.goodFlag==0)
    {
        self.goodFlag=1;
        [self.imgGood setImage:[UIImage imageNamed:@"goodThumb_on"]];
    }
    else
    {
        self.goodFlag=0;
        [self.imgGood setImage:[UIImage imageNamed:@"goodThumb_off"]];
    }
}
-(IBAction)submitComment:(id)sender
{
    if ([self.textViewContent.text isEqualToString:@""]&&self.goodFlag==0)
    {
        [self showMessage:@"请输入评价内容或给好评"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/putSignComment.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.data objectForKey:@"signid"],self.textViewContent.text,[NSString stringWithFormat:@"%d",self.goodFlag]] forKeys:@[@"account",@"signid",@"content",@"isgood"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"评价成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
        self.delegate.pageIndex=1;
        [self.delegate updateData];
        [self dismissMySelfVC];
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

//
//  CommentVC.m
//  yocheche
//
//  Created by carcool on 8/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CommentVC.h"

@interface CommentVC ()

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我要评价";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(dismissSelfVC) forControlEvents:UIControlEventTouchUpInside];
    self.goodComment=@"";
    [self.imgGood setImage:[UIImage imageNamed:@"goodThumb_off"]];
    self.textViewComment.delegate=self;
    self.textViewComment.returnKeyType=UIReturnKeyDone;
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"CommentVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"CommentVC"];
}
-(void)dismissSelfVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(IBAction)submitComment:(id)sender
{
    if ([self.textViewComment.text isEqualToString:@""]&&[self.goodComment isEqualToString:@""])
    {
        [self showMessage:@"请填写评价或给好评"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"comment.coach.put",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",[[self.coachData objectForKey:@"applyid"] integerValue]],[[self.coachData objectForKey:@"coachid"] stringValue],@"1",self.textViewComment.text,self.goodComment,@"",@"",@""] forKeys:@[@"method",@"account",@"appointid",@"coachid",@"type",@"content",@"commenttype",@"jxsp",@"jxtd",@"cnws"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self dismissSelfVC];
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
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    self.labelTextViewPlaceholder.hidden=YES;
    float textfiled_y=[textView convertRect:self.view.frame toView:nil].origin.y;
    if (textfiled_y+100>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y-100;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),PARENT_Y(self.view)+_y , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        //keyboard back reset view frame
        [self.view setFrame:CGRectMake(PARENT_X(self.view),0, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
        
        if ([self.textViewComment.text isEqualToString:@""])
        {
            self.labelTextViewPlaceholder.text=@"评价教练";
        }
        else
        {
            self.labelTextViewPlaceholder.text=@"";
        }
        self.labelTextViewPlaceholder.hidden=NO;
        
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    
    
    return YES;
}

#pragma mark ------- event response
-(IBAction)textViewBtnPressed:(id)sender
{
    if (self.labelTextViewPlaceholder.hidden==NO)
    {
        self.labelTextViewPlaceholder.hidden=YES;
        [self.textViewComment becomeFirstResponder];
    }
    else
    {
        if ([self.textViewComment.text isEqualToString:@""])
        {
            self.labelTextViewPlaceholder.text=@"评价教练";
        }
        else
        {
            self.labelTextViewPlaceholder.text=@"";
        }
        self.labelTextViewPlaceholder.hidden=NO;
    }
}
-(IBAction)goodBtnPressed:(id)sender
{
    if ([self.goodComment isEqualToString:@""])
    {
        self.goodComment=@"1";
        [self.imgGood setImage:[UIImage imageNamed:@"goodThumb_on"]];
    }
    else
    {
        self.goodComment=@"";
        [self.imgGood setImage:[UIImage imageNamed:@"goodThumb_off"]];
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

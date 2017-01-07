//
//  CancelOrderVC.m
//  yocheche
//
//  Created by carcool on 4/25/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CancelOrderVC.h"

@interface CancelOrderVC ()

@end

@implementation CancelOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"取消订单";
    [self.bg removeFromSuperview];
    [self.bg setBackgroundColor:[UIColor whiteColor]];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.textViewContent setClipsToBounds:YES];
    [self.textViewContent.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [self.textViewContent.layer setBorderWidth:0.5];
    [self.textViewContent.layer setCornerRadius:4.0];
    [self.btn setColor:YCC_Green];
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    
    self.reasonStr=@"";
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
#pragma mark -------- event response --------------
-(IBAction)selectReasonBtnPressed:(id)sender
{
    [self.img1 setImage:[UIImage imageNamed:@"selectScheme_off"]];
    [self.img2 setImage:[UIImage imageNamed:@"selectScheme_off"]];
    [self.img3 setImage:[UIImage imageNamed:@"selectScheme_off"]];
    [self.img4 setImage:[UIImage imageNamed:@"selectScheme_off"]];
    [self.img5 setImage:[UIImage imageNamed:@"selectScheme_off"]];
    [self.img6 setImage:[UIImage imageNamed:@"selectScheme_off"]];
    UIButton *btnReason=(UIButton*)sender;
    switch (btnReason.tag)
    {
        case 0:
            self.reasonStr=@"没弄明白抢单什么意思";
            [self.img1 setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
        case 1:
            self.reasonStr=@"抢单一分钟没有回应";
            [self.img2 setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
        case 2:
            self.reasonStr=@"暂无学车打算";
            [self.img3 setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
        case 3:
            self.reasonStr=@"没有找到合适的驾校";
            [self.img4 setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
        case 4:
            self.reasonStr=@"太远";
            [self.img5 setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
        case 5:
            self.reasonStr=@"太贵";
            [self.img6 setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
            
        default:
            break;
    }
}
-(IBAction)doneBtnPressed:(id)sender
{
    if ([self.reasonStr isEqualToString:@""]&&[self.textViewContent.text isEqualToString:@""])
    {
        [self showMessage:@"请输入取消的理由"];
        return;
    }
    NSString *str=@"";
    if ([self.reasonStr isEqualToString:@""])
    {
        str=self.textViewContent.text;
    }
    else if ([self.textViewContent.text isEqualToString:@""])
    {
        str=self.reasonStr;
    }
    else
    {
        str=[NSString stringWithFormat:@"%@,%@",self.reasonStr,self.textViewContent.text];
    }
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/putCancelOrder.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.did,str] forKeys:@[@"account",@"did",@"reason"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"已取消订单" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
#pragma  mark ---------------- uialert view delegate -----------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
-(IBAction)callBtnPressed:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"4006909879"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
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

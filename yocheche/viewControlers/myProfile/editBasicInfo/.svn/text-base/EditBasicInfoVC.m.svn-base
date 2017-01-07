//
//  EditBasicInfoVC.m
//  yocheche
//
//  Created by carcool on 8/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "EditBasicInfoVC.h"

@interface EditBasicInfoVC ()

@end

@implementation EditBasicInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"编辑个人资料";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(saveAndPopSelf) forControlEvents:UIControlEventTouchUpInside];
    self.textFildAge.delegate=self;
    [self updateViews];
}
-(void)updateViews
{
    if ([[self.delegate.data objectForKey:@"marital"] integerValue]==0)
    {
        self.labelMarry.text=@"保密";
    }
    else if ([[self.delegate.data objectForKey:@"marital"] integerValue]==1)
    {
        self.labelMarry.text=@"已婚";
    }
    else if ([[self.delegate.data objectForKey:@"marital"] integerValue]==2)
    {
        self.labelMarry.text=@"单身";
    }
    if ([[self.delegate.data objectForKey:@"sex"] integerValue]==1)
    {
        self.labelSex.text=@"男";
    }
    else if ([[self.delegate.data objectForKey:@"sex"] integerValue]==2)
    {
        self.labelSex.text=@"女";
    }
    self.textFildAge.text=[self.delegate.data objectForKey:@"age"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveAndPopSelf
{
    [self.delegate.m_tableView reloadData];
    [self popSelfViewContriller];
}
#pragma mark ----------- action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==1)
    {
        if (buttonIndex==0)
        {
            self.labelSex.text=@"男";
        }
        else if (buttonIndex==1)
        {
            self.labelSex.text=@"女";
        }
        [self.delegate.data setObject:[NSString stringWithFormat:@"%d",buttonIndex+1] forKey:@"sex"];
    }
    else if (actionSheet.tag==2)
    {
        if (buttonIndex==0)
        {
            self.labelMarry.text=@"保密";
        }
        else if (buttonIndex==1)
        {
            self.labelMarry.text=@"已婚";
        }
        else if (buttonIndex==2)
        {
            self.labelMarry.text=@"单身";
        }
        [self.delegate.data setObject:[NSString stringWithFormat:@"%d",buttonIndex] forKey:@"marital"];
    }
}

#pragma mark ---------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.delegate.data setObject:textField.text forKey:@"age"];
    return YES;
}
#pragma mark --------- event response
-(IBAction)editSex:(id)sender
{
    if (self.m_actionSheet)
    {
        [self.m_actionSheet removeFromSuperview];
        self.m_actionSheet=nil;
    }
    self.m_actionSheet = [[UIActionSheet alloc]
                          initWithTitle:@"选择性别"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"男", @"女",nil];
    self.m_actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    self.m_actionSheet.tag=1;
    [self.m_actionSheet showInView:self.view];
}
-(IBAction)editMarry:(id)sender
{
    if (self.m_actionSheet)
    {
        [self.m_actionSheet removeFromSuperview];
        self.m_actionSheet=nil;
    }
    self.m_actionSheet = [[UIActionSheet alloc]
                          initWithTitle:@"婚姻状况"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"保密", @"已婚",@"单身",nil];
    self.m_actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    self.m_actionSheet.tag=2;
    [self.m_actionSheet showInView:self.view];
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

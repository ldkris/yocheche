//
//  MyInfoCell.m
//  yocheche
//
//  Created by carcool on 8/11/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInfoCell.h"

@implementation MyInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.textFieldWork.delegate=self;
    self.textFieldCar.delegate=self;
    self.textFieldName.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    NSString *marry=@"";
    if ([[self.data objectForKey:@"marital"] integerValue]==0)
    {
        marry=@"保密";
    }
    else if ([[self.data objectForKey:@"marital"] integerValue]==1)
    {
        marry=@"已婚";
    }
    else
    {
        marry=@"单身";
    }
    
    self.labelAccount.text=[NSString stringWithFormat:@"优车车账号：%@",[self.data objectForKey:@"account"]];
    self.labelBasicInfo.text=[NSString stringWithFormat:@"%@ %@ %@",[[self.data objectForKey:@"sex"] integerValue]==1?@"男":@"女",[self.data objectForKey:@"age"],marry];
    self.textFieldCar.text=[self.data objectForKey:@"mycar"];
    self.textFieldName.text=[self.data objectForKey:@"nickname"];
    self.labelPhone.text=[self.data objectForKey:@"account"];
    self.labelSchool.text=[self.data objectForKey:@"collegename"];
    self.textFieldWork.text=[self.data objectForKey:@"company"];
}
#pragma mark --------- uitextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.delegate.view.userInteractionEnabled=NO;
    float currentFrame=[textField convertRect:self.delegate.view.frame toView:nil].origin.y;//to window frame
    if (currentFrame>Screen_Height-KEYBOARD_HEIGHT)
    {
        float d_y=Screen_Height-KEYBOARD_HEIGHT-currentFrame;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.delegate.view.userInteractionEnabled=YES;
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 0, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    
    [self.delegate.data setObject:self.textFieldName.text forKey:@"nickname"];
    [self.delegate.data setObject:self.textFieldWork.text forKey:@"company"];
    [self.delegate.data setObject:self.textFieldCar.text forKey:@"mycar"];
    return YES;
}
#pragma mark --------- event response
-(IBAction)uploadAvatar:(id)sender
{
    [self.delegate uploadAvatar];
}
-(IBAction)selectSchool:(id)sender
{
    [self.delegate showSelectSchoolVC];
}
-(IBAction)editBasicInfo:(id)sender
{
    [self.delegate showEditBasicInfoVC];
}
-(IBAction)logoutBtnPressed:(id)sender
{
    [MyFounctions removeUserInfo];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.m_homeVC showWelcomeVC];
}
@end

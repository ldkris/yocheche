//
//  FlitrateCoachCell.m
//  yocheche
//
//  Created by carcool on 8/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FlitrateCoachCell.h"

@implementation FlitrateCoachCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    self.textFieldSchool.delegate=self;
    self.textFieldSchool.returnKeyType=UIReturnKeyDone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate.pickerView)
    {
        [self.delegate selectDone];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.delegate.m_filtrateData setObject:textField.text forKey:@"dsname"];
    return YES;
}
-(void)updateViews
{
    self.labelAddress.text=self.delegate.m_currentAddress;
    
    self.textFieldSchool.text=[self.delegate.m_filtrateData objectForKey:@"dsname"];
    self.labelLisenceType.text=[self.delegate.m_aryLicenseType objectAtIndex:[[self.delegate.m_filtrateData objectForKey:@"drivetype"] integerValue]];
    if([[self.delegate.m_filtrateData objectForKey:@"sort"] integerValue]==1)//default
    {
        [self.delegate.m_filtrateData setObject:@"4" forKey:@"sort"];
    }
    self.labelSort.text=[self.delegate.m_arySort objectAtIndex:[[self.delegate.m_filtrateData objectForKey:@"sort"] integerValue]-2];
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag!=1&&btn.tag!=2)
    {
        [self.textFieldSchool resignFirstResponder];
        [self.delegate creatPickerView:btn.tag];
    }
    else if (btn.tag==1)
    {
        [self.delegate showFixLocationVC];
    }
}

@end

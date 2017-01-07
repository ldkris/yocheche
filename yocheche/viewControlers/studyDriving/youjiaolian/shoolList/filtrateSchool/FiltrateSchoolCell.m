//
//  FiltrateSchoolCell.m
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FiltrateSchoolCell.h"

@implementation FiltrateSchoolCell

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
    self.labelSort.text=[self.delegate.m_arySort objectAtIndex:[[self.delegate.m_filtrateData objectForKey:@"orderType"] integerValue]];
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==1)//select sort
    {
        [self.textFieldSchool resignFirstResponder];
        [self.delegate creatPickerView:btn.tag];
    }
    else if (btn.tag==0)
    {
        [self.delegate showFixLocationVC];
    }
}


@end

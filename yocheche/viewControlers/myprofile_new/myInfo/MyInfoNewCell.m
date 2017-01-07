//
//  MyInfoNewCell.m
//  yocheche
//
//  Created by carcool on 9/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInfoNewCell.h"
#import "MyInfoNewVC.h"
@implementation MyInfoNewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    [self.lineView4 setBackgroundColor:YCC_GrayBG];
    [self.lineView5 setBackgroundColor:YCC_GrayBG];
    [self.lineView6 setBackgroundColor:YCC_GrayBG];
    [self.topView.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.topView.layer setBorderWidth:0.5];
    [self.bottomView.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.bottomView.layer setBorderWidth:0.5];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.preData objectForKey:@"userpic"]]];
    self.labelName.text=[self.preData objectForKey:@"nickname"];
    self.labelAge.text=[self.preData objectForKey:@"age"];
    self.labelHoroscope.text=[self.preData objectForKey:@"horoscope"];
    if ([[self.preData objectForKey:@"sex"] integerValue]==1)
    {
        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_on"]];
        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
    else if ([[self.preData objectForKey:@"sex"] integerValue]==2)
    {
        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_off"]];
        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
    self.labelMobile.text=[self.preData objectForKey:@"phone"];
    self.labelMySign.text=[self.preData objectForKey:@"resume"];
    self.labelArea.text=[self.preData objectForKey:@"area"];
    NSArray *aryMarry=[NSArray arrayWithObjects:@"保密",@"已婚",@"单身", nil];
    self.labelMarry.text=[aryMarry objectAtIndex:[[self.preData objectForKey:@"marital"] integerValue]];
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btnEdit=(UIButton*)sender;
    if (btnEdit.tag==0)
    {
        [self.delegate showPickerViewBtnPressed];
    }
    else if (btnEdit.tag==1)
    {
        [self.delegate editNameBtnPressed];
    }
    else if (btnEdit.tag==2)
    {
        [self.delegate editAgeBtnPressed];
    }
    else if (btnEdit.tag==3)
    {
        [self.delegate editHoroscopeBtnPressed];
    }
    else if (btnEdit.tag==4)
    {
        [self.delegate editMobileBtnPressed];
    }
    else if (btnEdit.tag==5)
    {
        [self.delegate editMySignBtnPressed];
    }
    else if (btnEdit.tag==6)
    {
        [self.delegate editAreaBtnPressed];
    }
    else if (btnEdit.tag==7)
    {
        [self.delegate creatPickerViewForMarry];
    }
}
-(IBAction)sexBtnPressed:(id)sender
{
    UIButton *btnEdit=(UIButton*)sender;
    [self.delegate sexBtnPressed:[NSString stringWithFormat:@"%d",btnEdit.tag]];
}
@end

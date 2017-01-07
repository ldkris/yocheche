//
//  StudyViewCell.m
//  yocheche
//
//  Created by carcool on 6/29/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudyViewCell.h"
#import "StudyView.h"
#import "StudyHomeVC.h"
@implementation StudyViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.labelNum setClipsToBounds:YES];
    [self.labelNum.layer setCornerRadius:PARENT_WIDTH(self.labelNum)/2.0];
    self.labelNum.hidden=YES;
    [self.labelSignInNum setClipsToBounds:YES];
    [self.labelSignInNum.layer setCornerRadius:PARENT_WIDTH(self.labelSignInNum)/2.0];
    self.labelSignInNum.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)//优教练
    {
        [self.delegate.delegate showSelectLocateVC];
    }
    else if (btn.tag==1)//优技巧
    {
        [self.delegate.delegate showKnowledgevc];
    }
    else if (btn.tag==2)//优笔试
    {
        [self.delegate.delegate showSelectProgressVC];
    }
    else if (btn.tag==3)//预约练车
    {
        [self.delegate.delegate orderTrainDrive];
    }
    else if (btn.tag==4)//扫描签到
    {
        [self.delegate.delegate scanAndRegister];
    }
}
@end

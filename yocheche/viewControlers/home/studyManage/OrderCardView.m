//
//  OrderCardView.m
//  yocheche
//
//  Created by carcool on 2/1/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderCardView.h"
#import "ManageOrderCell.h"
#import "StudyManageVC.h"
@implementation OrderCardView
-(void)awakeFromNib
{
    [self setClipsToBounds:YES];
    [self.layer setCornerRadius:4.0];
    [self.btnCancel.layer setBorderWidth:0.5];
    [self.btnCancel.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.btnCancel setClipsToBounds:YES];
    [self.btnCancel.layer setCornerRadius:3.0];
    [self setBackgroundColor:YCC_Green];
}
-(void)updateView
{
    self.btnCancel.hidden=NO;
    if ([[self.data objectForKey:@"status"] integerValue]==0)
    {
        self.labelStatus.text=@"待审核";
    }
    else if ([[self.data objectForKey:@"status"] integerValue]==1)
    {
        self.labelStatus.text=@"预约成功";
    }
    else if ([[self.data objectForKey:@"status"] integerValue]==3)
    {
        self.labelStatus.text=@"取消申请审核中";
        self.btnCancel.hidden=YES;
    }
    else if ([[self.data objectForKey:@"status"] integerValue]==5)
    {
        self.labelStatus.text=@"取消申请已拒绝";
    }
    
    self.labelTime.text=[NSString stringWithFormat:@"%@ %@-%@",[self.data objectForKey:@"date"],[self.data objectForKey:@"beginTime"],[self.data objectForKey:@"endTime"]];
    
    self.labelNum.text=[NSString stringWithFormat:@"共%d次预约 %d/%d",[[self.data objectForKey:@"totalNum"] integerValue],[[self.data objectForKey:@"seqNum"] integerValue],[[self.data objectForKey:@"totalNum"] integerValue]];
}
-(IBAction)cancelBtnPressed:(id)sender
{
    [self.manageVCDelegate cancelOrder:[[self.data objectForKey:@"appointId"] stringValue]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

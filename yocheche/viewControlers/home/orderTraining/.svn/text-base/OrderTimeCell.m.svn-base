//
//  OrderTimeCell.m
//  yocheche
//
//  Created by carcool on 2/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTimeCell.h"
#import "OrderTrainingVC.h"
@implementation OrderTimeCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    [self.lineView4 setBackgroundColor:YCC_GrayBG];
    
    self.bottomLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 48, 60, 2)];
    [self.bottomLineView setBackgroundColor:YCC_Green];
    [self.contentBG addSubview:self.bottomLineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if(self.m_aryDays.count>0)
    {
        self.labelDate1.text=[[[self.m_aryDays objectAtIndex:0] objectForKey:@"date"] substringFromIndex:5];
        self.labelDate2.text=[[[self.m_aryDays objectAtIndex:1] objectForKey:@"date"] substringFromIndex:5];
        self.labelDate3.text=[[[self.m_aryDays objectAtIndex:2] objectForKey:@"date"] substringFromIndex:5];
        self.labelDate4.text=[[[self.m_aryDays objectAtIndex:3] objectForKey:@"date"] substringFromIndex:5];
        self.labelDate5.text=[[[self.m_aryDays objectAtIndex:4] objectForKey:@"date"] substringFromIndex:5];
        
        self.labelWeek1.text=[[[self.m_aryDays objectAtIndex:0] objectForKey:@"week"] substringFromIndex:2];
        self.labelWeek2.text=[[[self.m_aryDays objectAtIndex:1] objectForKey:@"week"] substringFromIndex:2];
        self.labelWeek3.text=[[[self.m_aryDays objectAtIndex:2] objectForKey:@"week"] substringFromIndex:2];
        self.labelWeek4.text=[[[self.m_aryDays objectAtIndex:3] objectForKey:@"week"] substringFromIndex:2];
        self.labelWeek5.text=[[[self.m_aryDays objectAtIndex:4] objectForKey:@"week"] substringFromIndex:2];
        
        [self.bottomLineView setFrame:CGRectMake(self.delegate.selectedDay*60, PARENT_Y(self.bottomLineView), PARENT_WIDTH(self.bottomLineView), PARENT_HEIGHT(self.bottomLineView))];
    }
    
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.bottomLineView setFrame:CGRectMake(btn.tag*60, PARENT_Y(self.bottomLineView), PARENT_WIDTH(self.bottomLineView), PARENT_HEIGHT(self.bottomLineView))];
    self.delegate.selectedDay=btn.tag;
    switch (btn.tag)
    {
        case 0:
            self.delegate.m_arySelectedDay=self.delegate.m_aryDay1;
            break;
        case 1:
            self.delegate.m_arySelectedDay=self.delegate.m_aryDay2;
            break;
        case 2:
            self.delegate.m_arySelectedDay=self.delegate.m_aryDay3;
            break;
        case 3:
            self.delegate.m_arySelectedDay=self.delegate.m_aryDay4;
            break;
        case 4:
            self.delegate.m_arySelectedDay=self.delegate.m_aryDay5;
            break;
        default:
            break;
    }
    [self.delegate.m_tableView reloadData];
}
@end

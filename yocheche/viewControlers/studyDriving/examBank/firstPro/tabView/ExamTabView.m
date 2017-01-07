//
//  ExamTabView.m
//  weixueche
//
//  Created by carcool on 12/13/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "ExamTabView.h"

@implementation ExamTabView
@synthesize labelTime,timeBG,labelPage,delegate;
-(void)awakeFromNib
{
    [self.timeBG setClipsToBounds:YES];
    [self.timeBG.layer setCornerRadius:4.0];
    [self.timeBG setBackgroundColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:216/255.0]];
}
-(IBAction)submitBtnPressed:(id)sender
{
    [self.delegate noteSubmitExam];
}
-(IBAction)scrollPage:(id)sender
{
    [self.delegate scrollPage];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

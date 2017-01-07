//
//  SavedTabView.m
//  weixueche
//
//  Created by carcool on 12/13/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "SavedTabView.h"

@implementation SavedTabView
@synthesize labelPage,delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(IBAction)answerBtnPressed:(id)sender
{
    [self.delegate showAllAnswers];
}
-(IBAction)deleteBtnPressed:(id)sender
{
    [self.delegate deleteSavedTest];
}
-(IBAction)settingBtnPressed:(id)sender
{
    [self.delegate setTheSettings];
}
-(IBAction)explainBtnPressed:(id)sender
{
    [self.delegate showExplain];
}
-(IBAction)scrollPage:(id)sender
{
    [self.delegate scrollPage];
}
@end

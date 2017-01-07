//
//  StudentItemView.m
//  yocheche
//
//  Created by carcool on 11/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudentItemView.h"

@implementation StudentItemView
-(void)awakeFromNib
{
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}
-(IBAction)btnPressed:(id)sender
{
    [self.delegate showStudentDetailVC:self.account];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ConversationListNaviView.m
//  yocheche
//
//  Created by carcool on 1/12/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ConversationListNaviView.h"
#import "ConversationListController.h"
@implementation ConversationListNaviView
-(void)awakeFromNib
{
    
}
-(IBAction)releaseBtnPressed:(id)sender
{
    [self.delegate showReleasePostVC];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

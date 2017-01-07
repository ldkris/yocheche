//
//  PostPicCell.m
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostPicCell.h"
#import "PostDeatilVC.h"
@implementation PostPicCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
//    [self.pic setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    
    [self.pic removeFromSuperview];
    self.pic=nil;
    [self.btn removeFromSuperview];
    self.btn=nil;
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;

    if ([[self.data objectForKey:@"height"] integerValue]!=0)
    {
        
        self.pic=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(0, 0, 240, 185)];
        self.pic.userInteractionEnabled=YES;
        if ([[self.data objectForKey:@"height"] integerValue]!=0)
        {
            [self.pic setFrame:CGRectMake(50, 0, [[self.data objectForKey:@"width"] floatValue]*185.0/[[self.data objectForKey:@"height"] floatValue],185)];
            if (self.pic.frame.size.width>240.0)
            {
                [self.pic setFrame:CGRectMake(50, 0, 240.0,[[self.data objectForKey:@"height"] floatValue]*240.0/[[self.data objectForKey:@"width"] floatValue])];
                self.pic.contentMode=UIViewContentModeScaleAspectFit;
            }
        }
        [self.pic setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
        
        self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, PARENT_HEIGHT(self.pic))];
        [self.contentBG setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.contentBG];
        
        [self.contentBG insertSubview:self.pic atIndex:0];
        
        
        
        self.btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        if ([[self.data objectForKey:@"height"] integerValue]!=0)
        {
            [self.btn setFrame:CGRectMake(0, 0, PARENT_WIDTH(self.pic),PARENT_HEIGHT(self.pic))];
            [self.btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.pic addSubview:self.btn];
        }
    }
    
}
-(IBAction)btnPressed:(id)sender
{
    [self.imgDelegate showScreenView:self.pic.image];
}
@end

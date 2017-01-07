//
//  MyGrabedListCell0.m
//  yocheche
//
//  Created by carcool on 3/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "MyGrabedListCell0.h"
#import "SDProgressView.h"
@implementation MyGrabedListCell0

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.labelStatus setClipsToBounds:YES];
    [self.labelStatus.layer setCornerRadius:PARENT_WIDTH(self.labelStatus)/2.0];
    [self.labelStatus.layer setBorderColor:[YCC_Green CGColor]];
    [self.labelStatus.layer setBorderWidth:1.0];
    
    self.loop = [SDLoopProgressView progressView];
    self.loop.frame = CGRectMake(PARENT_X(self.labelStatus),PARENT_Y(self.labelStatus) , PARENT_WIDTH(self.labelStatus), PARENT_HEIGHT(self.labelStatus));
    [self.loop setBackgroundColor:YCC_GrayBG];
    self.loop.progress = 0; // 加载进度，当加载完成后会自动隐藏
    [self addSubview:self.loop];
    
    self.mytimer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressSimulation) userInfo:self repeats:YES];
    
}
-(void)dealloc
{
    [self.mytimer invalidate];
}
- (void)progressSimulation
{
    static CGFloat progress = 0;
    
    if (progress < 1.0) {
        progress += 0.01;
        
        // 循环
        if (progress >= 1.0) progress = 0;
        
        self.loop.progress = progress;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if ([[self.data objectForKey:@"status"] integerValue]==1)
    {
        self.labelStatus.text=@"抢单中";
        self.laeblDescrip.text=[NSString stringWithFormat:@"已通知%d位教练",[[self.data objectForKey:@"totalCoach"] integerValue]];
        
        self.loop.hidden=NO;
    }
    else
    {
        self.labelStatus.text=@"抢单结束";
        self.laeblDescrip.text=[NSString stringWithFormat:@"共有%d位教练符合要求,抢单结束",[(NSArray*)[self.data objectForKey:@"coaches"] count]];
        

        self.loop.hidden=YES;
    }
}
@end

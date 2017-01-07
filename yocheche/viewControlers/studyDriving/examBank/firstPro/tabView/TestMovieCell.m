//
//  TestMovieCell.m
//  weixueche
//
//  Created by carcool on 12/17/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//
//@"http://120.24.214.23:9999/carcool/exam.action?filename=4/40001.mp4"
#import "TestMovieCell.h"

@implementation TestMovieCell
@synthesize moviePlayer;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
}


-(void)setMovieSource:(NSURL*)url
{
    // 设置视频播放器
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    //    self.moviePlayer.movieSourceType=MPMovieSourceTypeStreaming;
    self.moviePlayer.controlStyle=MPMovieControlStyleNone;
    self.moviePlayer.allowsAirPlay = YES;
    self.moviePlayer.repeatMode=MPMovieRepeatModeOne;
    [self.moviePlayer.view setFrame:CGRectMake(0, 0, Screen_Width-20-20, 100)];
    
    
    // 将moviePlayer的视图添加到当前视图中
    [self addSubview:self.moviePlayer.view];
    // 播放完视频之后，MPMoviePlayerController 将发送
    // MPMoviePlayerPlaybackDidFinishNotification 消息
    // 登记该通知，接到该通知后，调用playVideoFinished:方法
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
    [self.moviePlayer play];
}
- (void)playVideoFinished:(NSNotification *)theNotification
{
    // 取消监听
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    // 将视频视图从父视图中删除
    [self.moviePlayer.view removeFromSuperview];
}
-(void)removeMyMoviePlayer
{
    [self.moviePlayer stop];
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer=nil;
}

@end

//
//  StudyView.m
//  yocheche
//
//  Created by carcool on 6/29/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudyView.h"
#import "StudyViewCell.h"
@implementation StudyView
@synthesize m_tableView;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, frame.size.height)];
        [self addSubview:self.m_tableView];
        [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.m_tableView setBackgroundColor:YCC_GrayBG];
        self.m_tableView.dataSource=self;
        self.m_tableView.delegate=self;
    }
    return self;
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.m_cell=[[[NSBundle mainBundle] loadNibNamed:@"StudyViewCell" owner:nil options:nil] objectAtIndex:0];
    self.m_cell.delegate=self;
    return self.m_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

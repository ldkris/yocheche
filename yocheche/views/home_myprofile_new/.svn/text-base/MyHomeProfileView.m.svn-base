//
//  MyHomeProfileView.m
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyHomeProfileView.h"
#import "MyHomeProfileCell.h"
@implementation MyHomeProfileView
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
    MyHomeProfileCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyHomeProfileCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyHomeProfileCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=self.data;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 510;
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

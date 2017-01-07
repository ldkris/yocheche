//
//  WordReleaseVC.m
//  yocheche
//
//  Created by carcool on 1/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "WordReleaseVC.h"
#import "WordReleaseCell.h"
@interface WordReleaseVC ()

@end

@implementation WordReleaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"发布内容";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"发布"];
    [self.rightNaviBtn addTarget:self action:@selector(releaseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryCategoryTags=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateCategoryTags];
}
-(void)updateCategoryTags
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/getClassifyList.yo";
    [req setParams:@[] forKeys:@[]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryCategoryTags removeAllObjects];
            [self.m_aryCategoryTags addObjectsFromArray:[req.m_data objectForKey:@"classifys"]];
            [self.m_tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.m_cell=[tableView dequeueReusableCellWithIdentifier:@"WordReleaseCell"];
    if (self.m_cell==nil)
    {
        self.m_cell=[[[NSBundle mainBundle] loadNibNamed:@"WordReleaseCell" owner:nil options:nil] objectAtIndex:0];
        self.m_cell.delegate=self;
    }
    self.m_cell.m_aryCategoryTags=self.m_aryCategoryTags;
    [self.m_cell updateView];
    return self.m_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
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
#pragma mark ----------- event response ------------
-(void)releaseBtnPressed
{
    [self.m_cell.textViewContent resignFirstResponder];
    [self.m_cell.textViewTag resignFirstResponder];
    if ([self.m_cell.textViewTag.text isEqualToString:@""])
    {
        [self showMessage:@"至少输入一个标签"];
        return;
    }
    if ([self.m_cell.textViewContent.text isEqualToString:@""])
    {
        [self showMessage:@"请输入文字内容"];
        return;
    }
    NSString *alltagStr=self.m_cell.textViewTag.text;
    NSMutableArray *aryAllTags=[NSMutableArray arrayWithArray:[alltagStr componentsSeparatedByString:@"#"]];
    [aryAllTags removeObject:@""];
    [aryAllTags removeObject:@" "];
    NSMutableArray *aryMyTags=[NSMutableArray array];
    NSMutableArray *aryCategoryTags=[NSMutableArray array];
    
    for (NSString *str in aryAllTags)
    {
        BOOL isCategoryTag=NO;
        NSString *categoryID=@"";
        for(NSDictionary *dic in self.m_aryCategoryTags)
        {
            if ([[str stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:[dic objectForKey:@"name"]])
            {
                isCategoryTag=YES;
                categoryID=[dic objectForKey:@"id"];
                break;
            }
        }
        if (isCategoryTag==YES)
        {
            [aryCategoryTags addObject:categoryID];
        }
        else
        {
            [aryMyTags addObject:str];
        }
    }
    
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/postInvitation.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"",[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude],self.m_cell.textViewContent.text,[self jsonStringWithArray:aryCategoryTags],[self jsonStringWithArray:aryMyTags]] forKeys:@[@"account",@"fname",@"lat",@"lng",@"content",@"classifys",@"tags"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];
    
}
-(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    //    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = valueObj;
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    //    [reString appendString:@"]"];
    return reString;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

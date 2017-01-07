//
//  CommentCoachVC.m
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CommentCoachVC.h"
#import "CommentCoachCell.h"
#import "CommentCoachTagCell.h"

@interface CommentCoachVC ()

@end

@implementation CommentCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"评价";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryData=[NSMutableArray array];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateData];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"practice/getPracticeTagList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"tags"]];
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        self.m_commentCell=[tableView dequeueReusableCellWithIdentifier:@"CommentCoachCell"];
        if (self.m_commentCell==nil)
        {
            self.m_commentCell=[[[NSBundle mainBundle] loadNibNamed:@"CommentCoachCell" owner:nil options:nil] objectAtIndex:0];
        }
        return self.m_commentCell;
    }
    else
    {
        self.m_tagCell=[tableView dequeueReusableCellWithIdentifier:@"CommentCoachTagCell"];
        if (self.m_tagCell==nil)
        {
            self.m_tagCell=[[[NSBundle mainBundle] loadNibNamed:@"CommentCoachTagCell" owner:nil options:nil] objectAtIndex:0];
        }
        self.m_tagCell.m_aryData=self.m_aryData;
        [self.m_tagCell updateView];
        return self.m_tagCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 250;
    }
    else
    {
        return 20+(self.m_aryData.count/3+1)*(30+10);
    }
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
#pragma mark -------- event response ------------------
-(IBAction)submitBtnPressed:(id)sender
{
    NSMutableArray *aryTags=[NSMutableArray array];
    for (UIButton *btn in self.m_tagCell.m_aryBtns)
    {
        if ([btn.titleLabel.textColor isEqual:YCC_Green])
        {
            [aryTags addObject:[[[self.m_aryData objectAtIndex:btn.tag] objectForKey:@"tagId"] stringValue]];
        }
    }
    if ([self.m_commentCell.textViewContent.text isEqualToString:@""]&&aryTags.count==0)
    {
        [self showMessage:@"请输入评价内容或快速评价"];
        return;
    }
    NSMutableString *strTags=[NSMutableString stringWithString:@""];
    NSInteger i=0;
    for (NSString *str in aryTags)
    {
        if (i==0)
        {
            [strTags appendString:str];
        }
        else
        {
            [strTags appendString:[NSString stringWithFormat:@",%@",str]];
        }
        i++;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"practice/putPracticeComment.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.orderID,[NSString stringWithFormat:@"%d",self.m_commentCell.starNum],self.m_commentCell.textViewContent.text,strTags] forKeys:@[@"account",@"practiceId",@"star",@"content",@"tags"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"评价成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag=11;
            [alert show];
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self popSelfViewContriller];
    }
}
// 将字典或者数组转化为JSON字符串
- (NSString *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil)
    {
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }
    else
    {
        return nil;
    }
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

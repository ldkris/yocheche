//
//  SchoolDetailVC.m
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolDetailVC.h"
#import "SchoolDetailCellPhoto.h"
#import "SchoolDetailCell0.h"
#import "SchoolDetailCell1.h"
#import "SchoolDetailCell2.h"
#import "SchoolDetailCell3.h"
#import "CoachListSmallAvatarVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface SchoolDetailVC ()

@end

@implementation SchoolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"驾校详情";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnImage:[UIImage imageNamed:@"share_big"]];
    [self.rightNaviBtn addTarget:self action:@selector(shareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.descriptionExpand=0;
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateData];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"ds/getDsDetail.yo";
    [req setParams:@[self.dsid] forKeys:@[@"dsid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
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
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        SchoolDetailCellPhoto *cell=[tableView dequeueReusableCellWithIdentifier:@"SchoolDetailCellPhoto"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SchoolDetailCellPhoto" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    if (indexPath.row==1)
    {
        SchoolDetailCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"SchoolDetailCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SchoolDetailCell0" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    else if(indexPath.row==2)
    {
        SchoolDetailCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"SchoolDetailCell1"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SchoolDetailCell1" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        cell.descriptionExpand=self.descriptionExpand;
        [cell updateView];
        return cell;
    }
    else if(indexPath.row==3)
    {
        SchoolDetailCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"SchoolDetailCell2"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SchoolDetailCell2" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        cell.descriptionExpand=self.descriptionExpand;
        [cell updateView];
        return cell;
    }
    else
    {
        SchoolDetailCell3 *cell=[tableView dequeueReusableCellWithIdentifier:@"SchoolDetailCell3"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SchoolDetailCell3" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        if ([(NSArray*)[self.data objectForKey:@"styleList"] count]>0)
        {
            return 200;
        }
        else
        {
            return 0;
        }
    }
    if (indexPath.row==1)
    {
        return 90;
    }
    else if(indexPath.row==2)
    {
        if (self.descriptionExpand==0)
        {
            return 100;
        }
        else
        {
            float contentHeiht=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"description"] Width:280 font:[UIFont systemFontOfSize:14]];
            return 33+contentHeiht+16;
        }
    }
    else if(indexPath.row==3)
    {
        return 45;
    }
    else
    {
        return 180;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4)
    {
        CoachListSmallAvatarVC *vc=[[CoachListSmallAvatarVC alloc] init];
        vc.dsid=[self.data objectForKey:@"dsid"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==3)
    {
        if (self.descriptionExpand==0)
        {
            self.descriptionExpand=1;
            [self.m_tableView reloadData];
        }
        else
        {
            self.descriptionExpand=0;
            [self.m_tableView reloadData];
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark --------- event response ---------------
-(void)shareBtnPressed
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"share/putInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"1",self.dsid,@"1"] forKeys:@[@"account",@"type",@"infoId",@"shareto"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //share
            NSString *imageUrl = [self.preData objectForKey:@"dspic"];
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@，已累计获得%@次学员点赞，态度好，师资强，学车看过来噢～",[self.preData objectForKey:@"dsname"],[self.preData objectForKey:@"goodNum"]]
                                             images:@[imageUrl]
                                                url:[NSURL URLWithString:[req.m_data objectForKey:@"shareurl"]]
                                              title:[NSString stringWithFormat:@"%@，已累计获得%@次学员点赞，态度好，师资强，学车看过来噢～",[self.preData objectForKey:@"dsname"],[self.preData objectForKey:@"goodNum"]]
                                               type:SSDKContentTypeAuto];
            //2、分享（可以弹出我们的分享菜单和编辑界面）
            [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state) {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               default:
                                   break;
                           }
                       }  
             ];

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

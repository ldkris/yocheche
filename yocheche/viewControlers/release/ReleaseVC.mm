//
//  ReleaseVC.m
//  yocheche
//
//  Created by carcool on 8/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ReleaseVC.h"
#import <QiniuSDK.h>
#import "HomeVC.h"
@interface ReleaseVC ()

@end

@implementation ReleaseVC
@synthesize picker,m_editCtl,obje;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title=@"发布";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"发布"];
//    [self.rightNaviBtn setFrame:CGRectMake(0, 0, 55, 30)];
//    [self.rightNaviBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.rightNaviBtn setBackgroundColor:YCC_Green];
//    [self.rightNaviBtn.layer setCornerRadius:3.0];
    [self.rightNaviBtn addTarget:self action:@selector(releaseBtnpressed:) forControlEvents:UIControlEventTouchUpInside];
    self.haveShowedAlbum=0;
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    self.textViewContent.tag=0;
    self.textViewTag.delegate=self;
    self.textViewTag.returnKeyType=UIReturnKeyDone;
    self.textViewTag.tag=1;
    self.m_aryCategoryTags=[NSMutableArray array];
    [self.labelInput setTextColor:YCC_TextColor];
    
    self.m_currentLocation=(CLLocationCoordinate2D){0.0,0.0};
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    [self updateCategoryTags];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"发贴"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"发贴"];
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
            [self createCategoryTagsView];
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
-(void)createCategoryTagsView
{
    NSInteger i=0;
    while (i<self.m_aryCategoryTags.count)
    {
        UIButton *btnTag=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnTag setFrame:CGRectMake(15+(i%3)*(260/3.0+15), 355+i/3*40, 260.0/3.0, 30)];
        [btnTag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnTag setBackgroundColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1]];
        [btnTag.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        btnTag.tag=i;
        [btnTag setTitle:[NSString stringWithFormat:@"#%@",[[self.m_aryCategoryTags objectAtIndex:i] objectForKey:@"name"]] forState:UIControlStateNormal];
        [btnTag addTarget:self action:@selector(categoryTagBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnTag];
        NSLog(@"btnTag :%@",btnTag);
        i++;
    }
}
#pragma mark ---------- BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //发起反向地理编码检索
    self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    [_locService stopUserLocationService];
    _locService.delegate=nil;
    _locService=nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.haveShowedAlbum==0)
    {
//        [self showPickVC];
        [self addBlackBGView];
        [self.actionSheetBG setFrame:CGRectMake(0, Screen_Height-120, Screen_Width, 120)];
        [self.view addSubview:self.actionSheetBG];
    }
    
}
-(void)dismissMyself
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.delegate)
        {
            [self.delegate updateFollowPostPageindex:@"1" pageSize:@"10"];
            [self.delegate getHotCategoriesLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)cameraOrAlbumBtnPressed:(id)sender
{
    [self removeBLackBGView];
    [self.actionSheetBG removeFromSuperview];
    UIButton *btnAvatar=(UIButton*)sender;
    if (btnAvatar.tag==0)//拍照
    {
        [self showPickVC:0];
    }
    else//相册
    {
        [self showPickVC:1];
    }
}
-(void)showPickVC:(NSInteger)source//0:camera 1:album
{
    self.picker=nil;
    self.picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if (source==0)
    {
        sourcheType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    picker.sourceType = sourcheType;
    picker.delegate = self;
//    picker.allowsEditing = YES;
    self.haveShowedAlbum=1;
    [self presentViewController:picker animated:YES completion:^{
        [self stopLoadingWithBG];
    }];
    
}
#pragma mark ------ uiimagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.dataimg=UIImageJPEGRepresentation(img, 0.5) ;
    [self.imgRelease removeFromSuperview];
    self.imgRelease=nil;
    self.imgRelease=[[UIImageView alloc] initWithImage:[UIImage imageWithData:self.dataimg]];
    float imgWidth=PARENT_WIDTH(self.imgRelease);
    float imgHeight=PARENT_HEIGHT(self.imgRelease);
    float x_=imgWidth/imgHeight;
    if (x_>=80.0/92.0)
    {
        [self.imgRelease setFrame:CGRectMake(10, 20, 80, imgHeight*(80.0/imgWidth))];
    }
    else
    {
        [self.imgRelease setFrame:CGRectMake(10, 20, imgWidth*(92.0/imgHeight), 92.0)];
    }
    [self.topViewBG insertSubview:self.imgRelease aboveSubview:self.bg];
    
    [self.picker dismissViewControllerAnimated:NO completion:^{
    }];
    
    //camera 360
//    self.m_editCtl=nil;
//    {
//        self.obje=[[pg_edit_sdk_controller_object alloc] init];
//        {
//            obje.pCSA_fullImage=[img copy];
//        }
//        m_editCtl=[[pg_edit_sdk_controller alloc] initWithEditObject:obje withDelegate:self];
//    }
//    NSAssert(m_editCtl, @"error");
//    if (m_editCtl)
//    {
//        [self.picker dismissViewControllerAnimated:NO completion:^{
//        }];
//        [self presentViewController:m_editCtl animated:NO completion:^{
//        }];
//    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:NO completion:^{
        [self dismissMyself];
    }];
}
#pragma mark --------------- camera 360 photo edit
-(void)dgPhotoEditingViewControllerDidFinish:(UIViewController *)pController object:(pg_edit_sdk_controller_object *)object
{
    self.dataimg=self.obje.pOutEffectDisplayData;
    [self.imgRelease removeFromSuperview];
    self.imgRelease=nil;
    self.imgRelease=[[UIImageView alloc] initWithImage:[UIImage imageWithData:self.obje.pOutEffectDisplayData]];
    float imgWidth=PARENT_WIDTH(self.imgRelease);
    float imgHeight=PARENT_HEIGHT(self.imgRelease);
    float x_=imgWidth/imgHeight;
    if (x_>=80.0/92.0)
    {
        [self.imgRelease setFrame:CGRectMake(10, 20, 80, imgHeight*(80.0/imgWidth))];
    }
    else
    {
        [self.imgRelease setFrame:CGRectMake(10, 20, imgWidth*(92.0/imgHeight), 92.0)];
    }
    [self.topViewBG insertSubview:self.imgRelease aboveSubview:self.bg];
    [self.m_editCtl dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)dgPhotoEditingViewControllerDidCancel:(UIViewController *)pController withClickSaveButton:(BOOL)isClickSaveBtn
{
    if (isClickSaveBtn==YES)
    {
        self.dataimg=UIImageJPEGRepresentation(self.obje.pCSA_fullImage, 0.5) ;
        [self.imgRelease removeFromSuperview];
        self.imgRelease=nil;
        self.imgRelease=[[UIImageView alloc] initWithImage:[UIImage imageWithData:self.dataimg]];
        float imgWidth=PARENT_WIDTH(self.imgRelease);
        float imgHeight=PARENT_HEIGHT(self.imgRelease);
        float x_=imgWidth/imgHeight;
        if (x_>=80.0/92.0)
        {
            [self.imgRelease setFrame:CGRectMake(10, 20, 80, imgHeight*(80.0/imgWidth))];
        }
        else
        {
            [self.imgRelease setFrame:CGRectMake(10, 20, imgWidth*(92.0/imgHeight), 92.0)];
        }
        [self.topViewBG insertSubview:self.imgRelease aboveSubview:self.bg];
        [self.m_editCtl dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else
    {
        [self.m_editCtl dismissViewControllerAnimated:NO completion:^{
            [self dismissMyself];
        }];
    }
    
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.tag==0)
    {
        self.labelContentDefault.hidden=YES;
    }
    else
    {
        self.labelTagDefault.hidden=YES;
    }
    [self.view setFrame:CGRectMake(PARENT_X(self.view),-100, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        self.view.userInteractionEnabled=YES;
        [self.view setFrame:CGRectMake(PARENT_X(self.view), 0, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
        [textView resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""]||[self.textViewContent.text isEqualToString:@"#"])
        {
            self.labelContentDefault.hidden=NO;
            self.textViewContent.text=@"";
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
        if ([self.textViewTag.text isEqualToString:@""]||[self.textViewTag.text isEqualToString:@"#"])
        {
            self.labelTagDefault.hidden=NO;
            self.textViewTag.text=@"";
        }
        else
        {
            self.labelTagDefault.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
-(IBAction)contentBtnPressed:(id)sender
{
    if (![self.textViewContent isFirstResponder])
    {
        [self.textViewContent becomeFirstResponder];
        self.labelContentDefault.hidden=YES;
    }
    else
    {
        [self.textViewContent resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
    }
}
-(IBAction)tagBtnPressed:(id)sender
{
    if (![self.textViewTag isFirstResponder])
    {
        [self.textViewTag becomeFirstResponder];
        self.labelTagDefault.hidden=YES;
        if ([self.textViewTag.text isEqualToString:@""])
        {
            self.textViewTag.text=@"#";
        }
    }
    else
    {
        [self.textViewTag resignFirstResponder];
        if ([self.textViewTag.text isEqualToString:@""])
        {
            self.labelTagDefault.hidden=NO;
        }
        else
        {
            self.labelTagDefault.hidden=YES;
        }
    }
}
#pragma mark -------- event response
-(IBAction)categoryTagBtnPressed:(id)sender
{
    UIButton *btnTag=(UIButton*)sender;
    NSMutableString *tags=[NSMutableString stringWithString:self.textViewTag.text];
    [tags appendString:[NSString stringWithFormat:@" #%@",[[self.m_aryCategoryTags objectAtIndex:btnTag.tag] objectForKey:@"name"]]];
    self.textViewTag.text=tags;
    self.labelTagDefault.hidden=YES;
}
-(IBAction)showPickerViewBtnPressed:(id)sender
{
    [self addBlackBGView];
    [self.actionSheetBG setFrame:CGRectMake(0, Screen_Height-120, Screen_Width, 120)];
    [self.view addSubview:self.actionSheetBG];
}
-(IBAction)releaseBtnpressed:(id)sender
{
    [self.textViewContent resignFirstResponder];
    [self.textViewTag resignFirstResponder];
    if ([self.textViewTag.text isEqualToString:@""])
    {
        [self showMessage:@"至少输入一个标签"];
        return;
    }
    if (!self.dataimg)
    {
        [self showMessage:@"请上传图片"];
        return;
    }
    NSString *alltagStr=self.textViewTag.text;
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
    
    
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/getUptoken.yo";
    [req setParams:@[@"U1001",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"type",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //upload image
            NSString *token = [req.m_data objectForKey:@"uptoken"];
            NSString *fname=[req.m_data objectForKey:@"fname"];
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            [upManager putData:self.dataimg key:fname token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
            {
                [self showLoadingWithBG];
                Http *req=[[Http alloc] init];
                req.socialMethord=@"invitation/postInvitation.yo";
                [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],fname,[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude],self.textViewContent.text,[self jsonStringWithArray:aryCategoryTags],[self jsonStringWithArray:aryMyTags]] forKeys:@[@"account",@"fname",@"lat",@"lng",@"content",@"classifys",@"tags"]];
                [req startWithBlock:^{
                    [self stopLoadingWithBG];
                    if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                    {
                        [self dismissMyself];
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
                
            } option:nil];
            
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
-(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = valueObj;
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
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

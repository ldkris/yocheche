//
//  EmbedReaderViewController.m
//  snailSwitch
//
//  Created by carcool on 5/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "EmbedReaderViewController.h"
#import "MySignInListVC.h"
@implementation EmbedReaderViewController

@synthesize readerView, resultText,picker;

- (void) cleanup
{
    cameraSim = nil;
    readerView.readerDelegate = nil;
    readerView = nil;
    resultText = nil;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title=@"签到";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"我的签到"];
    [self.rightNaviBtn addTarget:self action:@selector(showMySignInList) forControlEvents:UIControlEventTouchUpInside];
    [self addNotifyLabelAtRightForFourWords];
    NSInteger signNum=[[[NSUserDefaults standardUserDefaults] objectForKey:@"signInNum"] integerValue];
    if (signNum>0)
    {
        self.labelNaviNum.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"signInNum"];
        self.labelNaviNum.hidden=NO;
    }
    else
    {
        self.labelNaviNum.hidden=YES;
    }
    
    [self.readerView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    // the delegate receives decode results
    self.readerView.readerDelegate = self;
    //关闭闪光灯
    self.readerView.torchMode = 0;
    self.readerView.tracksSymbols=YES;
    
    UIImageView *scanView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,568)];
    [scanView setImage:[UIImage imageNamed:@"scan_bg"]];
    [self.readerView addSubview:scanView];
    
    self.scanLine=[[UIImageView alloc] initWithFrame:CGRectMake(74, 93, 173, 4)];
    [self.scanLine setImage:[UIImage imageNamed:@"scan_line"]];
    [self.readerView addSubview:self.scanLine];
    [self showScanLineAnimation];
    
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}
-(void)showScanLineAnimation
{
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.scanLine setFrame:CGRectMake(PARENT_X(self.scanLine), 93+173-4, PARENT_WIDTH(self.scanLine), PARENT_HEIGHT(self.scanLine))];
    } completion:^(BOOL finished) {
        [self.scanLine setFrame:CGRectMake(74, 93, 173, 4)];
        [self showScanLineAnimation];
    }];
}
-(void)showMySignInList
{
    MySignInListVC *vc=[[MySignInListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [readerView start];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"签到扫码页"];
}
- (void) viewWillDisappear: (BOOL) animated
{
    [MobClick endLogPageView:@"签到扫码页"];
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        resultText.text = sym.data;
        break;
    }
    [self.m_delegate scaneSuccess:resultText.text];
    [self.readerView stop];
    [self popSelfViewContriller];
}
#pragma mark ------ uiimagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImage* img = [info objectForKey:UIImagePickerControllerEditedImage];
//    NSData *dataimg = UIImageJPEGRepresentation(img, 1.0);
//    [self.readerView.scanner scanImage:[[ZBarImage alloc] initWithCGImage:[img CGImage]]];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ZBarReaderController* read = [ZBarReaderController new];
    read.readerDelegate = self;
    
    CGImageRef cgImageRef = image.CGImage;
    
    ZBarSymbol* symbol = nil;
    
    NSString *result=@"";
    for(symbol in [read scanImage:cgImageRef])
    {
        NSLog(@"data :%@",symbol.data);
        result=symbol.data;
    }
    if (![result isEqualToString:@""])
    {
        resultText.text = result;
        [self.m_delegate scaneSuccess:resultText.text];
        [self.readerView stop];
        [self popSelfViewContriller];
    }
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// called when no barcode is found in an image selected by the user.
// if retry is NO, the delegate *must* dismiss the controller
- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry
{
    [self showMessage:@"没有识别到条形码或二维码"];
}
#pragma mark --------- event response
-(IBAction)showPickVC
{
    self.picker=nil;
    self.picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.sourceType = sourcheType;
    picker.delegate = self;
    picker.allowsEditing = NO;
    
    [self presentViewController:picker animated:YES completion:^{
        [self stopLoadingWithBG];
    }];
    
}

@end

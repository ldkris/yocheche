//
//  SlideView.h
//  yocheche
//
//  Created by carcool on 7/28/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"
@class SlidePostVC;
@interface SlideView : UIView<ZLSwipeableViewDataSource,
ZLSwipeableViewDelegate,BMKLocationServiceDelegate,CLLocationManagerDelegate>
{
    BMKLocationService *_locService;
}
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property (nonatomic, weak) IBOutlet ZLSwipeableView *swipeableView;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,assign)SlidePostVC *delegate;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)NSInteger showedIndex;
@property(nonatomic,retain)IBOutlet UIButton *btnSex;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageCount;
@property(nonatomic,retain)IBOutlet UIButton *btnLike;
@property(nonatomic,retain)IBOutlet UIButton *btnUnlike;
@property(nonatomic,assign)float y_old;
@property(nonatomic,retain)NSString *type;
@property(nonatomic,retain)IBOutlet UIImageView *imgBoyAndGirl;
@property(nonatomic,retain)IBOutlet UIImageView *imgBoy;
@property(nonatomic,retain)IBOutlet UIImageView *imgGirl;
-(void)getSomePictures;
@end

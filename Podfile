platform :ios, "6.0"
target "yocheche" do

pod 'AFNetworking', '>= 2.4'
pod 'HappyDNS', '>= 0.1'
pod "Qiniu", "~> 7.0"
pod 'EaseMobSDKFull', :git => 'https://github.com/easemob/sdk-ios-cocoapods-integration.git'

 # 主模块(必须)
 pod 'ShareSDK3'
 # Mob 公共库(必须) 如果同时集成SMSSDK iOS2.0:可看此注意事项：http://bbs.mob.com/thread-20051-1-1.html
 pod 'MOBFoundation'
 
 # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
 pod 'ShareSDK3/ShareSDKUI'
 
 # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
 pod 'ShareSDK3/ShareSDKPlatforms/QQ'
 pod 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
 pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
 end

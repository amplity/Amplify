//
//  ProjDef.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/11/16.
//  Copyright © 2015年 hm. All rights reserved.
//

#ifndef ProjDef_h
#define ProjDef_h


#define  AppleAppID    @"924898454"
#define  wxAppID       @"414478124"

#define  SinaID        @"2594660806"
#define  SinaKey       @"38cd99f469ee1181efa19a4fe1c73835"

#define  WeChatID      @"wx42b82fdade8ab3a5"
#define  WeChatSecret  @"06e3f6f4f9e16a488dd7bc367dcdf4f2"


#define QQAppId         @"1105289385"
#define QQAppKey        @"KmkBChfCc99m43ZE"

#define ZfbId          @"zhifubaoPingxxHm"

#define AlipayHK       @"alipayHK";

//#define  PrivateKey    @"makup^2014"
#define  themeEncrypt  @"makeup$2015"

//极光推送
#define JPushAppKey  @"64ff6d7e4bc0aa3599b21f69"
#define JPushChannel  @"AppStore"
#define JPushIsProduction  @"FALSE"


//友盟
#define UMengAppKey  @"575e85ff67e58ebca00029db"
#define UMengChannel  @"App Store"



//美恰
#define MeiQiaAppKey    @"057519e4460b13e3966b155ab43dbace"
#define MeiQiaSecretKey   @"$2a$12$.7raFPGkArCLHzobqwHixeKnXx3UdB/8W5GXhiUrVSVQPSELQ5mz2"





#define MAIN_SCREEN_WITH ([UIScreen mainScreen].bounds.size.width)
#define MAIN_SCREEN_HIGHT ([UIScreen mainScreen].bounds.size.height)


#define TITLEVIEWHIGHT 64

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define kScreen_Frame    (CGRectMake(0, 0 ,MAIN_SCREEN_WITH,MAIN_SCREEN_HIGHT))
#define kUser [NSUserDefaults standardUserDefaults]

#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)

#define DEVICE_IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)

#define DEVICE_IS_IPHONE6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)


#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//color
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]



//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//# define DLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


//cell固定格式 （类名＋identifier）
#define CELL_IDENTIFIER @"identifier"




#endif /* ProjDef_h */

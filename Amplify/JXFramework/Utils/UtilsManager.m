//
//  UtilsManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/19.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "UtilsManager.h"

@implementation UtilsManager

+(instancetype)shareInstance{
    
    static UtilsManager * utilsManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utilsManager = [[UtilsManager alloc] init];
    });
    
    return  utilsManager;
}

//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}


-(void)showFontSystem{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        
        DLog("Family: %s \n", [familyName UTF8String])
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            
            DLog( "\tFont: %s \n", [fontName UTF8String]);
        }
    }
}


-(void)showHoldLanguage{
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    // 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    
    DLog(@"%@",languages);
}

-(NSString*)getCurrentLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    return currentLanguage;
}


-(void)showDoLog:(UIViewController*)fromViewController withLogStr:(NSString*)logStr{
    NSString * classStr = NSStringFromClass([fromViewController class]);
    
    NSString * showErrorStr = [NSString stringWithFormat:@"%@==%@",classStr,logStr];
}



@end

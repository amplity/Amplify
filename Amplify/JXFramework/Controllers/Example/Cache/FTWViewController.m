//
//  FTWViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/24.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "FTWViewController.h"
#import "FTWCache.h"
#import "NSString+MD5.h"


#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface FTWViewController (){
    AVPlayer * player;
}

@end

@implementation FTWViewController

@synthesize imageView, textField, scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    textField.delegate = self;
    scrollView.alwaysBounceVertical = YES;
    [self loadImageFromURL:textField.text];
    
    
    
}

- (void) textFieldDidEndEditing:(UITextField *)aTextField {
    [self loadImageFromURL:textField.text];
}

- (BOOL) textFieldShouldReturn:(UITextField *)aTextField {
    [textField resignFirstResponder];
    return YES;
}

- (void) loadImageFromURL:(NSString*)URL {
    NSURL *imageURL = [NSURL URLWithString:URL];
    NSString *key = [URL MD5Hash];
    NSData *data = [FTWCache objectForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        imageView.image = image;
        [self musicPlayWithName:@""];
    } else {
        imageView.image = [UIImage imageNamed:@"img_def"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            
//            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fffff.mp3" ofType:nil];
//            NSData * data = [NSData dataWithContentsOfFile:filePath];
            
            [FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        });
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//播放音乐方法
- (void) musicPlayWithName:(NSString *)musicName
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"fffff" ofType:@"mp3"];
    NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
    
    player = [[AVPlayer alloc] initWithURL:audioUrl];
    if (!player)
    {
        NSLog(@"fail to play audio :(");
        return;
    }
    
    [player setVolume:1];
    [player play];
}


@end

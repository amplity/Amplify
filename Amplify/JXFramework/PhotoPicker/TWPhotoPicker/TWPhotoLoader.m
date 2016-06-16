//
//  TWImageLoader.m
//  Pods
//
//  Created by Emar on 4/30/15.
//
//

#import "TWPhotoLoader.h"
#import "TWPhotoGroup.h"

@interface TWPhotoLoader ()
@property (strong, nonatomic) NSMutableArray *allPhotos;
@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (readwrite, copy, nonatomic) void(^loadBlock)(NSArray *photos, NSError *error);


//相册组
@property (nonatomic, strong) NSMutableArray * photoGroup;
@property (readwrite, copy, nonatomic) void(^loadGroudBlock)(NSArray *photoGrouds, NSError *error);
@end



@implementation TWPhotoLoader

+ (TWPhotoLoader *)sharedLoader {
    static TWPhotoLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[TWPhotoLoader alloc] init];
    });
    return loader;
}

+ (void)loadAllPhotos:(void (^)(NSArray *photos, NSError *error))completion {

    [[TWPhotoLoader sharedLoader].allPhotos removeAllObjects]; /* added this line to remove assets duplication*/
    [[TWPhotoLoader sharedLoader] setLoadBlock:completion];
    [[TWPhotoLoader sharedLoader] startLoading];
}

+ (void)loadAllPhotos1:(void (^)(NSArray *photoGrouds, NSError *error))completion{
    [[TWPhotoLoader sharedLoader].photoGroup removeAllObjects]; /* added this line to remove assets duplication*/
    [[TWPhotoLoader sharedLoader] setLoadGroudBlock:completion];
    [[TWPhotoLoader sharedLoader] startLoading1];
}

- (void)startLoading {
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            TWPhoto *photo = [TWPhoto new];
            photo.asset = result;
            [self.allPhotos insertObject:photo atIndex:0];
        }
        
    };
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        
        if ([group numberOfAssets] > 0) {
            if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos) {
                [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
            }
        }
        
        if (group == nil) {
            self.loadBlock(self.allPhotos, nil);
        }
        
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:^(NSError *error) {
        self.loadBlock(nil, error);
    }];
}

- (void)startLoading1 {
    
    __block NSInteger groundIndex = 0;
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            TWPhotoGroup * twPhotogroup = [self.photoGroup objectAtIndex:groundIndex];
            TWPhoto *photo = [TWPhoto new];
            photo.asset = result;
            [twPhotogroup.twPhotoArray addObject:photo];
        }
        
    };
    
    
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        
        
        if ([group numberOfAssets] > 0) {
            TWPhotoGroup * twPhotogroup = [[TWPhotoGroup alloc] init];
            twPhotogroup.groupName = [group valueForProperty:ALAssetsGroupPropertyName];
            twPhotogroup.groundIndx = groundIndex;
            
            [self.photoGroup addObject:twPhotogroup];
            [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
            groundIndex++;
        }
        
        if (group == nil) {
            self.loadGroudBlock(self.photoGroup, nil);
        }
        
    };
    
    
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:^(NSError *error) {
        self.loadBlock(nil, error);
    }];
}

- (NSMutableArray *)allPhotos {
    if (_allPhotos == nil) {
        _allPhotos = [NSMutableArray array];
    }
    return _allPhotos;
}

- (ALAssetsLibrary *)assetsLibrary {
    if (_assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

-(NSMutableArray*)photoGroup{
    if (_photoGroup == nil) {
        _photoGroup = [NSMutableArray array];
    }
    
    return _photoGroup;
}

@end

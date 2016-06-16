//
//  TWPhotoPickerController.m
//  InstagramPhotoPicker
//
//  Created by Emar on 12/4/14.
//  Copyright (c) 2014 wenzhaot. All rights reserved.
//

#import "TWPhotoPickerController.h"
#import "TWPhotoCollectionViewCell.h"
#import "TWImageScrollView.h"
#import "TWPhotoLoader.h"
#import "TWPhotoGroup.h"
#import "PhotoVerifyViewController.h"
#import "WishInfoModel.h"
#import "WishService.h"
#import "PhotoListView.h"
#import "PhotoModel.h"


static const NSInteger GDOff = 100;
@interface TWPhotoPickerController ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    CGFloat beginOriginY;
    
    
    //偏移量
    CGFloat originOff;
    
    // 下拉菜单
    UIButton *labelBUtton;
    
    
    //选择相框
    PhotoListView * photoListView;
}
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIImageView *maskView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) TWImageScrollView *imageScrollView;

//@property (strong, nonatomic) NSArray *allPhotos;


@property (nonatomic, strong) NSArray *allPhotoGrouds;

//选中的菜单索引
@property (nonatomic) NSInteger selectedMenuIndex;
@end

@implementation TWPhotoPickerController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.topView];
    [self.view insertSubview:self.collectionView belowSubview:self.topView];
    
    
    [self loadPhotos];
    
    
    if([[[UIDevice
          currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
}



#pragma mark--展示下拉菜单
-(void)showDownList{
    //获得照相机组
    __weak typeof(self)weakSelf=self;
    
    if (!photoListView) {
        NSMutableArray * groupFirstImages = [NSMutableArray array];
        _titleNameArray = [NSMutableArray array];
        
        NSMutableArray * numsArry = [NSMutableArray array];
        for (TWPhotoGroup * twPhotoGroup in _allPhotoGrouds) {
            
            [_titleNameArray addObject:twPhotoGroup.groupName];
            [numsArry addObject:[NSString stringWithFormat:@"%lu",(unsigned long)twPhotoGroup.twPhotoArray.count]];
            TWPhoto * twPhoto = twPhotoGroup.twPhotoArray[1];//0为相机
            [groupFirstImages addObject:twPhoto.thumbnailImage];
        }
        
        
        PhotoModel * photoModel = [[PhotoModel alloc] init];
        
        photoModel.titleNames = _titleNameArray;
        photoModel.nums = numsArry;
        photoModel.images = groupFirstImages;
        
        photoListView=[PhotoListView instancesViewWithBaseModel:photoModel];
        photoListView.baseViewDelegate = self;
        
        [self.view.window addSubview:photoListView];
        
        [_downButton setImage:[UIImage imageNamed:@"twPhotoUP"] forState:UIControlStateNormal];
    }else{
        [photoListView removeFromSuperview];
        photoListView = nil;
        [_downButton setImage:[UIImage imageNamed:@"twPhotoDOWN"] forState:UIControlStateNormal];
    }
    
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    TWPhotoGroup * photoGroup = [self.allPhotoGrouds objectAtIndex:_selectedMenuIndex];
    
    
    return photoGroup.twPhotoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TWPhotoCollectionViewCell";
    
    TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.row==0) {//固定相机
        cell.imageView.image = [UIImage imageNamed:@"wishPhoto"];
    }else{
        TWPhotoGroup * photoGroup = [self.allPhotoGrouds objectAtIndex:_selectedMenuIndex];
        TWPhoto *photo = [photoGroup.twPhotoArray objectAtIndex:indexPath.row];
        cell.imageView.image = photo.thumbnailImage;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {//第一个是照相机
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.view.backgroundColor = [UIColor orangeColor];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
        picker.sourceType = sourcheType;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.showsCameraControls  = YES;
        
        
        [self presentViewController:picker animated:YES completion:nil];
        return;
    }
    TWPhotoGroup * photoGroup = [self.allPhotoGrouds objectAtIndex:_selectedMenuIndex];
    TWPhoto *photo = [photoGroup.twPhotoArray objectAtIndex:indexPath.row];
    [self.imageScrollView displayImage:photo.originalImage];
    if (self.topView.frame.origin.y != 0) {
        [self tapGestureAction:nil];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.y >= 2.0 && self.topView.frame.origin.y == 0) {
        [self tapGestureAction:nil];
    }
}



#pragma mark - event response

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cropAction {
    if (self.cropBlock) {
        self.cropBlock(self.imageScrollView.capture);
    }
    
    
    [self upWishPhoto:self.imageScrollView.capture];
    
//    [self backAction];
}


//上传照片
-(void)upWishPhoto:(UIImage*)image{
    NSString * wishid = self.inputViewData;
    
    
    __weak typeof(self) weakSelf = self;
    [WishService UploadImageForWish:image witWishId:wishid withHandler:^(id responseObj) {
        
        NSDictionary * respenseDic = [responseObj objectAtIndex:0];
        if ([[respenseDic objectForKey:@"code"] isEqualToString:@"00000"]) {
            //上传照片成功后，显示进度
            [WishService upinfo:wishid withHandler:^(id responseObj) {
                WishInfoModel * wishInfoModel = [WishInfoModel mj_objectWithKeyValues:responseObj];
                
                wishInfoModel.isFormPhoto = YES;
                
                if ([wishInfoModel.responseHead.code isEqualToString:@"00000"]) {
                    if (wishInfoModel.responseBody) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            PhotoVerifyViewController * photoVerifyViewController = [[PhotoVerifyViewController alloc] init];
                            photoVerifyViewController.inputViewData = wishInfoModel;
                            
                            
                            [weakSelf.navigationController pushViewController:photoVerifyViewController animated:YES];
                            
//                            [weakSelf presentViewController:photoVerifyViewController animated:YES completion:nil];
                        });
                        
                    }
                }
                
            } withHandler:^(NSError *error) {
                
            }];
        }else{
            
            [JXAlertViewManage showViewWithAlert:@"" withInfo:[respenseDic objectForKey:@"msg"] withStatus:@""];
        }
        
        

    } withHandler:^(NSError *error) {
        
    }];

}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            CGRect topFrame = self.topView.frame;
            CGFloat endOriginY = self.topView.frame.origin.y;
            if (endOriginY > beginOriginY) {
                topFrame.origin.y = (endOriginY - beginOriginY) >= 20 ? 0 : -(CGRectGetHeight(self.topView.bounds)-20-44);
            } else if (endOriginY < beginOriginY) {
                topFrame.origin.y = (beginOriginY - endOriginY) >= 20 ? -(CGRectGetHeight(self.topView.bounds)-20-44) : 0;
            }
            
            CGRect collectionFrame = self.collectionView.frame;
            collectionFrame.origin.y = CGRectGetMaxY(topFrame);
            collectionFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topFrame);
            [UIView animateWithDuration:.3f animations:^{
                self.topView.frame = topFrame;
                self.collectionView.frame = collectionFrame;
            }];
            break;
        }
        case UIGestureRecognizerStateBegan:
        {
            beginOriginY = self.topView.frame.origin.y;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [panGesture translationInView:self.view];
            CGRect topFrame = self.topView.frame;
            topFrame.origin.y = translation.y + beginOriginY;
            
            CGRect collectionFrame = self.collectionView.frame;
            collectionFrame.origin.y = CGRectGetMaxY(topFrame);
            collectionFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topFrame);
            
            if (topFrame.origin.y <= 0 && (topFrame.origin.y >= -(CGRectGetHeight(self.topView.bounds)-20-44))) {
                self.topView.frame = topFrame;
                self.collectionView.frame = collectionFrame;
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture {
    CGRect topFrame = self.topView.frame;
    topFrame.origin.y = topFrame.origin.y == 0 ? -(CGRectGetHeight(self.topView.bounds)-20-44) : 0;
    
    CGRect collectionFrame = self.collectionView.frame;
    collectionFrame.origin.y = CGRectGetMaxY(topFrame);
    collectionFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topFrame);
    [UIView animateWithDuration:.3f animations:^{
        self.topView.frame = topFrame;
        self.collectionView.frame = collectionFrame;
    }];
}



#pragma mark - private methods


/**
 *  加载相机所有图片
 */
- (void)loadPhotos {
    [TWPhotoLoader loadAllPhotos1:^(NSArray *photoGrouds, NSError *error) {
        if (!error) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:photoGrouds];
            NSArray* reversedArray = [[array reverseObjectEnumerator] allObjects];
            _allPhotoGrouds = [NSArray arrayWithArray:reversedArray];
            for (TWPhotoGroup * photoGroup in _allPhotoGrouds) {
                //添加第一个为固定相机
                NSMutableArray * newArray = [[NSMutableArray alloc] init];
                [newArray addObject:@{}];
                NSArray * photoArray = [[photoGroup.twPhotoArray reverseObjectEnumerator] allObjects];
                [newArray addObjectsFromArray:photoArray];
                photoGroup.twPhotoArray = [NSMutableArray arrayWithArray:newArray];
            }
            
            
            [self displaySrcoImageAndTitle];
            [self.collectionView reloadData];
        } else {
            NSLog(@"Load Photos Error: %@", error);
        }
    }];
    
}


/**
 *  设置预览图片和标题
 */
-(void)displaySrcoImageAndTitle{
    TWPhotoGroup * fistPhotoGroup = [_allPhotoGrouds objectAtIndex:_selectedMenuIndex];
    if (fistPhotoGroup.twPhotoArray.count>=2) {
        TWPhoto *firstPhoto = [fistPhotoGroup.twPhotoArray objectAtIndex:1];
        [self.imageScrollView displayImage:firstPhoto.originalImage];
    }
    
    //改变导航栏文字
    [labelBUtton setTitle:fistPhotoGroup.groupName forState:UIControlStateNormal];
}



#pragma mark - getters & setters

- (UIView *)topView {
    if (_topView == nil) {
        CGFloat handleHeight = 64.0f;
        CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds)+handleHeight);
        self.topView = [[UIView alloc] initWithFrame:rect];
        self.topView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        self.topView.backgroundColor = [UIColor clearColor];
        self.topView.clipsToBounds = YES;
        
        rect = CGRectMake(0, 0, CGRectGetWidth(self.topView.bounds), handleHeight);
        UIView *navView = [[UIView alloc] initWithFrame:rect];//26 29 33
        navView.backgroundColor = [[UIColor colorWithRed:37/255 green:37/255 blue:37/255 alpha:1] colorWithAlphaComponent:1.0f];
        [self.topView addSubview:navView];
        
        rect = CGRectMake(0, 0, 60, handleHeight);
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = rect;
//        [backBtn setImage:[UIImage imageNamed:@"back.png"]
//                 forState:UIControlStateNormal];
        [backBtn setTitle:@"X" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:backBtn];
        
        
        
        
        UIView * titleAndImageView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(navView.bounds)/2-200/2, 0, 200, handleHeight)];
        [navView addSubview:titleAndImageView];
        labelBUtton=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(titleAndImageView.bounds)/2-100/2-20, 0, 100, handleHeight)];
        [labelBUtton addTarget:self action:@selector(showDownList) forControlEvents:UIControlEventTouchUpInside];
        [labelBUtton setTitle:@"下拉菜单" forState:UIControlStateNormal];
        [labelBUtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [labelBUtton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleAndImageView addSubview:labelBUtton];
        
        _downButton=[[UIButton alloc]initWithFrame:CGRectMake(labelBUtton.frame.origin.x+CGRectGetMinX(labelBUtton.bounds),20, 120, 22)];
        [_downButton setImage:[UIImage imageNamed:@"twPhotoDOWN"] forState:UIControlStateNormal];
        [_downButton addTarget:self action:@selector(showDownList) forControlEvents:UIControlEventTouchUpInside];
        [titleAndImageView addSubview:_downButton];
        
        
        
        rect = CGRectMake(CGRectGetWidth(navView.bounds)-80, 0, 80, CGRectGetHeight(navView.bounds));
        UIButton *cropBtn = [[UIButton alloc] initWithFrame:rect];
        [cropBtn setTitle:NSLocalizedString(@"nexStep", nil) forState:UIControlStateNormal];
        [cropBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [cropBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cropBtn addTarget:self action:@selector(cropAction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:cropBtn];
        

        
        rect = CGRectMake(0, handleHeight, CGRectGetWidth(self.topView.bounds), CGRectGetHeight(self.topView.bounds)-handleHeight);
        
        
        self.imageScrollView = [[TWImageScrollView alloc] initWithFrame:rect];
        [self.topView addSubview:self.imageScrollView];
        [self.topView sendSubviewToBack:self.imageScrollView];
        
        self.maskView = [[UIImageView alloc] initWithFrame:rect];
        
        self.maskView.image = [UIImage imageNamed:@"straighten-grid"];
        [self.topView insertSubview:self.maskView aboveSubview:self.imageScrollView];
    }
    return _topView;
}


- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat colum = 4.0, spacing = 2.0;
        CGFloat value = floorf((CGRectGetWidth(self.view.bounds) - (colum - 1) * spacing) / colum);
        
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize                     = CGSizeMake(value, value);
        layout.sectionInset                 = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing      = spacing;
        layout.minimumLineSpacing           = spacing;
        
        CGRect rect = CGRectMake(0, CGRectGetMaxY(self.topView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetHeight(self.topView.bounds));
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[TWPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"TWPhotoCollectionViewCell"];
        
    }
    return _collectionView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    DLog(@"y=============%f",scrollView.contentOffset.y);
    
    CGRect topFrame = self.topView.frame;
    CGRect collectionFrame = self.collectionView.frame;
    
    if (scrollView.contentOffset.y-originOff>GDOff) {
        
        topFrame.origin.y = -(CGRectGetHeight(self.topView.bounds)-20-44);
        collectionFrame.origin.y = CGRectGetMaxY(topFrame);
        collectionFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topFrame);
        [UIView animateWithDuration:.3f animations:^{
            self.topView.frame = topFrame;
            self.collectionView.frame = collectionFrame;
            
        }];
        originOff = 0;
    } else if (originOff-scrollView.contentOffset.y>GDOff) {
        
        topFrame.origin.y = 0;
        collectionFrame.origin.y = CGRectGetMaxY(topFrame);
        collectionFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topFrame);
        [UIView animateWithDuration:.3f animations:^{
            self.topView.frame = topFrame;
            self.collectionView.frame = collectionFrame;
            
        }];
        originOff = 0;
    }

    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //取得照片
    
    DLog(@"Picker returned successfully.");
    DLog(@"%@", info);
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    UIImage *theImage = nil;
    // 判断，图片是否允许修改
    if ([picker allowsEditing]){
        //获取用户编辑之后的图像
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        // 照片的元数据参数
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    
    [self upWishPhoto:theImage];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - BaseViewDelegate
-(void)baseViewClickToController:(NSString *)clickEventName withObject:(id)object{
    if ([clickEventName isEqualToString:@"PhotoListViewClick"]) {//地址点击
        [_downButton setImage:[UIImage imageNamed:@"twPhotoDOWN"] forState:UIControlStateNormal];
        NSString *str = (NSString*)object;
        _selectedMenuIndex = str.intValue;
        
        [self displaySrcoImageAndTitle];
        [_collectionView reloadData];
        
        photoListView = nil;
    }
}

@end

//
//  DynamicGalleryView.m
//  PYM
//
//  Created by Ankit Jayaswal on 6/9/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import "DynamicGalleryView.h"
#import "UIImage+RemoteSize.h"
#import "UIImageView+AFNetworking.h"

@interface DynamicGalleryView () <UIScrollViewDelegate> {
    NSMutableArray          *sizeArray;
    NSMutableArray          *indexArray;
}

@property (readwrite, assign) int           yLeft;
@property (readwrite, assign) int           yRight;
@property (nonatomic, strong) UIScrollView  *scrollDynamicGalleryView;

@end


@implementation DynamicGalleryView
@synthesize arrayImageURL;
@synthesize scrollDynamicGalleryView;
@synthesize yLeft;
@synthesize yRight;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialiseView];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Do your view initialisation here
        [self initialiseView];
    }
    return self;
}

- (void)initialiseView {
    yLeft   = 0;
    yRight  = 0;

    if (!sizeArray) {
        sizeArray = [NSMutableArray array];
    }
    if (!indexArray) {
        indexArray = [NSMutableArray array];
    }
    
    scrollDynamicGalleryView            = [[UIScrollView alloc]initWithFrame:self.frame];
    scrollDynamicGalleryView.delegate   = self;
    [self addSubview:scrollDynamicGalleryView];
}

#pragma -
#pragma mark - Setter Methode of ImageUrlArray

- (void)setArrayImageURL:(NSMutableArray *)arrImageURL {
    arrayImageURL = arrImageURL;
    [self sizeOfDownlodingImages:arrImageURL];
}


#pragma -
#pragma mark - Size calculation of downloading images

- (void)sizeOfDownlodingImages:(NSMutableArray *)imageUrlArray {
    for(NSInteger i=0 ; i<[imageUrlArray count] ; i++){
        __weak typeof(self) weakSelf = self;
        [UIImage requestSizeFor:[NSURL URLWithString:[imageUrlArray objectAtIndex:i]] completion:^(NSURL *imgURL, CGSize size){
            
            NSValue *imageSize;
            if (size.width == 0 || size.height == 0) {
               imageSize = [NSValue valueWithCGSize:CGSizeMake(500, 500)];
            } else {
                imageSize = [NSValue valueWithCGSize:size];
            }
            
            [sizeArray addObject:imageSize];
            [indexArray addObject:[NSNumber numberWithInteger:i]];
            
            if (sizeArray.count == imageUrlArray.count) {
                NSMutableArray *sortedSizeArray = [NSMutableArray arrayWithArray:sizeArray];
                for (NSInteger i=0; i<sizeArray.count; i++) {
                    [sortedSizeArray replaceObjectAtIndex:[((NSNumber *)indexArray[i]) integerValue] withObject:sizeArray[i]];
                }
                
                [weakSelf createDynamicView:sortedSizeArray withImages:imageUrlArray];
            }
        }];
    }
}


#pragma -
#pragma mark - View Creation Method

- (void)createDynamicView:(NSArray *)arrSize withImages:(NSMutableArray *)urlArray{
   
    CGFloat padding = 10;
    CGFloat kImageWidth = ([[UIScreen mainScreen] bounds].size.width - padding*3) / 2;
    CGFloat xOriginleft     = padding;
    CGFloat xOriginRight    = padding*2 + kImageWidth;
    
    yLeft                   += padding;
    yRight                  += padding;
    
    for (int i=0 ; i<[arrSize count] ; i++) {
        CGSize size = [[arrSize objectAtIndex:i] CGSizeValue];
        CGFloat kImageHeight = size.height * kImageWidth / size.width;
        
        switch (i) {
            case 0: {
                UIView *viewImage = [[UIView alloc]initWithFrame:CGRectMake(xOriginleft, yLeft, kImageWidth, kImageHeight)];
                viewImage.tag = i;
                [scrollDynamicGalleryView addSubview:viewImage];
                [self createImageView:viewImage withUrlString:[urlArray objectAtIndex:i]];
                yLeft = yLeft + viewImage.frame.size.height + padding;
            }
                break;
                
            case 1: {
                UIView *viewImage = [[UIView alloc]initWithFrame:CGRectMake(xOriginRight, yRight, kImageWidth, kImageHeight)];
                viewImage.tag = i;
                [scrollDynamicGalleryView addSubview:viewImage];
                [self createImageView:viewImage withUrlString:[urlArray objectAtIndex:i]];
                yRight = yRight + viewImage.frame.size.height + padding;
            }
                break;
                
            default: {
                
                if (yLeft <= yRight) {
                    UIView *viewImage = [[UIView alloc]initWithFrame:CGRectMake(xOriginleft, yLeft, kImageWidth, kImageHeight)];
                    viewImage.tag = i;
                    [scrollDynamicGalleryView addSubview:viewImage];
                    [self createImageView:viewImage withUrlString:[urlArray objectAtIndex:i]];
                    yLeft = yLeft + viewImage.frame.size.height + padding;
                } else {
                    UIView *viewImage = [[UIView alloc]initWithFrame:CGRectMake(xOriginRight, yRight, kImageWidth, kImageHeight)];
                    viewImage.tag = i;
                    [scrollDynamicGalleryView addSubview:viewImage];
                    [self createImageView:viewImage withUrlString:[urlArray objectAtIndex:i]];
                    yRight = yRight + viewImage.frame.size.height + padding;
                }
                
            }
                break;
            // end of switch case
        }
        // end of for loop
    }
    
    
    // Increase content size of scroll view
    if (yLeft > self.frame.size.height || yRight > self.frame.size.height) {
        int height = yLeft > yRight ? yLeft : yRight;
        scrollDynamicGalleryView.contentSize = CGSizeMake(self.frame.size.width, height);
    }
}

- (void)createImageView:(UIView *)view withUrlString:(NSString *)strURL {
    UIImageView *imgViewDownloading = [[UIImageView alloc]initWithFrame:view.bounds];
    [imgViewDownloading setBackgroundColor:[UIColor blackColor]];
    [imgViewDownloading setImageWithURL:[NSURL URLWithString:strURL]];
    [view addSubview:imgViewDownloading];
}

- (void)dealloc {
    sizeArray                   = nil;
    indexArray                  = nil;
    scrollDynamicGalleryView    = nil;
}
@end

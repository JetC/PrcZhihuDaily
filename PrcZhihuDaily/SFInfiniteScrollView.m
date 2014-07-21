//
//  SFInfiniteScrollView.m
//  PrcZhihuDaily
//
//  Created by 孙培峰 on 7/20/14.
//  Copyright (c) 2014 孙培峰. All rights reserved.
//

#import "SFInfiniteScrollView.h"

@interface SFInfiniteScrollView()<UIScrollViewDelegate>
/**
 *  存放ScrollView 各个imageView的Array
 */
@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SFInfiniteScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollView];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    self = [self initWithFrame:frame];
    [self setupWithImageArray:imageArray];
    return self;
}

- (void)setupScrollView
{
    self.imageViewArray = [NSArray new];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2-25, self.frame.size.height-15, 50, 30)];
    self.pageControl.numberOfPages = 1;
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self addSubview:self.pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = lround(self.scrollView.contentOffset.x/SCREEN_WIDTH);
    self.pageControl.currentPage = currentPage;

}

/**
 *  仅在初始化时候调用
 *
 *  @param imageArray 要求均为 UIImage
 */
- (void)setupWithImageArray:(NSArray *)imageArray
{
    NSMutableArray *imageViewArray = [self.imageViewArray mutableCopy];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(imageArray.count), self.frame.size.height);
    while (imageViewArray.count < imageArray.count) {
        [imageViewArray addObject:[NSNull null]];
    }
    self.pageControl.numberOfPages = imageArray.count;

    for (NSInteger i = 0; i<imageArray.count ;i++) {
        UIImage *image = imageArray[i];
        if (![image isKindOfClass:[UIImage class]]) {
            [NSException raise:@"AddingNotUIImage" format:@"The class of adding object is %@",[[image class] description]];
        }
        
        UIImageView *imageViewToAdd = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height)];
        imageViewToAdd.tag = i;
        imageViewToAdd.image = image;
        [self.scrollView addSubview:imageViewToAdd];
        [imageViewArray replaceObjectAtIndex:i withObject:imageViewToAdd];
    }
    self.imageViewArray = [imageViewArray copy];
}

- (void)addImage:(UIImage *)image atIndex:(NSUInteger)index
{
    NSMutableArray *imageViewArray = [self.imageViewArray mutableCopy];
    if (![image isKindOfClass:[UIImage class]]) {
        [NSException raise:@"AddingNotUIImage" format:@"The class of adding object is %@",[[image class] description]];
    }
    if (index > self.imageViewArray.count) {
        index = self.imageViewArray.count;
    }
    
    [imageViewArray insertObject:image atIndex:index];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(imageViewArray.count), self.frame.size.height);
    
    //index 后的 imageView 位置后移
    for (NSInteger i = 0; i< self.scrollView.subviews.count; i++){
        NSInteger imageViewTag = ((UIImageView *)self.scrollView.subviews[i]).tag;
        if (imageViewTag >= index) {
            CGRect changedRect;
            changedRect = ((UIImageView *)self.scrollView.subviews[i]).frame;
            changedRect.origin.x += SCREEN_WIDTH;
            ((UIImageView *)self.scrollView.subviews[i]).frame = changedRect;
        }
    }
    
    
    UIImageView *imageViewToAdd = [[UIImageView alloc]initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height)];
    imageViewToAdd.image = image;
    
    [self.scrollView addSubview: imageViewToAdd];
    self.pageControl.numberOfPages = imageViewArray.count;

    [imageViewArray replaceObjectAtIndex:index withObject:imageViewToAdd];
    self.imageViewArray = [imageViewArray copy];
}

- (void)addImageAtEnd:(UIImage *)image
{
    [self addImage:image atIndex:self.imageViewArray.count];
}

- (void)removeImage:(UIImage *)image
{
    for (NSInteger i = 0; i<self.imageViewArray.count ;i++) {
        if ([((UIImageView *)self.imageViewArray[i]).image isEqual:image]) {
            [self removeImageAtIndex:i];
        }
    }
}

- (void)removeImageAtIndex:(NSUInteger)index
{
    NSMutableArray *imageViewArray = [self.imageViewArray mutableCopy];
    [imageViewArray removeObjectAtIndex:index];
    self.imageViewArray = imageViewArray;
    
    self.scrollView.contentSize = self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(imageViewArray.count), self.frame.size.height);
//    self
}













/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

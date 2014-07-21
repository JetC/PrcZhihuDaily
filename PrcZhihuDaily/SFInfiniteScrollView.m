//
//  SFInfiniteScrollView.m
//  PrcZhihuDaily
//
//  Created by 孙培峰 on 7/20/14.
//  Copyright (c) 2014 孙培峰. All rights reserved.
//

#import "SFInfiniteScrollView.h"

@interface SFInfiniteScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *baseView;

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

- (void)setupScrollView
{
    self.baseView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:self.baseView];
    self.imageViewArray = [NSArray new];
    self.pagingEnabled = YES;
    self.contentSize = CGSizeMake(SCREEN_WIDTH, self.frame.size.height);
    self.contentOffset = CGPointMake(0, 0);
    self.delegate = self;
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height-30, 50, 30)];
    self.pageControl.numberOfPages = 1;
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor blackColor];
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:self.pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = lround(self.contentOffset.x/SCREEN_WIDTH);
    self.pageControl.currentPage = currentPage;
    [self bringSubviewToFront:self.pageControl];

}

- (void)addImage:(UIImage *)image atIndex:(NSUInteger)index
{
    NSMutableArray *imageViewArray = [self.imageViewArray mutableCopy];
    if ([image isKindOfClass:[UIImage class]]) {
        while (imageViewArray.count <= index) {
            [imageViewArray addObject:[NSNull null]];
        }
    }
    else{
        [NSException raise:@"AddingNotUIImage" format:@"The class of adding object is %@",[[image class] description]];
    }
    
    if (index>self.imageViewArray.count) {
        NSLog(@"Adding above index of imageViewArray, will add at the end");
        index = self.imageViewArray.count;
    }
    
    self.contentSize = CGSizeMake(SCREEN_WIDTH*(imageViewArray.count), self.frame.size.height);
    
    UIImageView *imageViewToAdd = [[UIImageView alloc]initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height)];
    NSLog(@"index:%zd",index);
    imageViewToAdd.image = image;
    [self.baseView addSubview: imageViewToAdd];
    self.pageControl.numberOfPages = imageViewArray.count;

    [imageViewArray replaceObjectAtIndex:index withObject:imageViewToAdd];
    self.imageViewArray = [imageViewArray copy];
    [self bringSubviewToFront:self.pageControl];
}

- (void)addImage:(UIImage *)image
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

//
//  SFInfiniteScrollView.m
//  PrcZhihuDaily
//
//  Created by 孙培峰 on 7/20/14.
//  Copyright (c) 2014 孙培峰. All rights reserved.
//

#import "SFInfiniteScrollView.h"

@interface SFInfiniteScrollView()

@property (nonatomic, strong) NSArray *imageViewArray;

@end

@implementation SFInfiniteScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViewArray = [NSArray new];
    }
    return self;
}

- (void)setupScrollView
{
    self.pagingEnabled = YES;
    self.contentSize = CGSizeMake(SCREEN_WIDTH*3, self.frame.size.height);
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
    imageViewToAdd.image = image;
    [self addSubview: imageViewToAdd];
    
    
    [imageViewArray replaceObjectAtIndex:index withObject:imageViewToAdd];
    self.imageViewArray = [imageViewArray copy];
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

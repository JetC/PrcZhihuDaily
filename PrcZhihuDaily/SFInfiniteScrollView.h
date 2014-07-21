//
//  SFInfiniteScrollView.h
//  PrcZhihuDaily
//
//  Created by 孙培峰 on 7/20/14.
//  Copyright (c) 2014 孙培峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFInfiniteScrollViewProtocol <NSObject>

- (void)scrollViewDidRecenter:(UIImageView *)scrollViewInCenter;

@end

@interface SFInfiniteScrollView : UIView

@property (weak, nonatomic) id<SFInfiniteScrollViewProtocol> delegate;

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
- (void)addImage:(UIImage *)image atIndex:(NSUInteger)index;
- (void)addImageAtEnd:(UIImage *)image;
- (void)replaceUsingImage:(UIImage *)image atIndex:(NSUInteger)index;
- (void)removeImage:(UIImage *)image;
- (void)removeImageAtIndex:(NSUInteger)index;

@end

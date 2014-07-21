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

@interface SFInfiniteScrollView : UIScrollView

- (void)addImage:(UIImage *)image atIndex:(NSUInteger)index;
- (void)addImage:(UIImage *)image;
- (void)removeImage:(UIImage *)image;
- (void)removeImageAtIndex:(NSUInteger)index;

@end

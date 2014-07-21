//
//  SFViewController.m
//  PrcZhihuDaily
//
//  Created by 孙培峰 on 7/20/14.
//  Copyright (c) 2014 孙培峰. All rights reserved.
//

#import "SFViewController.h"
#import "SFInfiniteScrollView.h"

@interface SFViewController ()

@property (nonatomic, strong) SFInfiniteScrollView *infiniteScrollView;
@property (nonatomic, strong) UIButton *button;


@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *imageArray = [NSMutableArray new];
    UIImage *image1 = [UIImage imageNamed:@"7C50238EB92F56A0A7CB8B760382A2D0"];
    UIImage *image2 = [UIImage imageNamed:@"84761bb61_l副本75"];
    [imageArray addObject:image1];
    [imageArray addObject:image2];
    [imageArray addObject:image2];
	self.infiniteScrollView = [[SFInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/5) imageArray:imageArray];
    [self.view addSubview:self.infiniteScrollView];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(200, 400, 100, 50)];
    self.button.titleLabel.text = @"++1";
    [self.button bk_addEventHandler:^(id sender) {
        [self.infiniteScrollView addImageAtEnd:[UIImage imageNamed:@"7C50238EB92F56A0A7CB8B760382A2D0"]];
    } forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.button];
}

- (void)viewDidAppear:(BOOL)animated
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

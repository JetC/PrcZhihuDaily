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

@property (nonatomic, strong) SFInfiniteScrollView *scrollView;


@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scrollView = [[SFInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/5)];
    
    [self.scrollView addImage:[UIImage imageNamed:@"7C50238EB92F56A0A7CB8B760382A2D0"]];
    [self.scrollView addImage:[UIImage imageNamed:@"7C50238EB92F56A0A7CB8B760382A2D0"]];
    [self.scrollView addImage:[UIImage imageNamed:@"7C50238EB92F56A0A7CB8B760382A2D0"]];

    [self.view addSubview:self.scrollView];
    
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

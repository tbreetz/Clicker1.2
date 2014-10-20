//
//  ViewController.m
//  Clicker1.2
//
//  Created by Alan on 10/18/14.
//  Copyright (c) 2014 alanchan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LoadingProgress.progress = 0;
    StartButton.hidden = YES;
    
    [self LoadTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)LoadTimer{
    
    LoadTimer = [NSTimer scheduledTimerWithTimeInterval:.01
                                                 target:self
                                               selector:@selector(LoadRunningTimer)
                                               userInfo:nil
                                                repeats:YES];
    
}

- (void)LoadRunningTimer{
    
    LoadingProgress.progress += .00125;
    
    if (LoadingProgress.progress == 1) {
        
        [LoadTimer invalidate];
        StartButton.hidden = NO;
        
    }
    
}

@end

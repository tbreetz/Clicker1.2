//
//  ViewController.h
//  Clicker1.2
//
//  Created by Alan on 10/18/14.
//  Copyright (c) 2014 alanchan. All rights reserved.
//

#import <UIKit/UIKit.h>

NSTimer *LoadTimer;

@interface ViewController : UIViewController

{
    __weak IBOutlet UIProgressView *LoadingProgress;
    
    __weak IBOutlet UIButton *StartButton;
    
}

-(void)LoadTimer;
-(void)LoadRunningTimer;

@end


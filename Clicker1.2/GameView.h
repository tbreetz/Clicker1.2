//
//  GameView.h
//  Clicker1.2
//
//  Created by Alan on 10/19/14.
//  Copyright (c) 2014 alanchan. All rights reserved.
//

#import <UIKit/UIKit.h>

int Score = 0;

int MS = 0;
int Second = 0;
int Minute = 0;
long checkTime = 0;
long checkHighTime = 0;

NSTimer *ScoreTimer;

NSInteger HighScore;

NSString *winString;
NSString *winScoreString;
NSString *resetString;
NSString *savedHighScore;

@interface GameView : UIViewController

{
    __weak IBOutlet UILabel *lblScore;
    __weak IBOutlet UIProgressView *ScoreProgress;
    __weak IBOutlet UILabel *lblTimer;
    __weak IBOutlet UILabel *lblHighScore;
    
}


- (IBAction)ScoreButton:(id)sender;
- (IBAction)ResetButton:(id)sender;

- (void)StartTimer;
- (void)RunningTimer;
- (void)CheckForHighScore;
- (void)LoadHighScore;


@end

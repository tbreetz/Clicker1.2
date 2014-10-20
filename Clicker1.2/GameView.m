//
//  GameView.m
//  Clicker1.2
//
//  Created by Alan on 10/19/14.
//  Copyright (c) 2014 alanchan. All rights reserved.
//

#import "GameView.h"

@implementation GameView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    Score = 0;
    ScoreProgress.progress = 0;
    
    [self LoadHighScore];   //Load the highscore checking function
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)CheckForHighScore{
    if (checkTime < checkHighTime || checkHighTime == 0) {
        
        checkHighTime = checkTime;
        
        [[NSUserDefaults standardUserDefaults] setInteger:checkHighTime forKey:@"high_time"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:winScoreString forKey:@"highScore_label"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        lblHighScore.text = [NSString stringWithFormat:@"%@", winScoreString];
        
    }
    
    
}

- (void)LoadHighScore{
    
    savedHighScore = [[NSUserDefaults standardUserDefaults] stringForKey:@"highScore_label"];
    lblHighScore.text = [NSString stringWithFormat:@"%@", savedHighScore];
    
    HighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_time"];
    
    checkHighTime = HighScore;
    
    
    
}

- (IBAction)ScoreButton:(id)sender {
    
    Score += 1;
    lblScore.text = [NSString stringWithFormat:@"%d", Score];
    ScoreProgress.progress += .01;
    
    if (Score == 1) {
        
        [self StartTimer];
        
    }
    
}

- (void)StartTimer{
    
    ScoreTimer = [NSTimer scheduledTimerWithTimeInterval:.01
                                                  target:self
                                                selector:@selector(RunningTimer)
                                                userInfo:nil
                                                 repeats:YES];
    
}

- (void)RunningTimer{
    
    MS += 1;
    
    if (MS == 100) {
        
        MS = 0;
        Second += 1;
        
    }
    
    if (Second == 60) {
        
        Second = 0;
        Minute += 1;
        
    }
    
    if (MS < 10 && Second < 10 && Minute < 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"0%d:0%d:0%d", Minute, Second, MS];

    }
    
    else if (MS < 10 && Second < 10 && Minute > 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"%d:0%d:0%d", Minute, Second, MS];

        
    }
    
    else if (MS < 10 && Second > 10 && Minute < 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"0%d:%d:0%d", Minute, Second, MS];

    }
    
    else if (MS > 10 && Second < 10 && Minute < 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"0%d:0%d:%d", Minute, Second, MS];

    }
    
    else if (MS > 10 && Second > 10 && Minute < 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"0%d:%d:%d", Minute, Second, MS];
        
    }
    
    else if (MS > 10 && Second < 10 && Minute > 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"%d:0%d:%d", Minute, Second, MS];
        
    }
    
    else if (MS > 10 && Second > 10 && Minute > 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"%d:%d:%d", Minute, Second, MS];
        
    }
    
    else if (MS > 10 && Second == 10 && Minute < 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"0%d:%d:%d", Minute, Second, MS];

    }
    
    else if (MS < 10 && Second == 10 && Minute < 10) {
        
        lblTimer.text = [NSString stringWithFormat:@"0%d:%d:0%d", Minute, Second, MS];

    }
    
    
    if (Score == 100) {
        
        [ScoreTimer invalidate];
        
        checkTime = ((10000 * Minute) + (100 * Second) + (MS));
        
        winScoreString = lblTimer.text;
        
        [self CheckForHighScore];
        
        winString = [NSString stringWithFormat:@"Congratulations, you clicked the button 100 times in %@! Would you like to play again?", winScoreString];
        
        UIAlertView *winAlert = [[UIAlertView alloc] init];
        [winAlert setTitle:@"Congratulations!"];
        [winAlert setMessage:winString];
        [winAlert setDelegate:self];
        [winAlert addButtonWithTitle:@"Yes"];
        [winAlert addButtonWithTitle:@"No"];
        
        [winAlert show];
        
        winAlert.tag = 1;
        
    }
        
    
} //end RunningTimer


- (IBAction)ResetButton:(id)sender {
    
    resetString = [NSString stringWithFormat:@"Are you sure you want to reset the high score? This action is not reversible"];
    
    UIAlertView *resetAlert = [[UIAlertView alloc] init];
    [resetAlert setTitle:@"Reset High Score"];
    [resetAlert setMessage:resetString];
    [resetAlert setDelegate:self];
    [resetAlert addButtonWithTitle:@"Yes"];
    [resetAlert addButtonWithTitle:@"No"];
    
    [resetAlert show];
    
    resetAlert.tag = 2;
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    

    
    if (buttonIndex == 0) {
        
        if (alertView.tag == 1){ //winning: yes
            
            Score = 0;
            checkTime = 0;
            lblScore.text = [NSString stringWithFormat:@"Click to Begin"];
            ScoreProgress.progress = 0;
            MS = 0;
            Second = 0;
            Minute = 0;
            lblTimer.text = [NSString stringWithFormat:@"00:00:00"];
            
        }
        
        if (alertView.tag == 2) { //reset: yes
            
            checkHighTime = 0;
            lblHighScore.text = [NSString stringWithFormat:@"00:00:00"];
            savedHighScore = lblHighScore.text;
            [[NSUserDefaults standardUserDefaults] setObject:savedHighScore forKey:@"highScore_label"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setInteger:checkHighTime forKey:@"high_time"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
        }
        
    } //end buttonIndex = 0
    
    
    else if (buttonIndex == 1) {
        
        if (alertView.tag == 1) { //winning: no
            
            exit(0);
            
            
        }
        
        if (alertView.tag == 2) {
            
            
        }
        
        
        
    } //end buttonIndex = 1
    
} //end alertView

@end

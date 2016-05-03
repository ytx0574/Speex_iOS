//
//  ViewController.m
//  Speex_iOS
//
//  Created by Johnson on 5/3/16.
//  Copyright © 2016 Johnson. All rights reserved.
//

#import "ViewController.h"
#import "RecorderManager.h"
#import "PlayerManager.h"

@interface ViewController ()
{
    NSString *_tmpPath;
    __weak IBOutlet UIButton *_buttonRecord;
    __weak IBOutlet UIButton *_buttonPlay;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickRecord:(UIButton *)sender
{
    if (![RecorderManager detectionRecordPermission]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"请开启麦克风" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        return;
    }
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [[RecorderManager sharedManager] setDelegate:(id)self];
        [[RecorderManager sharedManager] startRecording];
    }else {
        [[RecorderManager sharedManager] stopRecording];
    }
}

- (IBAction)clickPlay:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [[PlayerManager sharedManager] playAudioWithFileName:_tmpPath delegate:(id)self];
    }else {
        [[PlayerManager sharedManager] stopPlaying];
    }
}



#pragma mark - RecordingDelegate
- (void)recordingFinishedWithFileName:(NSString *)filePath time:(NSTimeInterval)interval;
{
    _tmpPath = filePath;
    
    
}
- (void)recordingTimeout;
{
    _buttonRecord.selected = NO;
}
- (void)recordingStopped;
{
    _buttonRecord.selected = NO;
}
- (void)recordingFailed:(NSString *)failureInfoString;
{
    _buttonRecord.selected = NO;
}

- (void)levelMeterChanged:(float)levelMeter;
{
    NSLog(@"levelMeter: %f", levelMeter);
}

#pragma mark - PlayingDelegate
- (void)playingStoped;
{
   _buttonPlay.selected = NO;
}
@end

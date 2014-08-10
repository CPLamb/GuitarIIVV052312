//
//  SecondViewController.h
//  GuitarIIVV
//
//  Created by David Fierstein on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface SecondViewController : UIViewController <AVAudioPlayerDelegate>
{
    BOOL playingChords;
    BOOL playingProgression;
    int j;              //counter for chord in array
    int chartPosition;
    int fingeringPosition;
    BOOL tutorSwitch;
    BOOL playerPlayedChord;
    
    BOOL finger1Used;
    BOOL finger2Used;
    BOOL finger3Used;
    BOOL finger4Used;
    
    BOOL playingC;
    BOOL playingG;
    BOOL playingD;
    BOOL playingA;
    BOOL playingE;
    BOOL playingB;
    BOOL playingFSharp;
    BOOL playingCSharp;
    BOOL playingGSharp;
    BOOL playingDSharp;
    BOOL playingASharp;
    BOOL playingF;
}
//@property (strong, nonatomic) IBOutlet UIImageView *chordView;

@property (strong, nonatomic) NSMutableArray *progressionOneFourFive;
@property (strong, nonatomic) NSMutableArray *recordedChords;
@property (strong, nonatomic) NSMutableArray *chordsToPlay;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@property (strong, nonatomic) IBOutlet UIButton *finger1;
@property (strong, nonatomic) IBOutlet UIButton *finger2;
@property (strong, nonatomic) IBOutlet UIButton *finger3;
@property (strong, nonatomic) IBOutlet UIButton *finger4;

@property (nonatomic, strong) AVAudioPlayer *audioPlayerLeft;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerMiddle;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerRight;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerStartSound;

@property (nonatomic, strong) AVAudioPlayer *audioPlayerC;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerG;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerD;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerA;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerE;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerB;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerFSharp;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerCSharp;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerGSharp;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerDSharp;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerASharp;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerF;

- (IBAction)highlightFingers:(UIButton *)sender;
- (IBAction)resetAction:(UIButton *)sender;
- (IBAction)playChordsButton:(UIButton *)sender;
- (IBAction)scaleFingers:(UIButton *)sender;
- (IBAction)tutorSwitcher:(UISwitch *)sender;

- (IBAction)finger1Pressed:(UIButton *)sender;
- (IBAction)finger2Pressed:(UIButton *)sender;
- (IBAction)finger3Pressed:(UIButton *)sender;
- (IBAction)finger4Pressed:(UIButton *)sender;

- (IBAction)moveToC:(UIButton *)sender;
- (IBAction)moveToG:(UIButton *)sender;
- (IBAction)moveToD:(UIButton *)sender;
- (IBAction)moveToA:(UIButton *)sender;
- (IBAction)moveToE:(UIButton *)sender;
- (IBAction)moveToB:(UIButton *)sender;
- (IBAction)moveToFSharp:(UIButton *)sender;
- (IBAction)moveToCSharp:(UIButton *)sender;
- (IBAction)moveToGSharp:(UIButton *)sender;
- (IBAction)moveToDSharp:(UIButton *)sender;
- (IBAction)moveToASharp:(UIButton *)sender;
- (IBAction)moveToF:(UIButton *)sender;

@end

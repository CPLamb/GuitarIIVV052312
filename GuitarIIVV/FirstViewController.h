//
//  FirstViewController.h
//  GuitarIIVV
//
//  Created by David Fierstein on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FirstViewController : UIViewController <AVAudioPlayerDelegate, UIGestureRecognizerDelegate> 
{
    IBOutlet UIView *chart;
    IBOutlet UIView *chartView;
    IBOutlet UILabel *iv;
    IBOutlet UILabel *v;
    IBOutlet UILabel *i;
    
    NSMutableArray *progressionOneFourFive;
    NSMutableArray *recordedChords;
    NSMutableArray *chordsToPlay;
    
    float chartRotation;
    int chartPosition;  
    int j;              // chord number played in progression used to step thru array
    BOOL recordingChords;
    BOOL playingChords;
    BOOL playingProgression;
    IBOutlet UIButton *recordingButton;
    IBOutlet UIButton *playingButton;

    UISwipeGestureRecognizer *swipeRecognizerLeft;
    UISwipeGestureRecognizer *swipeRecognizerRight;

// Various audioPlayers required to playback sound  
    AVAudioPlayer *audioPlayerRecorder;
    AVAudioPlayer *audioPlayerStartSound;
    
//    AVAudioPlayer *audioPlayerLeft;
    AVAudioPlayer *audioPlayerMiddle;
    AVAudioPlayer *audioPlayerRight;
    
    AVAudioPlayer *audioPlayer01;
    AVAudioPlayer *audioPlayer02;
    AVAudioPlayer *audioPlayer03;
    AVAudioPlayer *audioPlayer04;
    AVAudioPlayer *audioPlayer05;
    AVAudioPlayer *audioPlayer06;
    AVAudioPlayer *audioPlayer07;
    AVAudioPlayer *audioPlayer08;
    AVAudioPlayer *audioPlayer09;
    AVAudioPlayer *audioPlayer10;
    AVAudioPlayer *audioPlayer11;
    AVAudioPlayer *audioPlayer12;
}

@property (nonatomic, assign) UIView *chart;
@property (nonatomic, assign) UIView *chartView;
@property (nonatomic, strong) IBOutlet UILabel *iv;
@property (nonatomic, strong) IBOutlet UILabel *v;
@property (nonatomic, strong) IBOutlet UILabel *i;

-(IBAction)chartSwipedLeft: (UISwipeGestureRecognizer *)swipeGestureLeft;
-(IBAction)chartSwipedRight: (UISwipeGestureRecognizer *)swipeGestureRight;

@property (nonatomic, strong) AVAudioPlayer *audioPlayerLeft;

// Chord arrays for storing progressions
@property (nonatomic, strong) NSMutableArray *progressionOneFourFive;
@property (nonatomic, strong) NSMutableArray *recordedChords;
@property (nonatomic, strong) NSMutableArray *chordsToPlay;

@property (nonatomic, strong) IBOutlet UIButton *recordingButton;
@property (nonatomic, strong) IBOutlet UIButton *playingButton;

// Animation views for each positional chord being played
@property (nonatomic, strong) IBOutlet UIImageView *leftChordView;
@property (nonatomic, strong) IBOutlet UIImageView *middleChordView;
@property (nonatomic, strong) IBOutlet UIImageView *rightChordView;

// Chord name display in 4 beats per measure
@property (strong, nonatomic) IBOutlet UILabel *m1Beat1;
@property (strong, nonatomic) IBOutlet UILabel *m1Beat2;
@property (strong, nonatomic) IBOutlet UILabel *m1Beat3;
@property (strong, nonatomic) IBOutlet UILabel *m1Beat4;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat1;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat2;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat3;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat4;


// Hidden (alpha = 0.05) chord sound buttons
- (IBAction)leftChordButton:(UIButton *)sender;
- (IBAction)middleChordButton:(UIButton *)sender;
- (IBAction)rightChordButton:(UIButton *)sender;
- (IBAction)playChordProgressionButton:(UIButton *)sender;

// These methods STOP the sound when the finger is lifted (sound STARTs when finger down)
- (IBAction)leftChordStopButton:(UIButton *)sender;
- (IBAction)middleChordStopButton:(UIButton *)sender;
- (IBAction)rightChordStopButton:(UIButton *)sender;

// Play & record sounds buttons
- (IBAction)recordChordsButton:(UIButton *)sender;
- (IBAction)playChordsButton:(UIButton *)sender;
- (IBAction)clearButton:(UIButton *)sender;

@end

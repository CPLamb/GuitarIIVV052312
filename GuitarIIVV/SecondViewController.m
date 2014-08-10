//
//  SecondViewController.m
//  GuitarIIVV
//
//  Created by David Fierstein on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

//@synthesize chordView = _chordView;
@synthesize progressionOneFourFive = _progressionOneFourFive;
@synthesize recordedChords = _recordedChords;
@synthesize chordsToPlay = _chordsToPlay;

@synthesize playButton = _playButton;

@synthesize finger1 = _finger1;
@synthesize finger2 = _finger2;
@synthesize finger3 = _finger3;
@synthesize finger4 = _finger4;

@synthesize audioPlayerLeft = _audioPlayerLeft;
@synthesize audioPlayerMiddle = _audioPlayerMiddle;
@synthesize audioPlayerRight = _audioPlayerRight;
@synthesize audioPlayerRecorder = _audioPlayerRecorder;
@synthesize audioPlayerStartSound = _audioPlayerStartSound;

@synthesize audioPlayerC = _audioPlayerC;
@synthesize audioPlayerG = _audioPlayerG;
@synthesize audioPlayerD = _audioPlayerD;
@synthesize audioPlayerA = _audioPlayerA;
@synthesize audioPlayerE = _audioPlayerE;
@synthesize audioPlayerB = _audioPlayerB;
@synthesize audioPlayerFSharp = _audioPlayerFSharp;
@synthesize audioPlayerCSharp = _audioPlayerCSharp;
@synthesize audioPlayerGSharp = _audioPlayerGSharp;
@synthesize audioPlayerDSharp = _audioPlayerDSharp;
@synthesize audioPlayerASharp = _audioPlayerASharp;
@synthesize audioPlayerF = _audioPlayerF;

#pragma mark - view overhead methods

- (void)viewDidLoad
{
    [super viewDidLoad];
// initializes arrays & other properties
    j = 0;
    chartPosition = 1;                          // Presets initial key to C
    tutorSwitch = NO;
    self.chordsToPlay = [[NSMutableArray alloc] init];                              
    self.recordedChords = [[NSMutableArray alloc] init];               
    self.progressionOneFourFive = [[NSMutableArray alloc] initWithObjects:@"I", @"V", @"IV", @"I", @"V", @"IV", @"I", @"V", @"IV", @"I", nil]; 
    
// Setup of AVAudioPlayer for sounds.  Done here because it takes time to config each audioPlayer
    // Left (V), Middle (I) & Right (IV) chord positions
    NSURL *urlLeft = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"12ChordF" ofType:@"mp3"]];
    self.audioPlayerLeft = [[AVAudioPlayer alloc] initWithContentsOfURL:urlLeft error:NULL];
    self.audioPlayerLeft.delegate = self;
    [self.audioPlayerLeft prepareToPlay];
    
    NSURL *urlMiddle = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01ChordC" ofType:@"mp3"]];
    self.audioPlayerMiddle = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMiddle error:NULL];
    self.audioPlayerMiddle.delegate = self;
    [self.audioPlayerMiddle prepareToPlay];
    
    NSURL *urlRight = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"02ChordG" ofType:@"mp3"]];
    self.audioPlayerRight = [[AVAudioPlayer alloc] initWithContentsOfURL:urlRight error:NULL];
    self.audioPlayerRight.delegate = self;
    [self.audioPlayerRight prepareToPlay];
    
    NSURL *urlStart = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"00StartSound" ofType:@"mp3"]];
    self.audioPlayerStartSound = [[AVAudioPlayer alloc] initWithContentsOfURL:urlStart error:NULL];
    self.audioPlayerStartSound.delegate = self;
    [self.audioPlayerStartSound prepareToPlay];
    
    // Recorder / Progression audioPlayer used to play recorded progressions
    NSURL *urlRecorder = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"00StartSound" ofType:@"mp3"]];
    self.audioPlayerRecorder = [[AVAudioPlayer alloc] initWithContentsOfURL:urlRecorder error:NULL];
    self.audioPlayerRecorder.delegate = self;
    [self.audioPlayerRecorder prepareToPlay];    
    
// Sets up all of the audioPlayers with sound files
    NSURL *urlC = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01ChordC" ofType:@"mp3"]];
    self.audioPlayerC = [[AVAudioPlayer alloc] initWithContentsOfURL:urlC error:nil];
    self.audioPlayerC.delegate = self;
    
    NSURL *urlG = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"02ChordG" ofType:@"mp3"]];
    self.audioPlayerG = [[AVAudioPlayer alloc] initWithContentsOfURL:urlG error:nil];
    self.audioPlayerG.delegate = self;

    NSURL *urlD = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"03ChordD" ofType:@"mp3"]];
    self.audioPlayerD = [[AVAudioPlayer alloc] initWithContentsOfURL:urlD error:nil];
    self.audioPlayerD.delegate = self;

    NSURL *urlA = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"04ChordA" ofType:@"mp3"]];
    self.audioPlayerA = [[AVAudioPlayer alloc] initWithContentsOfURL:urlA error:NULL];
    self.audioPlayerA.delegate = self;

    NSURL *urlE = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"05ChordE" ofType:@"mp3"]];
    self.audioPlayerE = [[AVAudioPlayer alloc] initWithContentsOfURL:urlE error:nil];
    self.audioPlayerE.delegate = self;

    NSURL *urlB = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"06ChordB" ofType:@"mp3"]];
    self.audioPlayerB = [[AVAudioPlayer alloc] initWithContentsOfURL:urlB error:nil];
    self.audioPlayerB.delegate = self;
    
    NSURL *urlFSharp = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"07ChordF#" ofType:@"mp3"]];
    self.audioPlayerFSharp = [[AVAudioPlayer alloc] initWithContentsOfURL:urlFSharp error:nil];
    self.audioPlayerFSharp.delegate = self;
    
    NSURL *urlCSharp = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"08ChordC#" ofType:@"mp3"]];
    self.audioPlayerCSharp = [[AVAudioPlayer alloc] initWithContentsOfURL:urlCSharp error:nil];
    self.audioPlayerCSharp.delegate = self;
    
    NSURL *urlGSharp = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"09CHordG#" ofType:@"mp3"]];
    self.audioPlayerGSharp = [[AVAudioPlayer alloc] initWithContentsOfURL:urlGSharp error:nil];
    self.audioPlayerGSharp.delegate = self;
    
    NSURL *urlDSharp = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"10ChordD#" ofType:@"mp3"]];
    self.audioPlayerDSharp = [[AVAudioPlayer alloc] initWithContentsOfURL:urlDSharp error:nil];
    self.audioPlayerDSharp.delegate = self;
    
    NSURL *urlASharp = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"11ChordA#" ofType:@"mp3"]];
    self.audioPlayerASharp = [[AVAudioPlayer alloc] initWithContentsOfURL:urlASharp error:nil];
    self.audioPlayerASharp.delegate = self;
    
    NSURL *urlF = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"12ChordF" ofType:@"mp3"]];
    self.audioPlayerF = [[AVAudioPlayer alloc] initWithContentsOfURL:urlF error:nil];
    self.audioPlayerF.delegate = self;
    
}

- (void)viewDidUnload {
//    [self setChordView:nil];

    [self setFinger1:nil];
    [self setFinger2:nil];
    [self setFinger4:nil];
    [self setFinger3:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {    
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - animation methods

- (IBAction)highlightFingers:(UIButton *)sender {
    NSLog(@"Starting the animation by highlighting the fingers");
    self.finger1.highlighted = YES;
    
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = YES;    
}

- (IBAction)resetAction:(UIButton *)sender {
    [self resetActionAction];
}
    
    
- (void)resetActionAction {    
    NSLog(@"Resets everything back to zero");
    self.finger1.highlighted = NO;
    self.finger2.highlighted = NO;
    self.finger3.highlighted = NO;
    self.finger4.highlighted = NO;
    
    finger1Used = NO;
    finger2Used = NO;
    finger3Used = NO;
    finger4Used = NO;
    
    playingC = NO;
    playingG = NO;
    playingD = NO;
    playingA = NO;
    
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(0, 0);
        self.finger1.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(0, 0);
        self.finger2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(0, 0);
        self.finger3.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
        self.finger4.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
}

- (IBAction)playChordsButton:(UIButton *)sender {

    // Toggles playingChords status/button
    if (!playingChords) {
        NSLog(@"Started Playing!!!!");
        playingChords = YES; 
        playingProgression = YES;
        self.playButton.highlighted = YES;
    }    
    // set chordsToPlay array then goto select chords
    [self.chordsToPlay setArray:self.progressionOneFourFive];                          
    
    self.audioPlayerRecorder = self.audioPlayerStartSound;   
    [self.audioPlayerRecorder play];
    [self select145ChordToPlay];
    
}

- (IBAction)scaleFingers:(UIButton *)sender {
    NSLog(@"Resizing the fingers for various player expertise");
    
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
//        self.finger1.transform = CGAffineTransformMakeTranslation(-171, 0);
        self.finger1.transform = CGAffineTransformMakeScale(0.67, 0.67);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
//        self.finger2.transform = CGAffineTransformMakeTranslation(0, 0);
        self.finger2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeScale(1.5, 1.5);
//        self.finger3.transform = CGAffineTransformMakeTranslation(-43, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeScale(2.0, 2.0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 

}
/*
- (IBAction)tutorSwitcher:(UISwitch *)sender {
    NSLog(@"Switching tutor play mode");
    
    if (sender.on) { 
        tutorSwitch = YES;
        NSLog(@"Tutor is Switched %d", tutorSwitch);
    }
    if (!sender.on) { 
        tutorSwitch = NO;
        NSLog(@"Tutor is Switched %d", tutorSwitch);
    }
}
*/
- (void)resetChordPlayed {      //resets the chord being played each time a new chord is pressed
    playingC = NO;
    playingG = NO;
    playingD = NO;
    playingA = NO;
    playingE = NO;
    playingB = NO;
    playingFSharp = NO;
    playingCSharp = NO;
    playingGSharp = NO;
    playingDSharp = NO;
    playingE = NO;
    playingF = NO;
    
}

#pragma mark - fingering chords methods

- (IBAction)finger1Pressed:(UIButton *)sender {
//    NSLog(@"finger 1 of the chord pressed");
    [self playChordByPlayer];
}

- (IBAction)finger2Pressed:(UIButton *)sender {
//    NSLog(@"finger 2 of the chord pressed");
    [self playChordByPlayer];
}

- (IBAction)finger3Pressed:(UIButton *)sender {
//    NSLog(@"finger 3 of the chord pressed");
    [self playChordByPlayer];
}

- (IBAction)finger4Pressed:(UIButton *)sender {
//    NSLog(@"finger 4 of the chord pressed");
    [self playChordByPlayer];
}

- (void)playChordByPlayer {
    NSLog(@"Plays the chord if ALL 4 fingers are NOT highlighted");
    
// If the fingers are highlighted AND touch(ed)Inside then we have a proper fingering 
    if ((self.finger1.touchInside == finger1Used) && (self.finger2.touchInside == finger2Used) && (self.finger3.touchInside == finger3Used) && (self.finger4.touchInside == finger4Used)) {
        playerPlayedChord = YES;
        [self whichChordPlayerPlayed];
    } else {
//        NSLog(@"NOTTTT");
    }
}

-(void)whichChordPlayerPlayed {
    NSLog(@"Now we select which chord the player just played");
    
    if (!tutorSwitch) {
        if (playingC) [self.audioPlayerC play];
        if (playingG) [self.audioPlayerG play];
        if (playingD) [self.audioPlayerD play];
        if (playingA) [self.audioPlayerA play];
        if (playingE) [self.audioPlayerE play];
        if (playingB) [self.audioPlayerB play];
        if (playingFSharp) [self.audioPlayerFSharp play];
        if (playingCSharp) [self.audioPlayerCSharp play];
        if (playingGSharp) [self.audioPlayerGSharp play];
        if (playingDSharp) [self.audioPlayerDSharp play];
        if (playingASharp) [self.audioPlayerASharp play];
        if (playingF) [self.audioPlayerF play];
    }
}

- (void)playNextChord {
    //    NSLog(@"Now pick out the next chord from the array number %d", j);    
    [self select145ChordToPlay];
    
    // Now play the chord is tutor switch is OFF
    if ((tutorSwitch) && (playerPlayedChord)) {
        [self.audioPlayerRecorder play];
        NSLog(@"Now pick out the next chord from the array number %d", j);
        playerPlayedChord = NO;
    } 
    if (!tutorSwitch) {
        [self.audioPlayerRecorder play];        
    }
}

- (void)select145ChordToPlay {
    //    NSLog(@"Trying to select the correct chord for %@", [chordsToPlay objectAtIndex:j]);
    
    // Selects the left (V), middle (I), right (IV) audioPlayer depending upon the value in the array object
    if ([self.chordsToPlay objectAtIndex:j] == @"V") {
        //        NSLog(@"Chord V selected");
        self.audioPlayerRecorder = self.audioPlayerLeft;
        fingeringPosition = chartPosition - 1;
        [self correctFingeringPosition];
        [self moveToWhichFingeringPostion];
    } else {
        if ([self.chordsToPlay objectAtIndex:j] == @"I") {
            //            NSLog(@"Chord I selected");
            self.audioPlayerRecorder = self.audioPlayerMiddle;
            fingeringPosition = chartPosition;
            [self moveToWhichFingeringPostion];
        } else {
            if ([self.chordsToPlay objectAtIndex:j] == @"IV") {
                //                NSLog(@"Chord IV selected");
                self.audioPlayerRecorder = self.audioPlayerRight;
                fingeringPosition = chartPosition + 1;
                [self correctFingeringPosition];
                [self moveToWhichFingeringPostion];
            } else {
                NSLog(@"COULD NoT FIND the chord???");
            }
        }
    }
}

- (void)correctFingeringPosition {
    if (fingeringPosition == 13) fingeringPosition = 1;
    if (fingeringPosition == 0) fingeringPosition = 12;
}

- (void)moveToWhichFingeringPostion {
//    NSLog(@"Determining which chord finger postion to go to %d", fingeringPosition);
    
    if (fingeringPosition == 1) [self moveFingersToC];
    if (fingeringPosition == 2) [self moveFingersToF];
    if (fingeringPosition == 3) [self moveFingersToASharp];
    if (fingeringPosition == 4) [self moveFingersToDSharp];
    if (fingeringPosition == 5) [self moveFingersToGSharp];
    if (fingeringPosition == 6) [self moveFingersToCSharp];
    if (fingeringPosition == 7) [self moveFingersToFSharp];
    if (fingeringPosition == 8) [self moveFingersToB];
    if (fingeringPosition == 9) [self moveFingersToE];
    if (fingeringPosition == 10) [self moveFingersToA];
    if (fingeringPosition == 11) [self moveFingersToD];
    if (fingeringPosition == 12) [self moveFingersToG];
    
}

- (void)chooseChordsToPlay {    // Changes chords for left, middle & right depending on chartPosition (1-12)
    if (chartPosition == 1) {
        self.audioPlayerLeft = self.audioPlayerG;
        self.audioPlayerMiddle = self.audioPlayerC;
        self.audioPlayerRight = self.audioPlayerF;
    }
    if (chartPosition == 2) {
        self.audioPlayerLeft = self.audioPlayerC;
        self.audioPlayerMiddle = self.audioPlayerF;
        self.audioPlayerRight = self.audioPlayerASharp;
    }
    if (chartPosition == 3) {
        self.audioPlayerLeft = self.audioPlayerF;
        self.audioPlayerMiddle = self.audioPlayerASharp;
        self.audioPlayerRight = self.audioPlayerDSharp;
    }    
    if (chartPosition == 4) {
        self.audioPlayerLeft = self.audioPlayerASharp;
        self.audioPlayerMiddle = self.audioPlayerDSharp;
        self.audioPlayerRight = self.audioPlayerGSharp;
    }
    if (chartPosition == 5) {
        self.audioPlayerLeft = self.audioPlayerDSharp;
        self.audioPlayerMiddle = self.audioPlayerGSharp;
        self.audioPlayerRight = self.audioPlayerCSharp;
    }
    if (chartPosition == 6) {
        self.audioPlayerLeft = self.audioPlayerGSharp;
        self.audioPlayerMiddle = self.audioPlayerCSharp;
        self.audioPlayerRight = self.audioPlayerFSharp;
    }
    if (chartPosition == 7) {
        self.audioPlayerLeft = self.audioPlayerCSharp;
        self.audioPlayerMiddle = self.audioPlayerFSharp;
        self.audioPlayerRight = self.audioPlayerB;
    }
    if (chartPosition == 8) {
        self.audioPlayerLeft = self.audioPlayerFSharp;
        self.audioPlayerMiddle = self.audioPlayerB;
        self.audioPlayerRight = self.audioPlayerE;
    }
    if (chartPosition == 9) {
        self.audioPlayerLeft = self.audioPlayerB;
        self.audioPlayerMiddle = self.audioPlayerE;
        self.audioPlayerRight = self.audioPlayerA;
    }
    if (chartPosition == 10) {
        self.audioPlayerLeft = self.audioPlayerE;
        self.audioPlayerMiddle = self.audioPlayerA;
        self.audioPlayerRight = self.audioPlayerD;
    }
    if (chartPosition == 11) {
        self.audioPlayerLeft = self.audioPlayerA;
        self.audioPlayerMiddle = self.audioPlayerD;
        self.audioPlayerRight = self.audioPlayerG;
    }
    if (chartPosition == 12) {
        self.audioPlayerLeft = self.audioPlayerD;
        self.audioPlayerMiddle = self.audioPlayerG;
        self.audioPlayerRight = self.audioPlayerC;
    }
 
}

#pragma mark - AVAudioPlayerDelegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"--------- ");           // Yeah we finished playing!!!  Now the next chord");
    
    if (playingChords || playingProgression) {
    // checks to see if array object is something (not nil) and plays next chord if it is something
        if (j < [self.chordsToPlay count]) {
            [self playNextChord];
            NSLog(@"Playing %@", [self.chordsToPlay objectAtIndex:j]);     
            j = j + 1;          
        } else {
            NSLog(@"Finished playing the progression");
            // Reset the counter to 0 if finished
            if (j == [self.chordsToPlay count]) {
                j = 0;
            }
            self.audioPlayerRecorder = self.audioPlayerStartSound;  
            playingChords = NO;
            playingProgression = NO;
            [self resetActionAction];
        }
    }
}

#pragma mark - move fingering methods

- (IBAction)moveToC:(UIButton *)sender {
    NSLog(@"Gonna try & play C"); 
    chartPosition = 1;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToC];
}

- (void)moveFingersToC {
    NSLog(@"Gonna try & move the fingers to C"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingC = YES;
    // Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
    // Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
// Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-100, 0);
     }
     completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-200, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-250, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerC play];
}

- (IBAction)moveToG:(UIButton *)sender {
    NSLog(@"Gonna try & play G");
    chartPosition = 12;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToG];
}

- (void)moveFingersToG {
    NSLog(@"Gonna try & move the fingers to G"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingG = YES;
    // Highlights fingers
    self.finger1.highlighted = NO;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = YES;
    // Defines which finger are used in this chord    
    finger1Used = NO;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = YES;
    
    // Moves fingers to proper positions  // Moves fingers to proper positions       
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-250, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
       self.finger3.transform = CGAffineTransformMakeTranslation(-300, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(-50, -64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerG play];
}

- (IBAction)moveToD:(UIButton *)sender {
    NSLog(@"Gonna try & play D");
    chartPosition = 11;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToD];
}

- (void)moveFingersToD {
    NSLog(@"Gonna try & move the fingers to D"); 

    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingD = YES;
    // Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
    // Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
// Moves fingers to proper positions      // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-150, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-50, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-100, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerD play];
}

- (IBAction)moveToA:(UIButton *)sender {
    NSLog(@"Gonna try & play A");
    chartPosition = 10;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToA];
}

- (void)moveFingersToA {
    NSLog(@"Gonna try & move the fingers to A"); 

    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingA = YES;
    // Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
    // Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
    // Moves fingers to proper positions      // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-200, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-150, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-100, -64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerA play];
}

- (IBAction)moveToE:(UIButton *)sender {
    NSLog(@"Gonna try & play E"); 
    chartPosition = 9;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToE];
}

- (void)moveFingersToE {
    NSLog(@"Gonna try & move the fingers to E"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingE = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
// Moves fingers to proper positions       
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-150, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-250, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-200, -64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerE play];
}


- (IBAction)moveToB:(UIButton *)sender {
    NSLog(@"Gonna try & play B"); 
    chartPosition = 8;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToB];
}

- (void)moveFingersToB {
    NSLog(@"Gonna try & move the fingers to B"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingB = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = YES;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = YES;
    
    // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-50, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-200, 128);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-150, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(-100, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerB play];
}

- (IBAction)moveToFSharp:(UIButton *)sender {
    NSLog(@"Gonna try & play F#");
    chartPosition = 7;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToFSharp];
}

- (void)moveFingersToFSharp {
    NSLog(@"Gonna try & move the fingers to F#"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingFSharp = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
    // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-75, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-150, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-200, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerFSharp play];
}

- (IBAction)moveToCSharp:(UIButton *)sender {
    NSLog(@"Gonna try & play C#");
    chartPosition = 6;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToCSharp];
}

- (void)moveFingersToCSharp {
    NSLog(@"Gonna try & move the fingers to C#"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingCSharp = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = YES;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = YES;
    
    // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-50, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-100, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-200, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(-250, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerCSharp play];
}

- (IBAction)moveToGSharp:(UIButton *)sender {
    NSLog(@"Gonna try & play G#");
    chartPosition = 5;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToGSharp];
}

- (void)moveFingersToGSharp {
    NSLog(@"Gonna try & move the fingers to G#"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingGSharp = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
    // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-75, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-150, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-200, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerGSharp play];
}

- (IBAction)moveToDSharp:(UIButton *)sender {
    NSLog(@"Gonna try & play D#");
    chartPosition = 4;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToDSharp];
}

- (void)moveFingersToDSharp {
    NSLog(@"Gonna try & move the fingers to D#"); 
   
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingDSharp = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = YES;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = YES;
    
    // Moves fingers to proper positions   
    NSLog(@"Gonna try & play D#");
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-50, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-100, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-200, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(-250, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerDSharp play];
}

- (IBAction)moveToASharp:(UIButton *)sender {
    NSLog(@"Gonna try & play A#");
    chartPosition = 3;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToASharp];
}

- (void)moveFingersToASharp {
    NSLog(@"Gonna try & move the fingers to A#"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingASharp = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = YES;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = YES;
    
    // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-50, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-200, 64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-150, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(-100, -64);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerASharp play];
}


- (IBAction)moveToF:(UIButton *)sender {
    NSLog(@"Gonna try & play F");
    chartPosition = 2;      //sets the key for the specific chord progression
    // And finally animate the fingers
    [self moveFingersToF];
}

- (void)moveFingersToF {
    NSLog(@"Gonna try & move the fingers to F"); 
    
    [self resetChordPlayed];
    [self chooseChordsToPlay];
    playingF = YES;
// Highlights fingers
    self.finger1.highlighted = YES;
    self.finger2.highlighted = YES;
    self.finger3.highlighted = YES;
    self.finger4.highlighted = NO;
// Defines which finger are used in this chord    
    finger1Used = YES;
    finger2Used = YES;
    finger3Used = YES;
    finger4Used = NO;
    
    // Moves fingers to proper positions   
    [UIView transitionWithView:self.finger1 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger1.transform = CGAffineTransformMakeTranslation(-75, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger2 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger2.transform = CGAffineTransformMakeTranslation(-150, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger3 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger3.transform = CGAffineTransformMakeTranslation(-200, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
    [UIView transitionWithView:self.finger4 duration: 0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^ {   
        self.finger4.transform = CGAffineTransformMakeTranslation(0, 0);
    }
                    completion:^(BOOL finished)
     { 
     }]; 
//    if (!tutorSwitch) [self.audioPlayerF play];
}

@end

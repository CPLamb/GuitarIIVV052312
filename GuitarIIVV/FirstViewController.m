//
//  FirstViewController.m
//  GuitarIIVV
//
//  Created by David Fierstein on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize m1Beat1;
@synthesize m1Beat2;
@synthesize m1Beat3;
@synthesize m1Beat4;
@synthesize m2Beat1;
@synthesize m2Beat2;
@synthesize m2Beat3;
@synthesize m2Beat4;
@synthesize v = _v;
@synthesize iv = _iv;
@synthesize i = _i;
@synthesize progressionOneFourFive = _progressionOneFourFive;
@synthesize recordedChords = _recordedChords;
@synthesize chordsToPlay = _chordsToPlay;

@synthesize recordingButton = _recordingButton;
@synthesize playingButton = _playingButton;

@synthesize leftChordView = _leftChordView;
@synthesize middleChordView = _middleChordView;
@synthesize rightChordView = _rightChordView;

@synthesize audioPlayerLeft = _audioPlayerLeft;

@dynamic chart, chartView;

#pragma mark - View Controller Setup methods 

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"Starting up the program ViewDidLoad");
    
	UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(chartSwipedLeft:)];
    UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(chartSwipedRight:)];
    //   tapGestureRecognizer.numberOfTapsRequired = 1;
    //    tapGestureRecognizer.enabled = YES;
    swipeGestureRecognizerLeft.cancelsTouchesInView = YES;
    swipeGestureRecognizerRight.cancelsTouchesInView = YES;
    [swipeGestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];   
    [swipeGestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    swipeGestureRecognizerLeft.numberOfTouchesRequired = 1;
    swipeGestureRecognizerRight.numberOfTouchesRequired = 1;
    [chartView addGestureRecognizer:swipeGestureRecognizerLeft];
    [chartView addGestureRecognizer:swipeGestureRecognizerRight];
    chart.transform = CGAffineTransformMakeRotation(0.0);
    [swipeGestureRecognizerLeft setDelegate:self];
    [swipeGestureRecognizerRight setDelegate:self];
    //    #define M_PI   3.14159265358979323846264338327950288;   /* pi */
    //   #define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI);
    
// Setup of AVAudioPlayer for sounds.  Done here because it takes time to config each audioPlayer
    // Left (V), Middle (I) & Right (IV) chord positions
    NSURL *urlLeft = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"12ChordF" ofType:@"mp3"]];
    self.audioPlayerLeft = [[AVAudioPlayer alloc] initWithContentsOfURL:urlLeft error:NULL];
    self.audioPlayerLeft.delegate = self;
    [self.audioPlayerLeft prepareToPlay];
    
    NSURL *urlMiddle = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01ChordC" ofType:@"mp3"]];
    audioPlayerMiddle = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMiddle error:NULL];
    audioPlayerMiddle.delegate = self;
    [audioPlayerMiddle prepareToPlay];
    
    NSURL *urlRight = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"02ChordG" ofType:@"mp3"]];
    audioPlayerRight = [[AVAudioPlayer alloc] initWithContentsOfURL:urlRight error:NULL];
    audioPlayerRight.delegate = self;
    [audioPlayerRight prepareToPlay];
    
    NSURL *urlStart = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"00StartSound" ofType:@"mp3"]];
    audioPlayerStartSound = [[AVAudioPlayer alloc] initWithContentsOfURL:urlStart error:NULL];
    audioPlayerStartSound.delegate = self;
    [audioPlayerStartSound prepareToPlay];

    // Recorder / Progression audioPlayer used to play recorded progressions
    NSURL *urlRecorder = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"00StartSound" ofType:@"mp3"]];
    audioPlayerRecorder = [[AVAudioPlayer alloc] initWithContentsOfURL:urlRecorder error:NULL];
    audioPlayerRecorder.delegate = self;
    [audioPlayerRecorder prepareToPlay];
    
    // Various initialized values & setup
    chartPosition = 1;
    j = 0;              // array index
    self.leftChordView.alpha = 0.0;
    self.leftChordView.transform = CGAffineTransformMakeRotation(-0.524);
    self.middleChordView.alpha = 0.0;
    self.rightChordView.alpha = 0.0;
    self.rightChordView.transform = CGAffineTransformMakeRotation(0.524);
    self.playingButton.enabled = NO;
    self.playingButton.adjustsImageWhenDisabled = YES;

    // Initialize the arrays
    chordsToPlay = [[NSMutableArray alloc] init];                              
    recordedChords = [[NSMutableArray alloc] init];               
    progressionOneFourFive = [[NSMutableArray alloc] initWithObjects:@"I", @"IV", @"V", @"I", nil];
//    NSLog(@"Array has %d objects", [chordsToPlay count]);
    // Sets up all of the positional audioPlayers with their chords
    [self setupAudioPlayers];
}

- (void)viewDidUnload
{
    //    [self setChartRotationLabel:nil];
    [self setM1Beat1:nil];
    [self setM1Beat2:nil];
    [self setM1Beat3:nil];
    [self setM1Beat4:nil];
    [self setM2Beat1:nil];
    [self setM2Beat2:nil];
    [self setM2Beat3:nil];
    [self setM2Beat4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.audioPlayerLeft = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight)) {    
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - AVAudioPlayer methods

- (void)setupAudioPlayers; {
    NSLog(@"Setting up the audio players");
    
// creates all 12 audioplayers
    NSURL *url01 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01ChordC" ofType:@"mp3"]];
    audioPlayer01 = [[AVAudioPlayer alloc] initWithContentsOfURL:url01 error:NULL];
    audioPlayer01.delegate = self;
    
    NSURL *url02 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"02ChordG" ofType:@"mp3"]];
    audioPlayer02 = [[AVAudioPlayer alloc] initWithContentsOfURL:url02 error:NULL];
    audioPlayer02.delegate = self;
    
    NSURL *url03 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"03ChordD" ofType:@"mp3"]];
    audioPlayer03 = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:NULL];
    audioPlayer03.delegate = self;
    
    NSURL *url04 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"04ChordA" ofType:@"mp3"]];
    audioPlayer04 = [[AVAudioPlayer alloc] initWithContentsOfURL:url04 error:NULL];
    audioPlayer04.delegate = self;
    
    NSURL *url05 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"05ChordE" ofType:@"mp3"]];
    audioPlayer05 = [[AVAudioPlayer alloc] initWithContentsOfURL:url05 error:NULL];
    audioPlayer05.delegate = self;
    
    NSURL *url06 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"06ChordB" ofType:@"mp3"]];
    audioPlayer06 = [[AVAudioPlayer alloc] initWithContentsOfURL:url06 error:NULL];
    audioPlayer06.delegate = self;
    
    NSURL *url07 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"07ChordF#" ofType:@"mp3"]];
    audioPlayer07 = [[AVAudioPlayer alloc] initWithContentsOfURL:url07 error:NULL];
    audioPlayer07.delegate = self;
    
    NSURL *url08 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"08ChordC#" ofType:@"mp3"]];
    audioPlayer08 = [[AVAudioPlayer alloc] initWithContentsOfURL:url08 error:NULL];
    audioPlayer08.delegate = self;
    
    NSURL *url09 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"09CHordG#" ofType:@"mp3"]];
    audioPlayer09 = [[AVAudioPlayer alloc] initWithContentsOfURL:url09 error:NULL];
    audioPlayer09.delegate = self;
   
    NSURL *url10 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"10ChordD#" ofType:@"mp3"]];
    audioPlayer10 = [[AVAudioPlayer alloc] initWithContentsOfURL:url10 error:NULL];
    audioPlayer10.delegate = self;
    
    NSURL *url11 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"11ChordA#" ofType:@"mp3"]];
    audioPlayer11 = [[AVAudioPlayer alloc] initWithContentsOfURL:url11 error:NULL];
    audioPlayer11.delegate = self;
   
    NSURL *url12 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"12ChordF" ofType:@"mp3"]];
    audioPlayer12 = [[AVAudioPlayer alloc] initWithContentsOfURL:url12 error:NULL];    
    audioPlayer12.delegate = self;
   
}

- (void)chooseChordsToPlay {    // Changes chords for left, middle & right depending on chartPosition (1-12)
    if (chartPosition == 1) {
        self.audioPlayerLeft = audioPlayer12;
        audioPlayerMiddle = audioPlayer01;
        audioPlayerRight = audioPlayer02;
    }
    if (chartPosition == 2) {
        self.audioPlayerLeft = audioPlayer01;
        audioPlayerMiddle = audioPlayer02;
        audioPlayerRight = audioPlayer03;
    }
    if (chartPosition == 3) {
        self.audioPlayerLeft = audioPlayer02;
        audioPlayerMiddle = audioPlayer03;
        audioPlayerRight = audioPlayer04;
    }
    if (chartPosition == 4) {
        self.audioPlayerLeft = audioPlayer03;
        audioPlayerMiddle = audioPlayer04;
        audioPlayerRight = audioPlayer05;
    }
    if (chartPosition == 5) {
        self.audioPlayerLeft = audioPlayer04;
        audioPlayerMiddle = audioPlayer05;
        audioPlayerRight = audioPlayer06;
    }
    if (chartPosition == 6) {
        self.audioPlayerLeft = audioPlayer05;
        audioPlayerMiddle = audioPlayer06;
        audioPlayerRight = audioPlayer07;
    }
    if (chartPosition == 7) {
        self.audioPlayerLeft = audioPlayer06;
        audioPlayerMiddle = audioPlayer07;
        audioPlayerRight = audioPlayer08;
    }
    if (chartPosition == 8) {
        self.audioPlayerLeft = audioPlayer07;
        audioPlayerMiddle = audioPlayer08;
        audioPlayerRight = audioPlayer09;
    }
    if (chartPosition == 9) {
        self.audioPlayerLeft = audioPlayer08;
        audioPlayerMiddle = audioPlayer09;
        audioPlayerRight = audioPlayer10;
    }
    if (chartPosition == 10) {
        self.audioPlayerLeft = audioPlayer09;
        audioPlayerMiddle = audioPlayer10;
        audioPlayerRight = audioPlayer11;
    }
    if (chartPosition == 11) {
        self.audioPlayerLeft = audioPlayer10;
        audioPlayerMiddle = audioPlayer11;
        audioPlayerRight = audioPlayer12;
    }
    if (chartPosition == 12) {
        self.audioPlayerLeft = audioPlayer11;
        audioPlayerMiddle = audioPlayer12;
        audioPlayerRight = audioPlayer01;
    }    
}

- (void)playNextChord {
//    NSLog(@"Now pick out the next chord from the array number %d", j);    
    [self select145ChordToPlay];

// Now play the chord
    [audioPlayerRecorder play];
}

- (void)select145ChordToPlay {
//    NSLog(@"Trying to select the correct chord for %@", [chordsToPlay objectAtIndex:j]);
    
// Selects the left (V), middle (I), right (IV) audioPlayer depending upon the value in the array object
    if ([chordsToPlay objectAtIndex:j] == @"V") {
//        NSLog(@"Chord V selected");
        audioPlayerRecorder = self.audioPlayerLeft;
        [self startLeftAnimation];
    } else {
        if ([chordsToPlay objectAtIndex:j] == @"I") {
//            NSLog(@"Chord I selected");
            audioPlayerRecorder = audioPlayerMiddle;
            [self startMiddleAnimation];
        } else {
            if ([chordsToPlay objectAtIndex:j] == @"IV") {
//                NSLog(@"Chord IV selected");
                audioPlayerRecorder = audioPlayerRight;
                [self startRightAnimation];
            } else {
                NSLog(@"COULD NoT FIND the chord???");
            }
        }
    }
}

#pragma mark - AVAudioPlayerDelegate methods

#pragma mark TODO change so that it only runs if played from either PLAY or Progression button
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    NSLog(@"Yeah we finished playing!!!  Now the next chord");
    
    if (playingChords || playingProgression) {
        // checks to see if array object is something (not nil) and plays next chord if it is something
        if (j < [chordsToPlay count]) {
            [self stopLeftAnimation];
            [self stopMiddleAnimation];
            [self stopRightAnimation];
            [self playNextChord];
            NSLog(@"Playing %@", [chordsToPlay objectAtIndex:j]);     
            j = j + 1;          
        } else {
            NSLog(@"Finished playing the progression");
            // Reset the counter to 0 if finished
            if (j == [chordsToPlay count]) {
                j = 0;
            }
            audioPlayerRecorder = audioPlayerStartSound;
            playingChords = NO;
            playingProgression = NO;
            [self stopLeftAnimation];
            [self stopMiddleAnimation];
            [self stopRightAnimation];
        }
    }
}

#pragma mark - View buttons & gesture methods

- (IBAction)recordChordsButton:(UIButton *)sender {

// Toggles recordingChords status/button ON/OFF
    if (recordingChords) {
        NSLog(@"Stopped Recording!!!!");
        recordingChords = NO;
        self.recordingButton.highlighted = NO;
        NSLog(@"This progression was recorded %@", recordedChords);

//Load up the display labels with the 1st 2 measures of chords
//        [self display145ChordInMeasure];
    } else {
        NSLog(@"Started Recording!!!!");
        recordingChords = YES;  
        self.recordingButton.highlighted = YES;
    }
// Enables the PLAY button if the array is NOT empty (otherwise CRASH)
    if ([recordedChords count] > 0) {
        self.playingButton.enabled = YES;
    } 
}

- (IBAction)playChordsButton:(UIButton *)sender {
    
// Toggles playingChords status/button
    if (!playingChords) {
        NSLog(@"Started Playing!!!!");
        playingChords = YES; 
        playingButton.highlighted = YES;
    }    
// set chordsToPlay array then goto select chords
    [chordsToPlay setArray:recordedChords];                          

    [audioPlayerRecorder play];
    [self select145ChordToPlay];
}

- (IBAction)clearButton:(UIButton *)sender {
    NSLog(@"Clear recordedChords array");
    [recordedChords removeAllObjects];
    NSLog(@"array is comprised of %@", recordedChords);
    
// Sets PLAY button to disabled when array is empty
    self.playingButton.enabled = NO;
    self.playingButton.adjustsImageWhenDisabled = YES;
    
// Empties the display strings
    m1Beat1.text = @""; 
    m1Beat2.text = @""; 
    m1Beat3.text = @""; 
    m1Beat4.text = @""; 

    m2Beat1.text = @""; 
    m2Beat2.text = @""; 
    m2Beat3.text = @""; 
    m2Beat4.text = @"";   
}

- (void)display145ChordInMeasure:(NSString *)chord {
//    NSLog(@"Increments the display of chords in the measures");
    m2Beat4.text = m2Beat3.text;
    m2Beat3.text = m2Beat2.text;
    m2Beat2.text = m2Beat1.text;
    m2Beat1.text = m1Beat4.text;

    m1Beat4.text = m1Beat3.text;
    m1Beat3.text = m1Beat2.text;
    m1Beat2.text = m1Beat1.text;
    m1Beat1.text = chord;
    
    
/*    if ([recordedChords count] > 6) {    
        m1Beat1.text = [recordedChords objectAtIndex:0];
        m1Beat2.text = [recordedChords objectAtIndex:1];
        m1Beat3.text = [recordedChords objectAtIndex:2];
        m1Beat4.text = [recordedChords objectAtIndex:3];

        m2Beat1.text = [recordedChords objectAtIndex:4];
        m2Beat2.text = [recordedChords objectAtIndex:5];
        m2Beat3.text = [recordedChords objectAtIndex:6];
        m2Beat4.text = [recordedChords objectAtIndex:7];
 }
*/
}


#pragma mark -

- (IBAction)leftChordButton:(UIButton *)sender {
    
//    NSLog(@"Left Chord V Pressed");
    [self.audioPlayerLeft stop];
    self.audioPlayerLeft.currentTime = 0;
    [self.audioPlayerLeft play];
    
// Adds to the recorder array if recording is ON
    if (recordingChords) {
        [recordedChords addObject:@"V"];                      
//        NSLog(@"Added V to the array m%dBeat%d", j, j);
        [self display145ChordInMeasure:@"V"];
    }
}

- (IBAction)leftChordStopButton:(UIButton *)sender {
//    NSLog(@"Stops sound, and resets to time = 0"); 
//    audioPlayerLeft.currentTime = 0;
//    [audioPlayerLeft stop];
}

- (IBAction)middleChordButton:(UIButton *)sender {
    
//    NSLog(@"Middle Chord I Pressed");
    [audioPlayerMiddle stop];
    audioPlayerMiddle.currentTime = 0;
    [audioPlayerMiddle play];
    
    // Adds to the recorder array if recording is ON
    if (recordingChords) {
        [recordedChords addObject:@"I"];
//        NSLog(@"Added I to the array m%dBeat%d", j, j);
        [self display145ChordInMeasure:@"I"];
    }   
}

- (IBAction)middleChordStopButton:(UIButton *)sender {
//    NSLog(@"Stops sound, and resets to time = 0"); 
//    audioPlayerMiddle.currentTime = 0;
//    [audioPlayerMiddle stop];
}

- (IBAction)rightChordButton:(UIButton *)sender {
    
//    NSLog(@"Right Chord IV Pressed");
    [audioPlayerRight stop];
    audioPlayerRight.currentTime = 0;
    [audioPlayerRight play];
    
    // Adds to the recorder array if recording is ON
    if (recordingChords) {
        [recordedChords addObject:@"IV"];
//        NSLog(@"Added IV to the array m%dBeat%d", j, j);
        [self display145ChordInMeasure:@"IV"];
    }    
}

- (IBAction)rightChordStopButton:(UIButton *)sender {
//    NSLog(@"Stops sound, and resets to time = 0"); 
//    audioPlayerRight.currentTime = 0;
//    [audioPlayerRight stop];
}

- (IBAction)playChordProgressionButton:(UIButton *)sender {
    
    playingProgression = YES;
// set chordsToPlay array then goto select chords
    [chordsToPlay setArray:progressionOneFourFive];
    NSLog(@"Playing the progression %@", chordsToPlay);
    
    [audioPlayerRecorder play];   //This is that first sound that we DON'T want
    [self select145ChordToPlay];
}

-(IBAction)chartSwipedLeft: (UISwipeGestureRecognizer *)swipeGestureLeft
{
    chart.transform = CGAffineTransformMakeRotation(chartRotation);
    chartRotation -= 0.523598775598297; 
    
// Chart position is used to select proper sound file, also reset number to 1  
    chartPosition += 1;
    if (chartPosition == 13) {
        chartPosition = 1;
    }
    NSLog(@"swiped left, chartRot: %d", chartPosition);

// Resets which chords are attached to the left, middle, right portions    
    [self chooseChordsToPlay];
    
    [UIView transitionWithView:chartView
                      duration: 0.2
                       options: UIViewAnimationOptionCurveEaseInOut
                    animations:^ 
     {  
         //CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
         
         //anim.toValue = [NSNumber numberWithFloat:chartRotation ];
         //[chart.layer addAnimation:anim forKey:@"rotationAnimation"];
         chart.transform = CGAffineTransformMakeRotation(chartRotation);
     }
                    completion:^(BOOL finished)
     { 
         chart.transform = CGAffineTransformMakeRotation(chartRotation);         
     }];
}

-(IBAction)chartSwipedRight: (UISwipeGestureRecognizer *)swipeGestureRight
{
    /*   for (UIGestureRecognizer *recognizer in chart.gestureRecognizers)
     {
     NSLog(@"%@", recognizer);
     if (recognizer.state == UIGestureRecognizerStatePossible)
     { 
     NSLog(@"begin of state");
     }
     }*/
    chart.transform = CGAffineTransformMakeRotation(chartRotation);
    chartRotation += 0.523598775598297; 
    
// Chart position is used to select proper sound file, also reset number to 12   
    chartPosition -= 1;
    if (chartPosition == 0) {
        chartPosition = 12;
    }
    NSLog(@"swiped right, chartRot: %d", chartPosition);
    [self chooseChordsToPlay];
    //    audioPlayerMiddle = audioPlayerLeft;
    
    [UIView transitionWithView:chartView
                      duration: 0.2
                       options: UIViewAnimationOptionCurveEaseInOut
                    animations:^ 
     {   
         chart.transform = CGAffineTransformMakeRotation(chartRotation);
     }
                    completion:^(BOOL finished)
     { 
         chart.transform = CGAffineTransformMakeRotation(chartRotation); 
     }];    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)swipeRecognizerLeft shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)swipeRecognizerRight {
    return NO;
}

#pragma mark - animation methods

- (void)startLeftAnimation {
    [UIView transitionWithView:self.leftChordView
                      duration: 1.0
                       options: UIViewAnimationOptionCurveEaseInOut
                    animations:^ {   
                        self.leftChordView.alpha = 0.25;
                        self.leftChordView.transform = CGAffineTransformMakeRotation(-3.0);
                        self.leftChordView.transform = CGAffineTransformMakeScale(3.0, 1.5);
                    }
                    completion:^(BOOL finished) { 
     }];    
}

- (void)stopLeftAnimation {
    self.leftChordView.alpha = 0.0;
    self.leftChordView.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

- (void)startMiddleAnimation {
    [UIView transitionWithView:self.middleChordView
                      duration: 1.5
                       options: UIViewAnimationOptionCurveEaseInOut
                    animations:^ {   
                        self.middleChordView.alpha = 0.25;
                        self.middleChordView.transform = CGAffineTransformMakeScale(2.5, 2.5);
                    }
                    completion:^(BOOL finished) { 
                    }];    
}

- (void)stopMiddleAnimation {
    self.middleChordView.alpha = 0.0;
    self.middleChordView.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

- (void)startRightAnimation {
    [UIView transitionWithView:self.rightChordView
                      duration: 1.5
                       options: UIViewAnimationOptionCurveEaseInOut
                    animations:^ {   
                        self.rightChordView.alpha = 0.25;
                        self.rightChordView.transform = CGAffineTransformMakeRotation(3.0);
                        self.rightChordView.transform = CGAffineTransformMakeScale(3.0, 1.5);
                    }
                    completion:^(BOOL finished) { 
                    }];    
}

- (void)stopRightAnimation {
    self.rightChordView.alpha = 0.0;
    self.rightChordView.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

@end

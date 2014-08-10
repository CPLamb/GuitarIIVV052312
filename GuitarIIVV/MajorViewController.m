//
//  MajorViewController.m
//  GuitarIIVV
//
//  Created by Wormhole on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MajorViewController.h"

@interface MajorViewController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer01;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer02;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer03;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer04;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer05;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer06;

@end

@implementation MajorViewController

#pragma mark - synthesize properties
@synthesize audioPlayerLeft = _audioPlayerLeft;
@synthesize audioPlayerMiddle = _audioPlayerMiddle;
@synthesize audioPlayerRight = _audioPlayerRight;

@synthesize audioPlayer01 = _audioPlayer01;
@synthesize audioPlayer02 = _audioPlayer02;
@synthesize audioPlayer03 = _audioPlayer03;
@synthesize audioPlayer04 = _audioPlayer04;
@synthesize audioPlayer05 = _audioPlayer05;
@synthesize audioPlayer06 = _audioPlayer06;

@synthesize m1Beat1 = _m1Beat1;
@synthesize m1Beat2 = _m1Beat2;
@synthesize m1Beat3 = _m1Beat3;
@synthesize m1Beat4 = _m1Beat4;
@synthesize m2Beat1 = _m2Beat1;
@synthesize m2Beat2 = _m2Beat2;
@synthesize m2Beat3 = _m2Beat3;
@synthesize m2Beat4 = _m2Beat4;


#pragma mark - view setup methods

- (void)viewDidLoad
{
    [super viewDidLoad];

// Setup for swipe gesture recognizer
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
    [self.view addGestureRecognizer:swipeGestureRecognizerLeft];
    [self.view addGestureRecognizer:swipeGestureRecognizerRight];
    self.view.transform = CGAffineTransformMakeRotation(0.0);
    [swipeGestureRecognizerLeft setDelegate:self];
    [swipeGestureRecognizerRight setDelegate:self];
    //    #define M_PI   3.14159265358979323846264338327950288;   /* pi */
    //   #define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI);
	
// Setup of Left (V), Middle (I) & Right (IV) chords
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

// Sets up all 48 possible audioPlayers with their chords
    [self setupAudioPlayers];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight)) {    
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - View gestures & buttons

- (IBAction)leftChordButton:(UIButton *)sender {    
    NSLog(@"Left Chord V Pressed");
    [self.audioPlayerLeft stop];
    self.audioPlayerLeft.currentTime = 0;
    [self.audioPlayerLeft play];
/*    
    // Adds to the recorder array if recording is ON
    if (recordingChords) {
        [recordedChords addObject:@"V"];                      
        //        NSLog(@"Added V to the array m%dBeat%d", j, j);
        [self display145ChordInMeasure:@"V"];
    }
*/ 
}

- (IBAction)middleChordButton:(UIButton *)sender {    
    NSLog(@"Middle Chord I Pressed");
    [self.audioPlayerMiddle stop];
    self.audioPlayerMiddle.currentTime = 0;
    [self.audioPlayerMiddle play];
/*    
    // Adds to the recorder array if recording is ON
    if (recordingChords) {
        [recordedChords addObject:@"I"];
        //        NSLog(@"Added I to the array m%dBeat%d", j, j);
        [self display145ChordInMeasure:@"I"];
    }   
*/    
}

- (IBAction)rightChordButton:(UIButton *)sender {    
    NSLog(@"Right Chord IV Pressed");
    [self.audioPlayerRight stop];
    self.audioPlayerRight.currentTime = 0;
    [self.audioPlayerRight play];
/*    
    // Adds to the recorder array if recording is ON
    if (recordingChords) {
        [recordedChords addObject:@"IV"];
        //        NSLog(@"Added IV to the array m%dBeat%d", j, j);
        [self display145ChordInMeasure:@"IV"];
    }    
*/    
}

-(IBAction)chartSwipedLeft: (UISwipeGestureRecognizer *)swipeGestureLeft {
    NSLog(@"Swiping Left");
/*    
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
*/ 
}

-(IBAction)chartSwipedRight: (UISwipeGestureRecognizer *)swipeGestureRight {
    NSLog(@"Swiping Right");
/*    

       for (UIGestureRecognizer *recognizer in chart.gestureRecognizers)
     {
     NSLog(@"%@", recognizer);
     if (recognizer.state == UIGestureRecognizerStatePossible)
     { 
     NSLog(@"begin of state");
     }
     }
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
*/    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)swipeRecognizerLeft shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)swipeRecognizerRight {
    return NO;
}

#pragma mark - AVAudioPlayer methods

- (void)setupAudioPlayers; {
    NSLog(@"Setting up the audio players");
    
    // creates all 12 audioplayers
    NSURL *url01 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01ChordC" ofType:@"mp3"]];
    self.audioPlayer01 = [[AVAudioPlayer alloc] initWithContentsOfURL:url01 error:NULL];
    self.audioPlayer01.delegate = self;
    
    NSURL *url02 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"02ChordG" ofType:@"mp3"]];
    self.audioPlayer02 = [[AVAudioPlayer alloc] initWithContentsOfURL:url02 error:NULL];
    self.audioPlayer02.delegate = self;
    
    NSURL *url03 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"03ChordD" ofType:@"mp3"]];
    self.audioPlayer03 = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:NULL];
    self.audioPlayer03.delegate = self;
    
    NSURL *url04 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"04ChordA" ofType:@"mp3"]];
    self.audioPlayer04 = [[AVAudioPlayer alloc] initWithContentsOfURL:url04 error:NULL];
    self.audioPlayer04.delegate = self;
    
    NSURL *url05 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"05ChordE" ofType:@"mp3"]];
    self.audioPlayer05 = [[AVAudioPlayer alloc] initWithContentsOfURL:url05 error:NULL];
    self.audioPlayer05.delegate = self;
    
    NSURL *url06 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"06ChordB" ofType:@"mp3"]];
    self.audioPlayer06 = [[AVAudioPlayer alloc] initWithContentsOfURL:url06 error:NULL];
    self.audioPlayer06.delegate = self;
/*    
    NSURL *url07 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"07ChordF#" ofType:@"mp3"]];
    audioPlayer07 = [[AVAudioPlayer alloc] initWithContentsOfURL:url07 error:NULL];
    audioPlayer07.delegate = self;
    
    NSURL *url08 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"08ChordC#" ofType:@"mp3"]];
    audioPlayer08 = [[AVAudioPlayer alloc] initWithContentsOfURL:url08 error:NULL];
    audioPlayer08.delegate = self;
        
     NSURL *url09 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"09ChordG#" ofType:@"mp3"]];
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
*/    
}

#pragma mark - Miscellaneous methods




@end

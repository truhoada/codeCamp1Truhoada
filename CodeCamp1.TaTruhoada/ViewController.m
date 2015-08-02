//
//  ViewController.m
//  CodeCamp1.TaTruhoada
//
//  Created by admin on 8/1/15.
//  Copyright (c) 2015 hoangdangtrung. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController (){
    NSTimer *_timer;
    UIImageView *cow;
    UIImageView *windmills;
    UIImageView *windmills2;
    UIImageView *dutchLady;
    UIImageView *dutchLadyReturn;
    UIImageView *cloud;
    UIImageView *sun;
}

@end

@implementation ViewController {
    AVAudioPlayer* audioCow;
    AVAudioPlayer* audioDutchLadyWalking;
    AVAudioPlayer* audioDutchLadyTalk;
    
}
-(void) loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* Run Functions */
    [self animateCloudShadows];
    [self animateSun];
    [self animateWindmills2];
    [self animateWindmills];
    [self animateDutchLady];
    [self animateCloud];
    [self animateCowEatGrass];
    [self playSoundCow];
    [self playSoundDutchLadyTalk];
    
    /* User Timer */
    _timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(playSoundCow) userInfo:nil repeats:1];
    _timer = [NSTimer scheduledTimerWithTimeInterval:22 target:self selector:@selector(playSoundDutchLadyTalk) userInfo:nil repeats:1];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:17 target:self selector:@selector(animateDutchLady) userInfo:nil repeats:1];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(animateCowEatGrass) userInfo:nil repeats:1]; // Refesh To The Cow show in front of The Dutch Lady
    _timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(animateCloud) userInfo:nil repeats:1];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(animateCloudShadows) userInfo:nil repeats:1];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(playSoundDutchLadyWalking) userInfo:nil repeats:1];

}

- (void) viewWillDisappear:(BOOL)animated {
    [audioCow stop];
}


/* Sun Animation  */
- (void) animateSun {
    sun = [[UIImageView alloc]initWithFrame:CGRectMake(18, 20, 249/3, 237/3)];
    NSMutableArray *imageSun = [[NSMutableArray alloc] initWithCapacity:8];
    for (int i=0; i<8; i++) {
        NSString *fileNameSunImage;
        fileNameSunImage = [NSString stringWithFormat:@"sun%d.png",i];
        [imageSun addObject:[UIImage imageNamed:fileNameSunImage]];
    }
    sun.animationImages = imageSun;
    sun.animationDuration = 1;
//    sun.animationRepeatCount = 0;
    [self.view addSubview:sun];
    [sun startAnimating];
}


/* Cloud Animation */
- (void) animateCloud {
    cloud = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 600, 80)];
    cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"createCloud"]];
    cloud.center = CGPointMake(600, 70);
    [self.view addSubview:cloud];
    cloud.alpha = 0.8;
    
    [UIView animateKeyframesWithDuration:20 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
        cloud.center = CGPointMake(-320, 60);
        cloud.alpha = 0.5;
    } completion:nil];
    
}

- (void) animateCloudShadows {
    cloud = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 600, 80)];
    cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"createCloudSuperBlack"]];
    cloud.center = CGPointMake(600, self.view.bounds.size.height-150);
    cloud.alpha = 0.2;
    [self.view addSubview:cloud];
    [UIView animateKeyframesWithDuration:20 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
        cloud.center = CGPointMake(-320, self.view.bounds.size.height-130);
    } completion:nil];
    
}




/* Cow eat Grass Animation */
- (void) animateCowEatGrass {
    cow = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height - 90, 113, 80)];
    [cow setUserInteractionEnabled:YES]; // For User interaction enabled (Touch/Tap)
    UITapGestureRecognizer *tapCow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCow:)];
    [tapCow setNumberOfTouchesRequired:1]; //Set Number of Touches Required
    [cow addGestureRecognizer:tapCow];
    
    UITapGestureRecognizer *tapCowDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCowDouble:)];
    tapCowDouble.numberOfTapsRequired = 2;
    [cow addGestureRecognizer: tapCowDouble];
    [tapCow requireGestureRecognizerToFail:tapCowDouble];
    
    NSMutableArray *imageCow = [[NSMutableArray alloc] initWithCapacity:6];
    for (int i=0; i<6; i++) {
        NSString *fileNameCowImage;
        fileNameCowImage = [NSString stringWithFormat:@"cow%d.png",i];
        [imageCow addObject:[UIImage imageNamed:fileNameCowImage]];
    }
    cow.animationImages = imageCow;
    cow.animationDuration = 0.8;
    cow.animationRepeatCount = 1; // not repeat
    [self.view addSubview:cow];
    [cow startAnimating];
}

- (void) tapCow:(id)sender {    // Cow sound
    [self playSoundCow];
}

- (void) tapCowDouble: (id)sender {
    [self playSoundDutchLadyTalk];
}
/* Cow Sound */
- (void) playSoundCow {
    NSString* filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"cowAudio" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioCow = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                      error:&error];
    [audioCow prepareToPlay];
    [audioCow play];
}

/* Dutch Lady Sound */
- (void) playSoundDutchLadyWalking {
    NSString* filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"dutchLadySoundWalking" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioDutchLadyWalking = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                            error:&error];
    [audioDutchLadyWalking prepareToPlay];
    [audioDutchLadyWalking play];
}



/* Dutch Lady Sound */
- (void) playSoundDutchLadyTalk {
    NSString* filePath;
    int i = arc4random_uniform(5);
    filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"dutchLadySound%d",i] ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioDutchLadyTalk = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                      error:&error];
    [audioDutchLadyTalk prepareToPlay];
    [audioDutchLadyTalk play];
}

/* Windmills Animation 1 */
- (void) animateWindmills {
    windmills = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-200, self.view.bounds.size.height-350, 279*3/5, 352*3/5)];
    NSMutableArray *imageWindmills = [[NSMutableArray alloc] initWithCapacity:8];
    for (int i=0; i<8; i++) {
        NSString *fileNameWindmillsImage;
        fileNameWindmillsImage = [NSString stringWithFormat:@"windmillsbig%d.png",i];
        [imageWindmills addObject:[UIImage imageNamed:fileNameWindmillsImage]];
    }
    windmills.animationImages = imageWindmills;
    windmills.animationDuration = 0.5;
    windmills.animationRepeatCount = 0;
    [self.view addSubview:windmills];
    [windmills startAnimating];
}

/* Windmills Animation 2 */
- (void) animateWindmills2 {
    windmills2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/7, self.view.bounds.size.height-300, 279/4, 352/4)];
    NSMutableArray *imageWindmills2 = [[NSMutableArray alloc] initWithCapacity:8];
    for (int i=0; i<8; i++) {
        NSString *fileNameWindmillsImage2;
        fileNameWindmillsImage2 = [NSString stringWithFormat:@"windmills1%d.png",i];
        [imageWindmills2 addObject:[UIImage imageNamed:fileNameWindmillsImage2]];
    }
    windmills2.animationImages = imageWindmills2;
    windmills2.animationDuration = 0.5;
//    windmills2.animationRepeatCount = 0; // Default Repeat, don't need code
    [self.view addSubview:windmills2];
    [windmills2 startAnimating];
}


/* Dutch Lady Animation */
- (void) animateDutchLady {
    dutchLady = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-200, self.view.bounds.size.height-100, 100, 125)];
    dutchLadyReturn = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-200, self.view.bounds.size.height-100, 100, 125)];
    
    dutchLady.center = CGPointMake(-20, self.view.bounds.size.height-100);
    dutchLadyReturn.center = CGPointMake(self.view.bounds.size.width+45, self.view.bounds.size.height-100);

//    [dutchLady setUserInteractionEnabled:YES]; // For User interaction enabled (Touch/Tap)
//    UITapGestureRecognizer *tapDutchLady = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDutchLady:)];
//    [tapDutchLady setNumberOfTouchesRequired:1]; //Set Number of Touches Required
//    [dutchLady addGestureRecognizer:tapDutchLady];

    
    NSMutableArray *imageDutchLady = [[NSMutableArray alloc] initWithCapacity:8];
    NSMutableArray *imageDutchLadyReturn = [[NSMutableArray alloc] initWithCapacity:8];
    
    for (int i=0; i<8; i++) {
        NSString *fileNameDutchLadyImage;
        NSString *fileNameDutchLadyReturnImage;

        fileNameDutchLadyImage = [NSString stringWithFormat:@"dutchLady%d.png",i];
        fileNameDutchLadyReturnImage = [NSString stringWithFormat:@"dutchLady1%d.png",i];

        [imageDutchLady addObject:[UIImage imageNamed:fileNameDutchLadyImage]];
        [imageDutchLadyReturn addObject:[UIImage imageNamed:fileNameDutchLadyReturnImage]];

    }
    
    dutchLady.animationImages = imageDutchLady;
    dutchLadyReturn.animationImages = imageDutchLadyReturn;
    
    dutchLady.animationDuration = 1;
    dutchLadyReturn.animationDuration = 1;
    
//    dutchLady.animationRepeatCount = 0; 
//    dutchLadyReturn.animationRepeatCount = 0;
    
    [self.view addSubview:dutchLady];
    [self.view addSubview:dutchLadyReturn];
    
    [dutchLady startAnimating];
    [dutchLadyReturn startAnimating];
    
    [UIView animateWithDuration:10 animations:^{
        dutchLady.center = CGPointMake(self.view.bounds.size.width+45, self.view.bounds.size.height-100);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:6 animations:^{
            dutchLadyReturn.center = CGPointMake(-45, self.view.bounds.size.height-100);
        }];
    }];
}

//-(void) tapDutchLady: (id)sender {
//    [self playSoundDutchLadyTalk];
//}

@end




















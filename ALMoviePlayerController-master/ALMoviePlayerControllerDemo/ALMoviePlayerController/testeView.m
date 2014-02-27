//
//  testeView.m
//  ALMoviePlayerController
//
//  Created by Hannah Lisbôa on 20/02/14.
//  Copyright (c) 2014 Anthony Lobianco. All rights reserved.
//

#import "testeView.h"
#import "ALMoviePlayerController.h"
#import "RatingView.h"
#import "videotecaBar.h"
@interface testeView () <ALMoviePlayerControllerDelegate>

@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;
@property (readwrite, strong) UIButton *fullScreenButton;
@property (nonatomic) CGRect defaultFrame;


@end

@implementation testeView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[ UIDevice currentDevice ] beginGeneratingDeviceOrientationNotifications ];
    [[ NSNotificationCenter defaultCenter ]
     addObserver : self selector : @selector ( orientationChanged :)
     name : UIDeviceOrientationDidChangeNotification
     object :[ UIDevice currentDevice ]];
   
//    [super viewDidLoad];
//    self.pagesContainer = [[DAPagesContainer alloc] init];
//    [self.pagesContainer willMoveToParentViewController:self];
//    self.pagesContainer.view.frame = self.view.bounds;
//    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.barraTema addSubview:self.pagesContainer.view];
//    [self.pagesContainer didMoveToParentViewController:self];
    

    
    // create a movie player
    self.moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:self.testePlayer.frame];
    self.moviePlayer.delegate = self; //IMPORTANT!
    
    // create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleDefault];
    
    // optionally customize the controls here...
    /*
     [movieControls setBarColor:[UIColor colorWithRed:195/255.0 green:29/255.0 blue:29/255.0 alpha:0.5]];
     [movieControls setTimeRemainingDecrements:YES];
     [movieControls setFadeDelay:2.0];
     [movieControls setBarHeight:100.f];
     [movieControls setSeekRate:2.f];
     */
    
    [movieControls setBarHeight:47.0];

    
    // assign the controls to the movie player
    [self.moviePlayer setControls:movieControls];
    
    // add movie player to your view
    [self.view addSubview:self.moviePlayer.view];
    
    //set contentURL (this will automatically start playing the movie)
    [self.moviePlayer setContentURL:[NSURL URLWithString:@"http://xxxdnn2003.locaweb.com.br/videotest.mp4"]];
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.starRatingView = [[RatingView alloc] initWithFrame:self.rating.frame
                                          selectedImageName:@"selected.png"
                                        unSelectedImage:@"unSelected.png"
                                               minValue:0
                                               maxValue:5
                                          intervalValue:1
                                             stepByStep:YES];
    self.starRatingView.delegate = self;
    [self.view addSubview:self.starRatingView];
    
    //valor inicial do componente
    [self.starRatingView setValue:3];

    
//
//    RatingView *RV0 = [[RatingView alloc] initWithFrame:CGRectMake(60, 150, 200, 40)
//                                      selectedImageName:@"selected.png"
//                                        unSelectedImage:@"unSelected.png"
//                                               minValue:0
//                                               maxValue:5
//                                          intervalValue:0.5
//                                             stepByStep:YES];
//    RV0.delegate = self;
//    [self.view addSubview:RV0];
//    
//    RatingView *RV1 = [[RatingView alloc] initWithFrame:CGRectMake(60, 250, 200, 40)
//                                      selectedImageName:@"selected.png"
//                                        unSelectedImage:@"unSelected.png"
//                                               minValue:0
//                                               maxValue:10
//                                          intervalValue:0.5
//                                             stepByStep:NO];
//    RV1.delegate = self;
//    [self.view addSubview:RV1];
//    
//    RatingView *RV2 = [[RatingView alloc] initWithFrame:CGRectMake(60, 350, 200, 40)
//                                      selectedImageName:@"selected.png"
//                                        unSelectedImage:@"unSelected.png"
//                                               minValue:0
//                                               maxValue:2
//                                          intervalValue:0.5
//                                             stepByStep:NO];
//    RV2.delegate = self;
//    [self.view addSubview:RV2];
}


//-(void)starRatingView:(TQStarRatingView *)view score:(float)score
//{
//    self.score.text = [NSString stringWithFormat:@"%0.2f",score * 10 ];
//}
- (IBAction)increaseRating:(id)sender
{
    self.starRatingView.value = 0;
    
  
}


- (void)rateChanged:(RatingView *)ratingView
{
    self.score.text = [NSString stringWithFormat:@"%0.2f",ratingView.value ];
 }




- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            /* start special animation */
            //[self.moviePlayer.controls scalePressed: _fullScreenButton];

            break;
        case UIDeviceOrientationLandscapeLeft:
            [self.moviePlayer.controls fullscreenPressed:_fullScreenButton];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            /* start special animation */
            break;
            
        default:
            break;
    };
}

- (void)moviePlayerWillMoveFromWindow {
    if (![self.view.subviews containsObject:self.moviePlayer.view])
        [self.view addSubview:self.moviePlayer.view];
    
    //[self.moviePlayer setFrame:_defaultFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btNext:(id)sender {
    
    videotecaBar *intent = [[videotecaBar alloc]init];
    [self presentViewController:intent animated:YES completion:nil];
    

}
@end

//
//  ViewController.m
//  ALMoviePlayerController
//
//  Created by Anthony Lobianco on 10/8/13.
//  Copyright (c) 2013 Anthony Lobianco. All rights reserved.
//

#import "ViewController.h"
#import "ALMoviePlayerController.h"

#define deg2rad (3.1415926/180.0)
 #define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ViewController () <ALMoviePlayerControllerDelegate>

@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;
@property (nonatomic) CGRect defaultFrame;
@property (readwrite, strong) UIButton *fullScreenButton;

@end

@implementation ViewController

BOOL _statusBarHidden;

BOOL _flaggotofull;



- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}


- (id)init {
    self = [super init];
    if (self) {
        //self.title = NSLocalizedString(@"ALMoviePlayerController", @"ALMoviePlayerController");
    }
    return self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Local File" style:UIBarButtonItemStyleBordered target:self action:@selector(localFile)];
//    self.navigationItem.leftBarButtonItem.enabled = NO;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Remote File" style:UIBarButtonItemStyleBordered target:self action:@selector(remoteFile)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    //seta flag
    _flaggotofull =NO;
    
    
    
    
    //add navigatorbar resolver problema de compatibilidade com o IOS 7 -
    
    navBar = [[self navigationController] navigationBar];
    navBar.translucent = NO;
    [navBar setBackgroundImage:[UIImage imageNamed:@"topbarra.png"] forBarMetrics:UIBarMetricsDefault];

    
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    
        /// add button full
    
    _fullScreenButton = [[UIButton alloc] initWithFrame:(CGRectMake(300.0, 225.0, 15, 15))];
    
    [_fullScreenButton setBackgroundImage:[UIImage imageNamed:@"fullscreen-button"] forState:UIControlStateNormal];
    
    [_fullScreenButton setShowsTouchWhenHighlighted:YES];
    
    [_fullScreenButton addTarget:self action:@selector(gotofull) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_fullScreenButton];
    
    
    
    // imagem de teste
    
//    UIImageView *corpo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"corpo.png"]];
//    
//    [corpo setFrame:(CGRectMake(0, 218.0, 320, 300))];
//    
//    [self.view addSubview:corpo];
    
    
    //create a player
    self.moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    
    self.moviePlayer.view.alpha = 0.f;
    self.moviePlayer.delegate = self; //IMPORTANT!
    
    //create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleDefault];
    //[movieControls setAdjustsFullscreenImage:NO];
    [movieControls setBarColor:[UIColor colorWithWhite:0.000 alpha:0.200]];
    [movieControls setTimeRemainingDecrements:YES];
    //[movieControls setFadeDelay:2.0];
    //[movieControls setBarHeight:100.f];
    //[movieControls setSeekRate:2.f];
    
    //assign controls
    [self.moviePlayer setControls:movieControls];
    [self.view addSubview:self.moviePlayer.view];
    
    //THEN set contentURL
    [self.moviePlayer setContentURL:[NSURL URLWithString:@"http://archive.org/download/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto-HawaiianHoliday1937-Video.mp4"]];
    
    //delay initial load so statusBarOrientation returns correct value
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self configureViewForOrientation:[UIApplication sharedApplication].statusBarOrientation];
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            self.moviePlayer.view.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.navigationItem.leftBarButtonItem.enabled = YES;
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }];
    });

    
}



-(void)gotofull{
    
    _flaggotofull =YES;
    // esconde navigator
    navBar.hidden = YES;


    //gira a tela
    self.view.transform=CGAffineTransformMakeRotation(deg2rad* (90));
    
    
     if( IS_IPHONE_5 ){
         self.view.bounds=CGRectMake(0.0,0.0,568.0,320.0);
         
         [self.moviePlayer setFrame:CGRectMake(0.0,0.0,568.0,320.0)];

         
     }else{
         
         self.view.bounds=CGRectMake(0.0,0.0,480.0,320.0);
         
         [self.moviePlayer setFrame:CGRectMake(0.0,0.0,480.0,320.0)];
         
         
     }
    
    
    //esconde o status e seta a aparencia da view
    _statusBarHidden = YES;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
//   [self.moviePlayer.controls fullscreenPressed:_fullScreenButton];
////    
//    if (![self.view.subviews containsObject:self.moviePlayer.view])
//        [self.view addSubview:self.moviePlayer.view];
//
    
}



- (void)configureViewForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat videoWidth = 0;
    CGFloat videoHeight = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        videoWidth = 700.f;
        videoHeight = 535.f;
    } else {
        videoWidth = self.view.frame.size.width;
        videoHeight = 220.f;
    }
    
    
    // muda posicao do player
    //calulate the frame on every rotation, so when we're returning from fullscreen mode we'll know where to position the movie plauyer
    self.defaultFrame = CGRectMake(0, 0, videoWidth, videoHeight);
    
    //only manage the movie player frame when it's not in fullscreen. when in fullscreen, the frame is automatically managed
    if (self.moviePlayer.isFullscreen)
        return;
    
    //you MUST use [ALMoviePlayerController setFrame:] to adjust frame, NOT [ALMoviePlayerController.view setFrame:]
    [self.moviePlayer setFrame:self.defaultFrame];
    
    
}



//these files are in the public domain and no longer have property rights
- (void)localFile {
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"]]];
    [self.moviePlayer play];
}



- (void)remoteFile {
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL URLWithString:@"http://archive.org/download/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto-HawaiianHoliday1937-Video.mp4"]];
    [self.moviePlayer play];
}



//IMPORTANT!
- (void)moviePlayerWillMoveFromWindow {
    //movie player must be readded to this view upon exiting fullscreen mode.
    if (![self.view.subviews containsObject:self.moviePlayer.view])
        [self.view addSubview:self.moviePlayer.view];
    
    //you MUST use [ALMoviePlayerController setFrame:] to adjust frame, NOT [ALMoviePlayerController.view setFrame:]
    [self.moviePlayer setFrame:self.defaultFrame];
}



- (void)movieTimedOut {
    NSLog(@"MOVIE TIMED OUT");
}



- (BOOL)shouldAutorotate {
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
 
    
//    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight )
//      {
//        // [self.moviePlayer.controls sair_fullscrenn];
//        
//        
//        
//        [self.moviePlayer.controls fullscreenPressed:_fullScreenButton];
//        
//       // [self.moviePlayer setFrame:self.defaultFrame];
//        
//      } else if (fromInterfaceOrientation == UIInterfaceOrientationPortrait)
//        {
//          [self.moviePlayer.controls sair_fullscrenn];
//          
//          // [self.moviePlayer.controls sair_fullscrenn];
//          
//          
//          
//        }
    
    
    
}




-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
   
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight )
        {
         // [self.moviePlayer.controls sair_fullscrenn];
         
//     self.view.bounds=CGRectMake(0.0,0.0,480.0,320.0);
          
       [self.moviePlayer.controls fullscreenPressed:_fullScreenButton];
          
          if (![self.view.subviews containsObject:self.moviePlayer.view])
              [self.view addSubview:self.moviePlayer.view];
//
//         [self.moviePlayer setFrame:CGRectMake(0.0,0.0,480.0,320.0)];
          
//           [self.moviePlayer setFrame:self.defaultFrame];
          
        } else if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
          {
            
            
            //se alterou view pelo metofo gotofull
            if (_flaggotofull == YES) {
                
             
                // esconde navigator
                navBar.hidden = NO;
                
                
                //gira a tela
                        self.view.transform=CGAffineTransformMakeRotation(deg2rad* (0));
                
                
                if( IS_IPHONE_5 ){
                    self.view.bounds=CGRectMake(0.0,0.0,320.0,568.0);
                    
//                    [self.moviePlayer setFrame:CGRectMake(0.0,0.0,320.0,220.0)];
                    
                    
                }else{
                    
                    self.view.bounds=CGRectMake(0.0,0.0,320.0,480.0);
                    
//                    [self.moviePlayer setFrame:CGRectMake(0.0,0.0,320.0,220.0)];
                    
                    
                }
                
                
                //esconde o status e seta a aparencia da view
                _statusBarHidden = NO;
                
                [self setNeedsStatusBarAppearanceUpdate];
                
                   _flaggotofull =NO;
                

            }
            

            
            
            
                [self.moviePlayer.controls sair_fullscrenn];
            
            
            if (![self.view.subviews containsObject:self.moviePlayer.view])
                [self.view addSubview:self.moviePlayer.view];
            //
            [self.moviePlayer setFrame:CGRectMake(0.0,0.0,self.view.frame.size.width,220.0)];
            
            
            
           
           // [self.moviePlayer.controls sair_fullscrenn];
            
            
            
          }

    
//    [self moviePlayerWillMoveFromWindow];
//
   //[self configureViewForOrientation:toInterfaceOrientation];
  

    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

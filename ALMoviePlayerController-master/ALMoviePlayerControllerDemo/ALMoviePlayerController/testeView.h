//
//  testeView.h
//  ALMoviePlayerController
//
//  Created by Hannah Lisbôa on 20/02/14.
//  Copyright (c) 2014 Anthony Lobianco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "DAPagesContainer.h"

@interface testeView : UIViewController <RatingViewDelegate>
{
    
    
    IBOutlet UIView *teste;
    
}

@property (strong, nonatomic) IBOutlet UIView *barraTema;
@property (strong, nonatomic) IBOutlet UIView *testePlayer;
@property (strong, nonatomic) IBOutlet UIView *rating;
@property (nonatomic,strong)RatingView *starRatingView;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) DAPagesContainer *pagesContainer;
- (IBAction)scoreButtonTouchUpInside:(id)sender;
- (IBAction)btNext:(id)sender;



@end

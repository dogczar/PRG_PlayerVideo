//
//  videotecaBeta.h
//  ALMoviePlayerController
//
//  Created by Hannah Lisbôa on 25/02/14.
//  Copyright (c) 2014 Anthony Lobianco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAPagesContainer.h"

@interface videotecaBeta : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *items;

}

@property (nonatomic, strong) IBOutlet UITableView *tableSeries;


@end

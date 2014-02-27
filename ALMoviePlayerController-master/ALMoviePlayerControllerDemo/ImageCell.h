//
//  ImageCell.h
//  LazyImageLoading
//
//  Created by Jenn on 4/29/13.
//  Copyright (c) 2013 Jenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *imageSource;

@end

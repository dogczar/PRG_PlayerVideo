//
//  ImageCell.m
//  LazyImageLoading
//
//  Created by Jenn on 4/29/13.
//  Copyright (c) 2013 Jenn. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

@synthesize imageSource;
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

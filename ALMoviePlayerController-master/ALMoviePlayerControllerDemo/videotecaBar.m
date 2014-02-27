//
//  videotecaBar.m
//  ALMoviePlayerController
//
//  Created by Hannah Lisbôa on 25/02/14.
//  Copyright (c) 2014 Anthony Lobianco. All rights reserved.
//

#import "videotecaBar.h"
#import "DAPagesContainer.h"
#import "ViewController.h"
#import "testeView.h"
#import "videotecaBeta.h"

@interface videotecaBar ()
@property (strong, nonatomic) DAPagesContainer *pagesContainer;
@end

@implementation videotecaBar

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
	// Do any additional setup after loading the view.
    
    self.pagesContainer = [[DAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.view.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.viewBar addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    
    videotecaBeta *videoteca = [[videotecaBeta alloc]init];
    videoteca.title = @"olha o ";
    ViewController *teste = [[ViewController alloc]init];
    teste.title = @"Clau";
    
    testeView * tt = [[testeView alloc] init];
    tt.title = @"ClauClau";
    
    self.pagesContainer.viewControllers = @[videoteca,tt, teste];
    
//    self.pagesContainer.topBarBackgroundColor = [UIColor grayColor];
//    self.pagesContainer.pageItemsTitleColor = [UIColor redColor];
//    self.pagesContainer.selectedPageItemTitleColor = [UIColor greenColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

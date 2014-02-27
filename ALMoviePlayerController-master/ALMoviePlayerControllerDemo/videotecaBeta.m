//
//  videotecaBeta.m
//  ALMoviePlayerController
//
//  Created by Hannah Lisbôa on 25/02/14.
//  Copyright (c) 2014 Anthony Lobianco. All rights reserved.
//

#import "videotecaBeta.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ImageCell.h"
#import "ViewController.h"
#import "testeView.h"


@interface videotecaBeta ()

@end

@implementation videotecaBeta
@synthesize tableSeries;


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
	// Do any additional setup after loading the view, typically from a nib.
    
    items = [[NSMutableArray alloc] init];
    [items addObject:@"http://i0.wp.com/hypebeast.com/image/2013/01/hot-toys-iron-man-3-mark-xlii-collectible-bust_1.jpg?w=1410"];
    [items addObject:@"http://t0.gstatic.com/images?q=tbn:ANd9GcT4PZc648WRoXzxEdLQA9zMGqBx93_um_HxvsjgYhoY3AvDtkzI"];
    [items addObject:@"http://i0.wp.com/hypebeast.com/image/2013/03/hot-toys-iron-man-3-iron-patriot-collectible-bust-2.jpg?w=930"];
    [items addObject:@"http://t3.gstatic.com/images?q=tbn:ANd9GcTf_6e7G9pIiw7ZlRRPfdq63NP-jRA6tmstL1ji-ZFEVnTkDjSp"];
    [items addObject:@"http://4.bp.blogspot.com/-KlZshKtr0DM/UWDGlG1YqtI/AAAAAAAAAFc/Qt89IIY3s6s/s1600/iron-man-3.jpg"];
    
    
    
        
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MyImageCell";
    ImageCell *cell = (ImageCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ImageCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (ImageCell *)currentObject;
                break;
            }
        }
    }
    
    // Here we use the new provided setImageWithURL: method to load the web image
    [cell.imageView setImageWithURL:[NSURL URLWithString:[items objectAtIndex:indexPath.row]] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    cell.imageSource.text = [items objectAtIndex:indexPath.row];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end

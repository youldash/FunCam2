//
//  FCMasterViewController.m
//  FunCam
//
//  Created by Mustafa Youldash on 12/09/13.
//  Copyright (c) 2013 La Trobe University. All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without
//	modification, are permitted provided that the following conditions are met:
//
//	* Redistributions of source code must retain the above copyright notice, this
//	list of conditions and the following disclaimer.
//
//	* Redistributions in binary form must reproduce the above copyright notice,
//	this list of conditions and the following disclaimer in the documentation
//	and/or other materials provided with the distribution.
//
//	* Neither the name of the author nor the names of its contributors may be used
//	to endorse or promote products derived from this software without specific
//	prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
//	FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//	OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "FCMasterViewController.h"
#import "FCDetailViewController.h"

#import "Photo.h"

@interface FCMasterViewController () {
	
	NSMutableArray *_objects;
}

@end

@implementation FCMasterViewController

// Code omitted...

- (void)awakeFromNib
{
	self.clearsSelectionOnViewWillAppear = NO;
	self.preferredContentSize = CGSizeMake(320.0, 600.0);
	[super awakeFromNib];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton =
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
												  target:self
												  action:@selector(insertNewObject:)];
	
	self.navigationItem.rightBarButtonItem = addButton;
	
	self.detailViewController =
	(FCDetailViewController *)[[self.splitViewController.viewControllers
								lastObject]
							   topViewController];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
	// If we do not have any objects yet, init the array, once!
	if (!_objects) {
		_objects = [[NSMutableArray alloc] init];
	}
	
	// Create a new instance of Photo.
	Photo *photo = [[Photo alloc] init];
	
	// Add it to the array to be listed as the first object, like so:
	[_objects insertObject:photo atIndex:0];
	
	// Get a reference to the top of the table view for later adding.
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	
	// Insert the new row to the table view.
	[self.tableView insertRowsAtIndexPaths:@[indexPath]
						  withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Get a reference to the current cell at the index path,
	// (or row number, if you may will).
	UITableViewCell *cell =
	[tableView dequeueReusableCellWithIdentifier:@"Cell"
									forIndexPath:indexPath];
	
	// Get a reference to the current photo object in the array.
	Photo *photo = _objects[indexPath.row];
	
	// Display both image name and caption, like so:
	cell.textLabel.text = [photo caption];
	cell.detailTextLabel.text = [[photo image] description];
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		[_objects removeObjectAtIndex:indexPath.row];
		
		[tableView deleteRowsAtIndexPaths:@[indexPath]
						 withRowAnimation:UITableViewRowAnimationFade];
		
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

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

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Get a reference to the current photo object in the array.
	Photo *photo = _objects[indexPath.row];
	
	// Pass it to the detail view controller to view the image.
	self.detailViewController.detailItem = photo;
}

@end

//
//  ViewController.m
//  ZendoSwipeTableViewCellDemo
//
//  Created by Victor Chen on 10/09/13.
//  Copyright (c) 2013 Mt Zendo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ZendoSwipeTableViewCell *cell = (ZendoSwipeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ZendoSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.delegate = (id)self;
    
    cell.enabled = YES;
    cell.dragEnabled = YES;
    
    cell.enableColor = [UIColor greenColor];
    cell.enableIconImage = [UIImage imageNamed:@"check.png"];
    
    cell.disableColor = [UIColor redColor];
    cell.disableIconImage = [UIImage imageNamed:@"cross.png"];
    
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    NSLog(@"didSelectRowAtIndexPathdidSelectRowAtIndexPath");
}


#pragma mark - MTSwipeTableViewCellDelegate
-(void)zendoTableviewCell:(UITableViewCell *)cell enableStateChanged:(BOOL)enable{
    
    if (enable) {
        NSLog(@"on");
    }
    else{
        NSLog(@"off");
    }
}

@end

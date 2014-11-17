//
//  SATopViewController.m
//  SAScrollingHelper
//
//  Created by Yoshihiro Kato on 2014/06/11.
//  Copyright (c) 2014年 Yoshihiro Kato. All rights reserved.
//

#import "SATopViewController.h"

@interface SATopViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SATopViewController {
    UITableView* _tableView;
    
    NSArray*      _items;
    NSDictionary* _itemClassNames;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _items = @[@"Simple Demo 01", @"Simple Demo 02"];
        _itemClassNames = @{@"Simple Demo 01" : @"SADemo01ViewController",
                            @"Simple Demo 02" : @"SADemo02ViewController"};
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UITableView Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kCellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kCellIdentifier];
    }
    cell.textLabel.text = [_items objectAtIndex:indexPath.row];
    
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

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cls = NSClassFromString([_itemClassNames objectForKey:[_items objectAtIndex:indexPath.row]]);
    if(cls){
        UIViewController* vc = (UIViewController*)[[cls alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end

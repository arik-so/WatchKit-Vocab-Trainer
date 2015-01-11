//
//  PackageTableViewController.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 10.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "PackageTableViewController.h"

#import "FRServer.h"


@interface PackageTableViewController ()

@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableDictionary *categoryImages;
@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSMutableArray *sortedSections;
@property (strong, nonatomic) NSMutableArray *packages;

@end

@implementation PackageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"EverLearn";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(fetchFromServer) forControlEvents:UIControlEventValueChanged];
    
    [self fetchFromServer];
    
    
}




- (void)fetchFromServer{
    
    
    
    /*
    
    // get all the categories
    dispatch_async(dispatch_queue_create(nil, nil), ^{
        NSString *jsonString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://xampp.localhost/watchkit-vocab-trainer/web/categories"] encoding:NSUTF8StringEncoding error:nil];
        
        self.categories = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
        
        
        self.categoryImages = @{}.mutableCopy;
        self.packages = @[].mutableCopy;
        self.sortedSections = @[].mutableCopy;
        self.sections =@{}.mutableCopy;
        
        
        for(NSDictionary *currentCategory in self.categories) {
            
            NSString *sectionName = currentCategory[@"section"];
            Section *section = self.sections[sectionName];
            
            if(!section) {
                section = [[Section alloc] init];
            }
            
            // package == category
            // thus, we add a packge representing this category to the section
            [section.packages addObject:[[Package alloc] initWithJSON:currentCategory]];
            
            section.sectionID = sectionName;
            self.sections[sectionName] = section;
            
        }
        
        
        // sort the sections alphabetically
        
        NSArray *sortedKeys = [[self.sections allKeys] sortedArrayUsingSelector: @selector(compare:)];
        
        for (NSString *key in sortedKeys) {
            [self.sortedSections addObject: [self.sections objectForKey: key]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            NSLog(@"right here, goddammit!");
            
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];

        });
    });
    
    
    
    return;
    
    */
    
    
    
    [FRServer stringFromURL:@"http://xampp.localhost/watchkit-vocab-trainer/web/categories" HTTPMethod:@"GET" attributes:nil HTTPHeaderFieldDictionary:nil andCallbackBlock:^(NSString *string) {
        
        if(!string){
            
            UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not load categories from server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorView show];
            
            [self.refreshControl endRefreshing];
            
            return;
            
        }
        
        self.categories = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
        
        self.categoryImages = @{}.mutableCopy;
        self.packages = @[].mutableCopy;
        self.sortedSections = @[].mutableCopy;
        self.sections =@{}.mutableCopy;
        
        for(NSDictionary *dic in self.categories) {
            
            NSString *sectionName = dic[@"section"];
            Section *section = self.sections[sectionName];
            
            if(!section) {
                section = [[Section alloc] init];
            }
            
            // package == category
            // thus, we add a packge representing this category to the section
            [section.packages addObject:[[Package alloc] initWithJSON:dic]];
            
            section.sectionID = sectionName;
            self.sections[sectionName] = section;
            
            
            //[self.packages addObject:[[Package alloc] initWithJSON:dic]];
        }

        
        // sort the sections alphabetically
        
        NSArray *sortedKeys = [[self.sections allKeys] sortedArrayUsingSelector: @selector(compare:)];
        
        for (NSString *key in sortedKeys) {
            [self.sortedSections addObject: [self.sections objectForKey: key]];
        }
        
        
        
        
        
        [FRServer stringFromURL:[[NSString stringWithFormat:@"http://xampp.localhost/watchkit-vocab-trainer/web/device/%@/stats",[UIDevice currentDevice].identifierForVendor.UUIDString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] HTTPMethod:@"GET" attributes:nil HTTPHeaderFieldDictionary:nil andCallbackBlock:^(NSString *answersString) {
            
            
            
            
            NSArray *answers = [NSJSONSerialization JSONObjectWithData:[answersString dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
            
            
            for(NSDictionary *dic in answers) {
                NSString *category_id = [dic valueForKey:@"category_id"];
                
                if(![category_id isEqual:[NSNull null]]) {
                    for(NSString *key in self.sections) {
                        Section *section = self.sections[key];
                        for (Package *package in section.packages) {
                            if([package.uuid isEqualToString:category_id]) {
                                Answer *answer = [[Answer alloc] initWithJSON:dic];
                                [package addAnswer:answer];
                                break;
                            }
                        }
                    }
                }
            }
            
            
            
            [self.refreshControl endRefreshing];
            
            
            
            [self.tableView reloadData];
            
        }];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.sections allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    //    NSLog(@"%u",self.packages.count);
    
    return ((Section *)self.sortedSections[section]).packages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Package *package = ((Section *)self.sortedSections[indexPath.section]).packages[indexPath.row];
    
    //    NSDictionary *details = self.categories[indexPath.row];
    NSString *categoryID = package.uuid;
    NSString *name = package.name;
    NSString *imageURL = package.imageURL;
    cell.tag = [package.uuid intValue];
    
    UIImage *image = self.categoryImages[[NSString stringWithFormat:@"%@",categoryID]];
    
    if(image){
        
        cell.imageView.clipsToBounds=YES;
        cell.imageView.layer.cornerRadius=[self tableView:tableView heightForRowAtIndexPath:indexPath]/2;
        cell.imageView.contentMode=UIViewContentModeScaleAspectFill;
        cell.imageView.image = image;
        
        
    }else{
        
        cell.imageView.image = nil;
        
        [FRServer imageFromURL:imageURL HTTPMethod:@"GET" attributes:nil HTTPHeaderFieldDictionary:nil andCallbackBlock:^(UIImage *image) {
            
            [self.categoryImages setObject:image forKey:categoryID];
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
    }
    
    // [cell.a.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.accessoryView = nil;
    
    if(indexPath.section==0) {
        UIButton *buy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buy.frame=CGRectMake(self.view.frame.size.width-70, 20, 60, 30);
        [buy setTitle:@"$0.99" forState:UIControlStateNormal];
        buy.layer.borderWidth=1;
        buy.layer.cornerRadius=5;
        buy.layer.borderColor=[[UIColor blueColor] CGColor];
        cell.accessoryView = buy;
        [buy addTarget:self action:@selector(inAppKauf:) forControlEvents:UIControlEventTouchUpInside];
        // [cell.contentView addSubview:buy];
    }
    
    cell.textLabel.text = name;
    
    
    return cell;
}

-(void) inAppKauf:(UIButton *) sender {
    UIAlertView *buy = [[UIAlertView alloc] initWithTitle:@"Confirm In-App Purchase" message:@"\nDo you want to buy \"Celebrity Quiz\" for $0.99?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Buy", nil];
    [buy show];
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((Section *)self.sortedSections[section]).sectionID;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    Package *currentPackage;
    
    for(Section *section in self.sortedSections) {
        for(Package *package in section.packages) {
            if([package.uuid intValue] == sender.tag) {
                currentPackage =package;
            }
        }
    }
    
        
    
    [((PackageDetailViewController *)[segue destinationViewController]) setPackage:currentPackage];
}


@end

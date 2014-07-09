//
//  ViewController.m
//  MCArmoryMobile
//
//  Created by Sehyun Park on 7/3/14.
//  Copyright (c) 2014 Sehyun Park. All rights reserved.
//

#import "ViewController.h"
#import "MCArmor.h"
#import "MCGearSet.h"

@interface ViewController ()
            
@property (weak, nonatomic) IBOutlet UIImageView *headGearImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chestGearImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pantsGearImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bootGearImageView;
@property (strong) NSArray *armorList;
@property (strong) MCGearSet *gearSet;
@end

@implementation ViewController

- (void)setupActivity {
    self.userActivity = [[NSUserActivity alloc] initWithActivityType:@"org.osxdev.mcarmory.changing-gears"];
    self.userActivity.webpageURL = [NSURL URLWithString:@"http://osxdev.org"];
    self.userActivity.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.armorList = [MCArmor defaultArmors];
    self.gearSet = [[MCGearSet alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCArmor *armor = [self.armorList objectAtIndex:indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ArmorListCell"];
    cell.textLabel.text = [armor armorName];
    cell.imageView.image = [UIImage imageNamed:armor.imageName];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.armorList count];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.gearSet wearArmor:[self.armorList objectAtIndex:indexPath.row]];
    [self refreshGearSetView];
    
}

- (void)refreshGearSetView {
    if (self.gearSet.headGear)
        [self.headGearImageView setImage:[UIImage imageNamed:self.gearSet.headGear.imageName]];
    else
        self.headGearImageView.image = nil;
    
    if (self.gearSet.chestGear)
        [self.chestGearImageView setImage:[UIImage imageNamed:self.gearSet.chestGear.imageName]];
    else
        self.chestGearImageView.image = nil;
    
    if (self.gearSet.pantsGear)
        [self.pantsGearImageView setImage:[UIImage imageNamed:self.gearSet.pantsGear.imageName]];
    else
        self.pantsGearImageView.image = nil;
    
    if (self.gearSet.bootsGear)
        [self.bootGearImageView setImage:[UIImage imageNamed:self.gearSet.bootsGear.imageName]];
    else
        self.bootGearImageView.image = nil;
    
    if(!self.userActivity) {
        [self setupActivity];
        [self.userActivity addUserInfoEntriesFromDictionary:[self.gearSet dictionaryRepresentation]];
        [self.userActivity becomeCurrent];
        NSLog(@"did call becomeCurrent on userActivity %@ with %@", self.userActivity.activityType, [self.gearSet dictionaryRepresentation]);
    } else {
        [self.userActivity addUserInfoEntriesFromDictionary:[self.gearSet dictionaryRepresentation]];
    }
}

- (void)restoreUserActivityState:(NSUserActivity *)activity {
    [super restoreUserActivityState:activity];
    NSLog(@"restore user activity %@", activity.description);
    //[self.gearSet updateFromDictionary:activity.userInfo];
}

- (IBAction)invalidateActivity:(id)sender {
    [self.userActivity invalidate];
    self.userActivity = nil;
}
#pragma mark -
#pragma mark Advanced Topics
- (void)userActivityWasContinued:(NSUserActivity *)userActivity {
    NSLog(@"userActivityWasContinued: %@", userActivity.activityType);
}

@end

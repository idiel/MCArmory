//
//  AppDelegate.m
//  MCArmory
//
//  Created by Sehyun Park on 7/2/14.
//  Copyright (c) 2014 Sehyun Park. All rights reserved.
//

#import "AppDelegate.h"
#import "MCArmor.h"
#import "MCGearSet.h"

@interface AppDelegate ()
            
@property (weak) IBOutlet NSWindow *window;
@property (strong) NSArray *armorList;
@property (strong) MCGearSet *gearSet;
@property (strong) NSUserActivity *activity;
@property (weak) IBOutlet NSTableView *armorListTableView;
@property (weak) IBOutlet NSImageView *headGearImageView;
@property (weak) IBOutlet NSImageView *chestGearImageView;
@property (weak) IBOutlet NSImageView *pantsGearImageView;
@property (weak) IBOutlet NSImageView *bootsGearImageView;
@property (weak) IBOutlet NSLevelIndicator *armorScoreLevel;
@property (weak) IBOutlet NSButton *headGearRemoveButton;
@property (weak) IBOutlet NSButton *chestGearRemoveButton;
@property (weak) IBOutlet NSButton *pantsGearRemoveButton;
@property (weak) IBOutlet NSButton *bootsGearRemoveButton;

@end

@implementation AppDelegate
- (void)setupArmorList {
    self.armorList = [MCArmor defaultArmors];
    self.gearSet = [[MCGearSet alloc] init];
}

- (void)setupActivity {
    self.activity = [[NSUserActivity alloc] initWithActivityType:@"org.osxdev.mcarmory.changing-gears"];
    self.activity.delegate = self;
    self.activity.webpageURL = [NSURL URLWithString:@"http://osxdev.org"];
}

- (IBAction)armorSelected:(id)sender {
    MCArmor *selectedArmor = [self.armorList objectAtIndex:self.armorListTableView.clickedRow];
    [self.gearSet wearArmor:selectedArmor];
    [self didUpdateGearSet];
}

- (void)showGearSet {
    self.headGearImageView.image = [NSImage imageNamed:self.gearSet.headGear.imageName];
    self.chestGearImageView.image = [NSImage imageNamed:self.gearSet.chestGear.imageName];
    self.pantsGearImageView.image = [NSImage imageNamed:self.gearSet.pantsGear.imageName];
    self.bootsGearImageView.image = [NSImage imageNamed:self.gearSet.bootsGear.imageName];
}

- (void)refreshArmorScore {
    [self.armorScoreLevel.cell setIntegerValue:self.gearSet.fullArmorScore];
}

- (void)refreshRemoveButtons {
    self.headGearRemoveButton.hidden = (self.gearSet.headGear == nil);
    self.chestGearRemoveButton.hidden = (self.gearSet.chestGear == nil);
    self.pantsGearRemoveButton.hidden = (self.gearSet.pantsGear == nil);
    self.bootsGearRemoveButton.hidden = (self.gearSet.bootsGear == nil);
}

- (IBAction)gearClicked:(id)sender {
    [self.gearSet takeOffArmorType:[sender tag]];
    [self didUpdateGearSet];
}

- (void)didUpdateGearSet {
    [self showGearSet];
    [self refreshArmorScore];
    [self refreshRemoveButtons];
    
    if(!self.activity) {
        [self setupActivity];
        [self.activity addUserInfoEntriesFromDictionary:[self.gearSet dictionaryRepresentation]];
        [self.activity becomeCurrent];
        NSLog(@"did call become current on activity");
    } else {
        [self.activity addUserInfoEntriesFromDictionary:[self.gearSet dictionaryRepresentation]];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self setupArmorList];
    [self.armorListTableView reloadData];
    [self.armorListTableView setTarget:self];
    [self.armorListTableView setDoubleAction:@selector(armorSelected:)];
    [self.headGearRemoveButton setTag:MCArmorHeadgear];
    [self.chestGearRemoveButton setTag:MCArmorChestplate];
    [self.pantsGearRemoveButton setTag:MCArmorPants];
    [self.bootsGearRemoveButton setTag:MCArmorBoots];
    [self refreshRemoveButtons];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self.activity invalidate]; 
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return self.armorList.count;
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex
{
    return [self.armorList objectAtIndex:rowIndex];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    MCArmor *armor = [self.armorList objectAtIndex:row];
    cellView.imageView.image = [NSImage imageNamed:armor.imageName];
    cellView.textField.stringValue = armor.armorName;
    return cellView;
}

- (BOOL)application:(NSApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    NSLog(@"will call restorationHandlers for %@", userActivity.activityType);
    restorationHandler(@[self]);
    [self restoreUserActivityState:userActivity]; 
    return YES;
}

- (void)restoreUserActivityState:(NSUserActivity *)activity {
    NSLog(@"restore user activity %@", activity.description);
    [self.gearSet updateFromDictionaryRepresentation:activity.userInfo];
    [self didUpdateGearSet];
}

- (IBAction)invalidateActivity:(id)sender {
    [self.activity invalidate];
    self.activity = nil;
}

#pragma mark -
#pragma mark Delegate
- (BOOL)application:(NSApplication *)application willContinueUserActivityWithType:(NSString *)activityType {
    NSLog(@"willContinueUserActivityWithType %@", activityType);
    return YES;
}

- (void)userActivityWasContinued:(NSUserActivity *)userActivity {
    NSLog(@"userActivityWasContinued! %@", userActivity.activityType);
}

- (void)application:(NSApplication *)application
didFailToContinueUserActivityWithType:(NSString *)userActivityType
              error:(NSError *)error {
    NSLog(@"darn");
}
@end

//
//  MCGearSet.m
//  MCArmory
//
//  Created by Sehyun Park on 7/2/14.
//  Copyright (c) 2014 Sehyun Park. All rights reserved.
//

#import "MCGearSet.h"

@implementation MCGearSet
- (NSInteger)fullArmorScore {
    NSInteger aScore = 0;
    if (self.headGear) {
        aScore += self.headGear.armorScore;
    }
    if (self.chestGear) {
        aScore += self.chestGear.armorScore;
    }
    if (self.pantsGear) {
        aScore += self.pantsGear.armorScore;
    }
    if (self.bootsGear) {
        aScore += self.bootsGear.armorScore;
    }
    return aScore;
}

- (void)wearArmor:(MCArmor *)armor {
    if (armor.armorType == MCArmorHeadgear)
        self.headGear = armor;
    switch (armor.armorType) {
        case MCArmorHeadgear:
            self.headGear = armor;
            break;
        case MCArmorChestplate:
            self.chestGear = armor;
            break;
        case MCArmorPants:
            self.pantsGear = armor;
            break;
        case MCArmorBoots:
            self.bootsGear = armor;
            break;
        default:
            break;
    }
}

- (void)takeOffAllArmor {
    self.headGear = nil;
    self.chestGear = nil;
    self.pantsGear = nil;
    self.bootsGear = nil; 
}

- (void)takeOffArmorType:(MCArmorType)aType {
    switch (aType) {
        case MCArmorHeadgear:
            self.headGear = nil;
            break;
        case MCArmorChestplate:
            self.chestGear = nil;
            break;
        case MCArmorPants:
            self.pantsGear = nil;
            break;
        case MCArmorBoots:
            self.bootsGear = nil;
            break;
        default:
            break;
    }
}

- (BOOL)hasCompleteSet {
    if (self.headGear && self.chestGear && self.pantsGear && self.bootsGear) {
        NSInteger setNumber = self.headGear.armorSet & self.chestGear.armorSet & self.pantsGear.armorSet & self.bootsGear.armorSet ;
        
        return self.headGear.armorSet == setNumber;
    }
    return NO;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (self.headGear)
        [dict setObject:[self.headGear dictionaryRepresentation] forKey:@"headGear"];
    if (self.chestGear)
        [dict setObject:[self.chestGear dictionaryRepresentation] forKey:@"chestGear"];
    if (self.pantsGear)
        [dict setObject:[self.pantsGear dictionaryRepresentation] forKey:@"pantsGear"];
    if (self.bootsGear)
        [dict setObject:[self.bootsGear dictionaryRepresentation] forKey:@"bootsGear"];
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)updateFromDictionaryRepresentation:(NSDictionary *)dict {
    [self takeOffAllArmor];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self wearArmor:[MCArmor armorWithDictionaryRepresentation:obj]];
    }];
}
@end

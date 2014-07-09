//
//  MCGearSet.h
//  MCArmory
//
//  Created by Sehyun Park on 7/2/14.
//  Copyright (c) 2014 Sehyun Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCArmor.h"

@interface MCGearSet : NSObject
@property (strong) MCArmor *headGear;
@property (strong) MCArmor *chestGear;
@property (strong) MCArmor *pantsGear;
@property (strong) MCArmor *bootsGear;

- (NSInteger)fullArmorScore;
- (void)wearArmor:(MCArmor *)armor;
- (void)takeOffAllArmor;
- (void)takeOffArmorType:(MCArmorType)aType;
- (BOOL)hasCompleteSet;
- (NSDictionary *)dictionaryRepresentation;
- (void)updateFromDictionaryRepresentation:(NSDictionary *)dict;
@end

//
//  MCArmor.h
//  MCArmory
//
//  Created by Sehyun Park on 7/2/14.
//  Copyright (c) 2014 Sehyun Park. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _MCArmorType:NSInteger {
    MCArmorAny = -1,
    MCArmorHeadgear = 0,
    MCArmorChestplate,
    MCArmorPants,
    MCArmorBoots,
} MCArmorType;

@interface MCArmor : NSObject
@property (copy, readonly) NSString *armorName;
@property (copy, readonly) NSString *imageName;
@property (readonly) NSInteger armorScore;
@property (readonly) NSInteger armorSet;
@property (readonly) MCArmorType armorType;
+ (NSArray *)defaultArmors;
+ (instancetype)armorWithDictionaryRepresentation:(NSDictionary *)dict;
- (instancetype)initWithName:(NSString *)aName
                   imageName:(NSString *)iName
                   armorType:(MCArmorType)aType
                  armorScore:(NSInteger)aScore
                    armorSet:(NSInteger)aSet;
- (NSDictionary *)dictionaryRepresentation;

@end

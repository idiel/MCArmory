//
//  MCArmor.m
//  MCArmory
//
//  Created by Sehyun Park on 7/2/14.
//  Copyright (c) 2014 Sehyun Park. All rights reserved.
//

#import "MCArmor.h"

@implementation MCArmor
+ (NSArray *)defaultArmors {
    return @[
      [[MCArmor alloc] initWithName:@"Leather Cap" imageName:@"Grid_Leather_Cap" armorType:MCArmorHeadgear armorScore:1 armorSet:1],
      [[MCArmor alloc] initWithName:@"Leather Tunic" imageName:@"Grid_Leather_Tunic" armorType:MCArmorChestplate armorScore:1 armorSet:1],
      [[MCArmor alloc] initWithName:@"Leather Pants" imageName:@"Grid_Leather_Pants" armorType:MCArmorPants armorScore:1 armorSet:1],
      [[MCArmor alloc] initWithName:@"Leather Boots" imageName:@"Grid_Leather_Boots" armorType:MCArmorBoots armorScore:1 armorSet:1],
      [[MCArmor alloc] initWithName:@"Chain Helmet" imageName:@"Grid_Chain_Helmet" armorType:MCArmorHeadgear armorScore:2 armorSet:2],
      [[MCArmor alloc] initWithName:@"Chain Chestplate" imageName:@"Grid_Chain_Chestplate" armorType:MCArmorChestplate armorScore:2 armorSet:2],
      [[MCArmor alloc] initWithName:@"Chain Leggings" imageName:@"Grid_Chain_Leggings" armorType:MCArmorPants armorScore:2 armorSet:2],
      [[MCArmor alloc] initWithName:@"Chain Boots" imageName:@"Grid_Chain_Boots" armorType:MCArmorBoots armorScore:2 armorSet:2],
      [[MCArmor alloc] initWithName:@"Iron Helmet" imageName:@"Grid_Iron_Helmet" armorType:MCArmorHeadgear armorScore:3 armorSet:3],
      [[MCArmor alloc] initWithName:@"Iron Chestplate" imageName:@"Grid_Iron_Chestplate" armorType:MCArmorChestplate armorScore:3 armorSet:3],
      [[MCArmor alloc] initWithName:@"Iron Leggings" imageName:@"Grid_Iron_Leggings" armorType:MCArmorPants armorScore:3 armorSet:3],
      [[MCArmor alloc] initWithName:@"Iron Boots" imageName:@"Grid_Iron_Boots" armorType:MCArmorBoots armorScore:3 armorSet:3],
      [[MCArmor alloc] initWithName:@"Golden Helmet" imageName:@"Grid_Golden_Helmet" armorType:MCArmorHeadgear armorScore:4 armorSet:4],
      [[MCArmor alloc] initWithName:@"Golden Chestplate" imageName:@"Grid_Golden_Chestplate" armorType:MCArmorChestplate armorScore:4 armorSet:4],
      [[MCArmor alloc] initWithName:@"Golden Leggings" imageName:@"Grid_Golden_Leggings" armorType:MCArmorPants armorScore:4 armorSet:4],
      [[MCArmor alloc] initWithName:@"Golden Boots" imageName:@"Grid_Golden_Boots" armorType:MCArmorBoots armorScore:4 armorSet:4]
      
      ];
}

+ (instancetype)armorWithDictionaryRepresentation:(NSDictionary *)dict {
    return [[MCArmor alloc] initWithName:dict[@"name"] imageName:dict[@"imageName"] armorType:[dict[@"armorType"] integerValue] armorScore:[dict[@"armorScore"] integerValue] armorSet:[dict[@"armorSet"] integerValue]]; 
}

- (instancetype)initWithName:(NSString *)aName
                   imageName:(NSString *)iName
                   armorType:(MCArmorType)aType
                  armorScore:(NSInteger)aScore
                    armorSet:(NSInteger)aSet {
    self = [super init];
    if (self) {
        _armorName = aName;
        _imageName = iName;
        _armorType = aType;
        _armorScore = aScore;
        _armorSet = aSet; 
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    return @{@"name":self.armorName, @"imageName":self.imageName, @"armorType":[NSNumber numberWithInteger:self.armorType], @"armorScore":[NSNumber numberWithInteger:self.armorScore], @"armorSet":[NSNumber numberWithInteger:self.armorSet]};
}
@end

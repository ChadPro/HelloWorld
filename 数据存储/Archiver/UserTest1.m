//
//  UserTest1.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/24.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "UserTest1.h"

@implementation UserTest1

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _name = [aDecoder decodeObjectForKey:@"userName"];
        _age = [aDecoder decodeIntForKey:@"userAge"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"userName"];
    [aCoder encodeInt:_age forKey:@"userAge"];
}

@end

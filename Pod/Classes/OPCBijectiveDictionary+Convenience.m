//
//  OPCBijectiveDictionary+OPConvenienceExtensions.m
//  Pods
//
//  Created by Peter Meyers on 8/27/15.
//
//

#import "OPCBijectiveDictionary+Convenience.h"

@implementation OPCBijectiveDictionary (Convenience)

+ (instancetype)dictionary
{
    return [[self alloc] init];
}

+ (instancetype)dictionaryWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

+ (instancetype)dictionaryWithObjects:(NSOrderedSet *)objects
                                 keys:(NSOrderedSet *)keys
{
    return [[self alloc] initWithObjects:objects keys:keys];
}

+ (instancetype)dictionaryWithMapTable:(NSMapTable *)mapTable
{
    return [[self alloc] initWithMapTable:mapTable];
}

- (instancetype)initWithMapTable:(NSMapTable *)mapTable
{
    return [self initWithObjects:[NSOrderedSet orderedSetWithArray:mapTable.objectEnumerator.allObjects] keys:[NSOrderedSet orderedSetWithArray:mapTable.keyEnumerator.allObjects]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    return [self initWithObjects:[NSOrderedSet orderedSetWithArray:dictionary.allValues] keys:[NSOrderedSet orderedSetWithArray:dictionary.allKeys]];
}

- (instancetype)bijectiveDictionaryByAddingEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary
{
    OPCMutableBijectiveDictionary *mutableCopy = [self mutableCopy];
    [mutableCopy addEntriesFromDictionary:dictionary];
    return [mutableCopy copy];
}

- (BOOL)isEqualToBijectiveDictionary:(OPCBijectiveDictionary *)dictionary
{
    return [self isEqual:dictionary];
}

@end

@implementation OPCMutableBijectiveDictionary (Convenience)

+ (instancetype)dictionaryWithCapacity:(NSUInteger)count
{
    return [[self alloc] initWithCapacity:count];
}

- (void)removeEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary
{
    for (id key in dictionary) {
        [self removeObjectForKey:key];
    }
}

- (void)addEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary
{
    for (id key in dictionary) {
        self[key] = dictionary[key];
    }
}

- (void)removeAllObjects
{
    for (id key in [self.keys copy]) {
        [self removeObjectForKey:key];
    }
}

@end

@implementation OPCOrderedBijectiveDictionary (Convenience)

- (id)keyAtIndex:(NSUInteger)index
{
    return [self.orderedKeys objectAtIndex:index];
}

- (NSUInteger)indexOfKey:(id)key
{
    return [self.orderedKeys indexOfObject:key];
}

@end

@implementation OPCMutableOrderedBijectiveDictionary (Convenience)

- (id)keyAtIndex:(NSUInteger)index
{
    return [self.orderedKeys objectAtIndex:index];
}

- (NSUInteger)indexOfKey:(id)key
{
    return [self.orderedKeys indexOfObject:key];
}

@end

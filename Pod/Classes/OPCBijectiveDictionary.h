//
//  OPCBijectiveDictionary.h
//  OperatoriOS
//
//  Created by Peter Meyers on 5/15/15.
//  Copyright (c) 2015 Operator. All rights reserved.
//

@import Foundation;
#import "OPCCopying.h"

NS_ASSUME_NONNULL_BEGIN

@interface OPCBijectiveDictionary<__covariant KeyType, __covariant ObjectType> : NSObject <NSCopying, NSSecureCoding, NSFastEnumeration, NSMutableCopying, OPCMutableOrderedCopying, OPCThreadSafeMutableCopying, OPCThreadSafeMutableOrderedCopying>

/**
 *  The set containing the bijective dictionary’s keys.
 */
@property (nonatomic, readonly) NSSet<KeyType> *keys;

/**
 *  The set containing the bijective dictionary’s objects.
 */
@property (nonatomic, readonly) NSSet<ObjectType> *objects;

/**
 *  A map table representation of the bijective dictionary. The map table's keys and values use the NSPointerFunctionsStrongMemory option.
 */
@property (nonatomic, readonly) NSMapTable<KeyType, ObjectType> *mapTable;

/**
 *  The number of entries in the dictionary.
 */
@property (nonatomic, readonly) NSUInteger count;

/**
 *  A bijective dictionary where the keys and objects are reversed from the receiver.
 */
@property (nonatomic, readonly) __kindof OPCBijectiveDictionary<ObjectType, KeyType> *inverse;

/**
 *  Initializes a newly allocated bijective dictionary with entries constructed from the specified ordered sets of objects and keys. This method steps through the objects and keys ordered sets, creating mappings from keys to objects using corresponding indicies. An NSInvalidArgumentException is raised if the objects and keys ordered sets do not have the same number of elements.
 *
 *  @param objects An ordered set containing the objects for the new bijective dictionary.
 *  @param keys    An ordered set containing the keys for the new bijective dictionary.
 *
 *  @return A newly allocated and initialized bijective dictionary.
 */
- (instancetype)initWithObjects:(nullable NSOrderedSet<ObjectType> *)objects
                           keys:(nullable NSOrderedSet<KeyType> *)keys NS_DESIGNATED_INITIALIZER;

/**
 *  Returns the object associated with a given key.
 *
 *  @param key The key for which to return the corresponding object.
 *
 *  @return The object associated with key, or nil if no object is associated with key.
 */
- (ObjectType)objectForKeyedSubscript:(KeyType)key;

@end

#pragma mark Mutable

@protocol OPCMutableBijectiveDictionary <NSObject>

/**
 *  Initializes a newly allocated mutable bijective dictionary, allocating enough memory to hold count entries. Mutable dictionaries allocate additional memory as needed, so count simply establishes the object’s initial capacity.
 *
 *  @param count The initial capacity of the initialized dictionary.
 *
 *  @return An initialized mutable bijective dictionary.
 */
- (instancetype)initWithCapacity:(NSUInteger)count;

/**
 *  Adds a given key -> object mapping to the bijective dictionary. If the key or object already exists in the dictionary, this mapping takes the previous mapping's place.
 *
 *  @param object The object for key. A strong reference to the object is maintained by the dictionary.
 *  @param key    The key for object. A strong reference to the key is maintained by the dictionary.
 */
- (void)setObject:(id)object
forKeyedSubscript:(id)key;

/**
 *  Removes a given key and its associated object from the dictionary.
 *
 *  @param key The key to remove.
 */
- (void)removeObjectForKey:(id)key;

@end

@interface OPCMutableBijectiveDictionary<KeyType, ObjectType> : OPCBijectiveDictionary<KeyType, ObjectType> <OPCMutableBijectiveDictionary>

/**
 *  Adds a given key -> object mapping to the bijective dictionary. If the key or object already exists in the dictionary, this mapping takes the previous mapping's place.
 *
 *  @param object The object for key. A strong reference to the object is maintained by the dictionary.
 *  @param key    The key for object. A strong reference to the key is maintained by the dictionary.
 */
- (void)setObject:(ObjectType)object
forKeyedSubscript:(KeyType)key;

/**
 *  Removes a given key and its associated object from the bijective dictionary.
 *
 *  @param key The key to remove.
 */
- (void)removeObjectForKey:(KeyType)key;

@end

#pragma mark Ordered

@protocol OPCOrderedBijectiveDictionary <NSObject>

/**
 *  The ordered set containing the bijective dictionary’s keys.
 */
@property (nonatomic, readonly) NSOrderedSet *orderedKeys;

/**
 *  The ordered set containing the bijective dictionary’s objects.
 */
@property (nonatomic, readonly) NSOrderedSet *orderedObjects;

@end

@interface OPCOrderedBijectiveDictionary<KeyType, ObjectType> : OPCBijectiveDictionary<KeyType, ObjectType> <OPCOrderedBijectiveDictionary>
@end

#pragma mark Mutable Ordered

@protocol OPCMutableOrderedBijectiveDictionary <OPCOrderedBijectiveDictionary, OPCMutableBijectiveDictionary>

/**
 *  Adds a given key -> object mapping to the bijective dictionary at a given index of the mutable ordered bijective dictionary. If the key or object already exists in the dictionary, this mapping takes the previous mapping's place. If the index is already occupied, the mapping at index and beyond are shifted by adding 1 to their indices to make room.
 *
 *  @param object The object for key. A strong reference to the object is maintained by the dictionary.
 *  @param key    The key for object. A strong reference to the key is maintained by the dictionary.
 *  @param index  The index in the mutable ordered bijective dictionary at which to insert object. This value must not be greater than the count of elements in the dictionary.
 */
- (void)setObject:(id)object
           forKey:(id)key
          atIndex:(NSUInteger)index;

@end

@interface OPCMutableOrderedBijectiveDictionary<KeyType, ObjectType> : OPCMutableBijectiveDictionary<KeyType, ObjectType> <OPCMutableOrderedBijectiveDictionary>

/**
 *  Adds a given key -> object mapping to the bijective dictionary at a given index of the mutable ordered bijective dictionary. If the key or object already exists in the dictionary, this mapping takes the previous mapping's place. If the index is already occupied, the mapping at index and beyond are shifted by adding 1 to their indices to make room.
 *
 *  @param object The object for key. A strong reference to the object is maintained by the dictionary.
 *  @param key    The key for object. A strong reference to the key is maintained by the dictionary.
 *  @param index  The index in the mutable ordered bijective dictionary at which to insert object. This value must not be greater than the count of elements in the dictionary.
 */
- (void)setObject:(ObjectType)object
           forKey:(KeyType)key
          atIndex:(NSUInteger)index;

@end

#pragma mark Thread-Safe Mutable

@interface OPCThreadSafeMutableBijectiveDictionary<KeyType, ObjectType> : OPCMutableBijectiveDictionary<KeyType, ObjectType>
@end

@interface OPCThreadSafeMutableOrderedBijectiveDictionary<KeyType, ObjectType> : OPCMutableOrderedBijectiveDictionary<KeyType, ObjectType>
@end

NS_ASSUME_NONNULL_END

//
//  OPCBijectiveDictionary+Convenience.h
//  Pods
//
//  Created by Peter Meyers on 8/27/15.
//
//

#import "OPCBijectiveDictionary.h"

NS_ASSUME_NONNULL_BEGIN

@interface OPCBijectiveDictionary<__covariant KeyType, __covariant ObjectType> (Convenience)

/**
 *  Creates and returns an empty bijective dictionary.
 *
 *  @return A new empty bijective dictionary.
 */
+ (instancetype)dictionary;

/**
 *  Creates and returns a bijective dictionary containing the keys and values from an NSDictionary.
 *
 *  @param dictionary A dictionary containing the keys and values with which to initialize the new bijective dictionary.
 *
 *  @return A new bijective dictionary containing the keys and values found in bijective dictionary.
 */
+ (instancetype)dictionaryWithDictionary:(NSDictionary<KeyType, ObjectType> *)dictionary;

/**
 *  Creates and returns a bijective dictionary containing the keys and values from a map table.
 *
 *  @param mapTable A map table containing the keys and values with which to initialize the new bijective dictionary.
 *
 *  @return A new bijective dictionary containing the keys and values found in mapTable.
 */
+ (instancetype)dictionaryWithMapTable:(NSMapTable<KeyType, ObjectType> *)mapTable;

/**
 *  Creates and returns a bijective dictionary containing entries constructed from the contents of an ordered set of keys and values.
 *
 *  @param objects An ordered set containing the values for the new bijective dictionary. Keys are strongly retained by the bijective dictionary.
 *  @param keys    An ordered set containing the keys for the new bijective dictionary. Keys are strongly retained by the bijective dictionary.
 *
 *  @return A new bijective dictionary containing entries constructed from the contents of objects and keys.
 */
+ (instancetype)dictionaryWithObjects:(NSOrderedSet<ObjectType> *)objects
                                 keys:(NSOrderedSet<KeyType> *)keys;

/**
 *  Initializes a newly allocated bijective dictionary by placing in it the keys and values contained in an NSDictionary.
 *
 *  @param dictionary A dictionary containing the keys and values with which to initialize the new bijective dictionary.
 *
 *  @return An initialized bijective dictionary containing the keys and values found in dictionary.
 */
- (instancetype)initWithDictionary:(NSDictionary<KeyType, ObjectType> *)dictionary;

/**
 *  Initializes a newly allocated bijective dictionary by placing in it the keys and values contained in an NSMapTable.
 *
 *  @param mapTable A map table containing the keys and values with which to initialize the new bijective dictionary.
 *
 *  @return An initialized bijective dictionary containing the keys and values found in mapTable.
 */
- (instancetype)initWithMapTable:(NSMapTable<KeyType, ObjectType> *)mapTable;

/**
 *  Creates and returns a new bijective dictionary containing the keys and values from the receiver unioned with keys and values from another bijective dictionary, respectively. If both dictionaries contain the same key or value, the receiving dictionary’s key or value is replaced.
 *
 *  @param dictionary The dictionary from which to add key-value mappings.
 *
 *  @return A new bijective dictionary containing keys and values constructed from the receiving bijective dictionary unioned with keys and values from another bijective dictionary, respectively.
 */
- (instancetype)bijectiveDictionaryByAddingEntriesFromDictionary:(OPCBijectiveDictionary<KeyType, ObjectType> *)dictionary;

/**
 *  Returns a Boolean value that indicates whether the contents of the receiving bijective dictionary are equal to the contents of another given bijective dictionary. Two dictionaries have equal contents if they each hold the same number of entries and, for a given key, the corresponding value objects in each dictionary satisfy the isEqual: test.
 *
 *  @param dictionary The bijective dictionary with which to compare the receiving dictionary.
 *
 *  @return YES if the contents of dictionary are equal to the contents of the receiving bijective dictionary, otherwise NO.
 */
- (BOOL)isEqualToBijectiveDictionary:(OPCBijectiveDictionary<KeyType, ObjectType> *)dictionary;

/**
 *  Applies a given block object to the entries of the bijective dictionary.
 *
 *  @param block A block object to operate on entries in the dictionary.
 */
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj))block;

@end

#pragma mark -

@protocol OPCMutableBijectiveDictionaryConvenience

/**
 *  Empties the bijective dictionary of its entries.
 */
- (void)removeAllObjects;

/**
 *  Removes to the receiving bijective dictionary the entries from another dictionary.
 *
 *  @param dictionary The bijective dictionary from which to remove entries.
 */
- (void)removeEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary;

/**
 *  Adds to the receiving bijective dictionary the entries from another dictionary.
 *
 *  @param dictionary The bijective dictionary from which to add entries.
 */
- (void)addEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary;

/**
 *  Creates and returns a mutable bijective dictionary, initially giving it enough allocated memory to hold a given number of entries. Mutable bijective dictionaries allocate additional memory as needed, so count simply establishes the object’s initial capacity.
 *
 *  @param count The initial capacity of the new bijective dictionary.
 *
 *  @return A new mutable bijective dictionary with enough allocated memory to hold count entries.
 */
+ (instancetype)dictionaryWithCapacity:(NSUInteger)count;

@end

@interface OPCMutableBijectiveDictionary (Convenience) <OPCMutableBijectiveDictionaryConvenience>
@end

#pragma mark -

@protocol OPCOrderedBijectiveDictionaryConvenience

/**
 *  Returns the key at the specified index of the ordered bijective dictionary. If index is greater than the count of the set of keys, an NSRangeException is raised.
 *
 *  @param index An index used to locate a key in the bijective dictionary.
 *
 *  @return The object located at index.
 */
- (id)keyAtIndex:(NSUInteger)index;

/**
 *  Returns the index of the specified key.
 *
 *  @param key The key.
 *
 *  @return The index whose corresponding value in the ordered set of keys is equal to object. If none of the objects in the ordered set of keys is equal to object, returns NSNotFound.
 */
- (NSUInteger)indexOfKey:(id)key;

@end

@interface OPCOrderedBijectiveDictionary (Convenience) <OPCOrderedBijectiveDictionaryConvenience>
@end

#pragma mark -

@interface OPCMutableOrderedBijectiveDictionary (Convenience) <OPCMutableBijectiveDictionaryConvenience, OPCOrderedBijectiveDictionaryConvenience>
@end

NS_ASSUME_NONNULL_END

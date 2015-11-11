# BijectiveDictionary

A dictionary that preserves the uniqueness of both its keys and its values.

Use BijectiveDictionary when you want to:

- enforce that both keys and values are unique.
- find a value by key in O(1) time.
- find a key by value in O(1) time.
- retrieve the inverse in O(1) time.

BijectiveDictionary implements six classes to provide ordering, mutability and thread-safety.

- `OPCBijectiveDictionary`
- `OPCMutableBijectiveDictionary`
- `OPCOrderedBijectiveDictionary`
- `OPCMutableOrderedBijectiveDictionary`
- `OPCThreadSafeMutableBijectiveDictionary`
- `OPCThreadSafeMutableOrderedBijectiveDictionary`

## Sample Usage

```
OPCMutableBijectiveDictionary *dict = [OPCMutableBijectiveDictionary dictionary];

// Add a new key-value pair.
dict[@"key"] = @"value";

// Retrieve the value for @"key".
NSString *value = dict[@"value"];

// Retrieve the key for @"value".
NSString *key = dict.inverse[@"key"];
```

## Requirements

Minimum iOS Target: 5.0

## Installation

BijectiveDictionary is available through [CocoaPods](http://cocoapods.org). To install, add the following line to your `Podfile` and then run `pod install`.

```ruby
pod 'BijectiveDictionary'
```

## Authors

- Peter Meyers <meyers@operator.com>
- Zach Langley <zach@operator.com>

## License

BijectiveDictionary is available under the MIT license. See the `LICENSE` file for more info.

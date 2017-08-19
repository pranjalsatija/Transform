# Transform
A lightweight linguistics library.

## What is Transform?
Transform allows you to perform linguistics operations on strings and arrays of strings in Swift. It's backed by `NSLinguisticTagger`, a Foundation class that performs part of speech tagging, name recognition, and the like. Transform, in most applications, is designed to serve as a base atop which natural language processing functionality is built.

Put simply, Transform can help you analyze a piece of text, but it can not use the results of the analysis for natural language processing. Since most of that functionality varies drastically from application to application, this is a task best left to the individual developer.

Transform offers 4 operations: extraction, lemmatization, filtering, and tagging. For those unfamiliar with linguistics / NLP, here's a brief explanation of each:
* **Extraction**: Extraction takes a given input and extracts the selected tags, meaning it takes an input and preserves the words that correspond to the specified tags, while discarding everything else. Extraction is useful when you're looking to pull certain information out of text, such as the names of all the people mentioned in the text, or all the verbs present in the text.
* **Lemmatization**: Lemmatization takes a given input and reduces each individual word down to its root. This means that words like "bought" become "buy" and words like "concerts" become "concert". Lemmatization is useful if you're implementing keyword-based search, as it allows searches to work even when the user searches for a different inflection of the specified word.
* **Filtering**: Filtering is the opposite of extraction. Filtering processes a given input and removes the specified tags. Filtering is useful as a preprocessing mechanism when implementing keyword-based search, because it allows you to remove words that don't have much meaning, such as conjunctions.
* **Tagging**: Tagging takes a given input and tags each individual word as its correct part of speech or name type. Most applications don't have an immediate use for tagging in and of itself, but tagging is necessary to process inputs for tasks such as extraction and filtering.

## Usage
One of the main goals of Transform is to provide a clean and natural API. For this reason, all of Transform's APIs are implemented as extensions on `String` and `[String]`. The user friendliness of the API is worth the fact that it adds another member to `String`.

A rule of thumb is that any API that operates on a `String` will return a `String`, and any API that operates on an `[String]` returns an `[String]`. The only exception to this rule is the tagging API, which returns a dictionary of type `[NSLinguisticTag : [String]]`.

### Extraction
The extraction API, which is implemented as the method `extracting` on `String` and `[String]`, takes an array that specifies the tag schemes to extract. It then returns a string or array of strings, depending on the initial object. To parse this string and retrieve individual parts of speech, use the `tagged` method on the returned string or array of strings.

```swift
let string = "The quick brown fox jumped over the lazy dog."
let extracted = string.extracting([.verb, .adjective])

print(extracted) //quick brown jumped lazy
print(extracted.tagged()[.verb]) //Optional(["jumped"])
print(extracted.tagged()[.adjective]) //Optional(["quick", "lazy"])
```

### Lemmatization
The lemmatization API, which is implemented as the method `lemmatized` on `String` and `[String]`, removes all of the names from the item it's operating on and then lemmatizes the rest of the words. It returns a string or an array of strings, depending on the initial object.

```swift
let string = "The people went to grocery stores to buy gallons of milk."
print(string.lemmatized()) //the person go to grocery store to buy gallon of milk
```

### Filtering
The filtering API, which is implemented as the method `removing` on `String` and `[String]`, takes an array that specifies the tag schemes to remove. It then returns a string or array of strings, depending on the initial object. To parse this string and retrieve individual parts of speech, use the `tagged` method on the returned string or array of strings.

```swift
let string = "The quick brown fox jumped over the lazy dog."
let filtered = string.removing([.verb, .adjective])

print(filtered) //The fox over the dog
print(filtered.tagged()[.noun]) //Optional(["fox", "dog"])
```

### Tagging
The tagging API, which is implemented as the method `tagged` on `String` and `[String]`, tags every word within the string or array of strings it operates on with its respective part of speech. It returns a dictionary of type `[NSLinguisticTag : [String]]`. Most use cases will involve using the tagging API after performing other operations on a string or array of strings.

For example, you may want to first remove conjunctions from a string, and then lemmatize the remaining words, and finally tag the string to parse it further.

```swift
let string = "The quick brown fox jumped over the lazy dog."
print(string.tagged()) //[__C.NSLinguisticTag(_rawValue: Pronoun): ["There"], __C.NSLinguisticTag(_rawValue: Preposition): ["of", "in", "of"], __C.NSLinguisticTag(_rawValue: Determiner): ["a", "the"], __C.NSLinguisticTag(_rawValue: Verb): ["\'s"], __C.NSLinguisticTag(_rawValue: Noun): ["lot", "traffic", "cities"], __C.NSLinguisticTag(_rawValue: PlaceName): ["Los Angeles", "New York"], __C.NSLinguisticTag(_rawValue: Conjunction): ["and"]]
```


## Installation
To install Transform, add it as a subproject to whatever it is you're working on and then link it as a framework via Xcode's build settings.

## To Do
- [ ] Create CocoaPod
- [ ] Add binary versions of the framework under "Releases"
- [ ] Use custom POS tagger with increased accuracy and speed
- [ ] Improve performance
- [ ] Add decision making tools (classifiers, decision trees, etc.)

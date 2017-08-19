//
//  Lemmatizer.swift
//  Transform
//
//  Created by Pranjal Satija on 8/18/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import Foundation

extension Array where Element: StringProtocol {
    public func lemmatized() -> [String] {
        return self.toString().lemmatized().toArray()
    }
}

extension String {
    public func lemmatized() -> String {
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma], options: 0)
        let range = Range(self.startIndex..<self.endIndex)
        let nsRange = NSRange(range, in: self)

        tagger.string = self

        var lemmatized = [String]()

        tagger.enumerateTags(in: nsRange, scheme: .lemma, options: [.omitWhitespace, .omitPunctuation]) {(tag, range, _, _) in
            lemmatized.append(tag?.rawValue ?? self[range])
        }

        if lemmatized.isEmpty { return self }
        else { return lemmatized.toString() }
    }
}

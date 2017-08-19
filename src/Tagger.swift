//
//  Tagger.swift
//  Transform
//
//  Created by Pranjal Satija on 8/18/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import Foundation

extension Array where Element: StringProtocol {
    public func tagged() -> [NSLinguisticTag : [String]] {
        return self.toString().tagged()
    }
}

extension String {
    public func tagged() -> [NSLinguisticTag : [String]] {
        let tagger = NSLinguisticTagger(tagSchemes: [.nameTypeOrLexicalClass], options: 0)
        let range = Range(startIndex..<endIndex)
        let nsRange = NSRange(range, in: self)

        tagger.string = self

        var tagged = [NSLinguisticTag : [String]]()

        tagger.enumerateTags(in: nsRange, scheme: .nameTypeOrLexicalClass, options: [.omitWhitespace, .omitPunctuation, .joinNames]) {(tag, range, _, _) in
            guard let tag = tag else { return }

            if tagged[tag] != nil {
                tagged[tag]?.append(self[range])
            }

            else {
                tagged[tag] = [self[range]]
            }
        }

        return tagged
    }
}

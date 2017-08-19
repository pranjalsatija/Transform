//
//  Extractor.swift
//  Transform
//
//  Created by Pranjal Satija on 8/18/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import Foundation

extension Array where Element: StringProtocol {
    public func extracting(_ schemes: [NSLinguisticTag]) -> [String] {
        return self.toString().extracting(schemes).toArray()
    }
}

extension String {
    public func extracting(_ schemes: [NSLinguisticTag]) -> String {
        let tagger = NSLinguisticTagger(tagSchemes: [.nameTypeOrLexicalClass], options: 0)
        let range = Range(startIndex..<endIndex)
        let nsRange = NSRange(range, in: self)

        tagger.string = self

        var extracted = [String]()

        tagger.enumerateTags(in: nsRange, scheme: .nameTypeOrLexicalClass, options: [.omitWhitespace, .omitPunctuation, .joinNames]) {(tag, range, _, _) in
            guard let tag = tag, schemes.contains(tag) else { return }
            extracted.append(self[range])
        }

        if extracted.isEmpty { return self }
        else { return extracted.toString() }
    }
}

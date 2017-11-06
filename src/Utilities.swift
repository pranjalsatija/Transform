//
//  Utilities.swift
//  Transform
//
//  Created by Pranjal Satija on 8/18/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import Foundation

extension Array where Element: StringProtocol {
    func toString() -> String {
        return self.reduce(String()) { $0 + " " + $1 }.trimmingCharacters(in: .whitespaces)
    }
}

extension String {
    subscript(range: NSRange) -> String {
        let lowerIndex = self.index(startIndex, offsetBy: range.lowerBound)
        let upperIndex = self.index(lowerIndex, offsetBy: range.length - 1)
        return String(self[lowerIndex...upperIndex])
    }

    func toArray() -> [String] {
        return self.split(separator: " ").map { String($0) }
    }
}

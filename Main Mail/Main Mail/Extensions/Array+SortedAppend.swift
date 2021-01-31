//
//  Array+SortedAppend.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/31/21.
//

import Foundation

extension Array where Element: Comparable {
    mutating func appendSorted(_ newElement: Element) {
        let lessThanOrEqual = self.filter { $0 <= newElement }
        let greaterThan = self.filter { $0 > newElement }
        self = lessThanOrEqual + [newElement] + greaterThan
    }
}

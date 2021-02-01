//
//  Foundation+NSPredicate.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/31/21.
//

import Foundation

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}

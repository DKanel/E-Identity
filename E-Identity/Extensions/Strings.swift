//
//  Strings.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import Foundation
extension String {
    /// Returns a localized version of the string.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

//
//  Utils.swift
//  App
//
//  Created by Klaus Villaca on 6/17/19.
//

import Foundation

extension String {
    var isBlankUtils: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}

extension Optional where Wrapped == String {
    var isBlankUtils: Bool {
        return self?.isBlankUtils ?? true
    }
}

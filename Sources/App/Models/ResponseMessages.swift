//
//  ResponseMessages.swift
//  App
//
//  Created by Klaus Villaca on 6/17/19.
//

import Foundation
import Vapor

struct ResponseMessages: Codable {
    var httpCode: UInt
    var messages: [String]
}

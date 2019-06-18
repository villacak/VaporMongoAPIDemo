//
//  shutdown.swift
//  App
//
//  Created by Klaus Villaca on 6/17/19.
//

import Foundation
import Vapor

struct ShutdownServer: Content, Codable {
    var user: String
    var token: String
    var body: String
}

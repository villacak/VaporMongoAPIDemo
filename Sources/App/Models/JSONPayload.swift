//
//  JSONPayload.swift
//  App
//
//  Created by Klaus Villaca on 6/19/19.
//

import Vapor

public final class JSONPayload: Content, Codable {
    var id: String
    var payload: String
    
    init(id: String, payload: String) {
        self.id = id
        self.payload = payload
    }
    
    
}



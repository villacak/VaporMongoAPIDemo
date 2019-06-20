//
//  Constant.swift
//  App
//
//  Created by Klaus Villaca on 6/19/19.
//

import Foundation

struct Constant {
    static let DATABASE_NAME = "jpaNoSQLTestDB"
    static let COLLECTION_NAME = "myJSON"
    
    // To be replaced later by Config/secrets with proper environment json files
    static let LOCAL_MONGO_URL = "mongodb://admin:password@localhost:27017"
}

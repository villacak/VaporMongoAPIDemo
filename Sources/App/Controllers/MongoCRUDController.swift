//
//  MongoCRUDController.swift
//  App
//
//  Created by Klaus Villaca on 6/19/19.
//

import Vapor
import MongoSwift


final class MongoCRUDController {
    
    
    func insertRecord(_ req: Request) throws -> HTTPResponse {
        let response: HTTPResponse!
        let body = req.http.body
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        let dataReturn = String(data: body.data!, encoding: String.Encoding.utf8)
        if (dataReturn!.isEmpty) {
            response = try! ReadyResponse.badRequest(dataString: dataReturn!)
        } else {
            let document = try! Document.init(fromJSON: dataReturn!)
            let collection = getMongoCollection(mongoCollectionName: Constant.COLLECTION_NAME)
            let result = try collection.insertOne(document)
            print(result?.insertedId ?? "Fail")
            response = try! ReadyResponse.success(messageString: "Data persisted with success!", dataString: dataReturn!)
            cleanupMongoSwift()
        }
        return response
    }
    
    
    
    func getMongoCollection(mongoCollectionName: String) -> MongoCollection<Document> {
        let client = try! MongoClient(Constant.LOCAL_MONGO_URL)
        let mongoDatabase: MongoDatabase = try! client.db(Constant.DATABASE_NAME)
        let collection: MongoCollection<Document> = try! mongoDatabase.collection(mongoCollectionName)
        return collection
    }
}

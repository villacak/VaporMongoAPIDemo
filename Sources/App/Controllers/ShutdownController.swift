//
//  ShutdownController.swift
//  App
//
//  Created by Klaus Villaca on 6/19/19.
//

import Vapor
import MongoSwift

final class ShutdownController {
    
    func prepareShutdown(_ req: Request) throws -> Future<HTTPResponse> {
        return try req.content.decode(ShutdownServer.self).map(to: HTTPResponse.self) { shutdownServer in
            let response: HTTPResponse!
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
            
            if (shutdownServer.user.isBlankUtils
                || shutdownServer.token.isBlankUtils
                || shutdownServer.body.isBlankUtils ) {
                let responseMessages = ResponseMessages(httpCode: HTTPStatus.badRequest.code, messages: ["Bad data."])
                let jsonData = try jsonEncoder.encode(responseMessages)
                let dataReturn = String(data: jsonData, encoding: String.Encoding.utf8)
                response = HTTPResponse(status: HTTPResponseStatus.badRequest, body: dataReturn!)
            } else {
                let responseMessages = ResponseMessages(httpCode: HTTPStatus.ok.code, messages: ["Container ready to shutdown."])
                let jsonData = try jsonEncoder.encode(responseMessages)
                let dataReturn = String(data: jsonData, encoding: String.Encoding.utf8)
                response = HTTPResponse(status: HTTPResponseStatus.ok, body: dataReturn!)
                cleanupMongoSwift()
//                try? req.eventLoop.close()
//                try? req.eventLoop.syncShutdownGracefully()
                //                try? app(.detect()).syncShutdownGracefully()
            }
            return response
        }
    }
}

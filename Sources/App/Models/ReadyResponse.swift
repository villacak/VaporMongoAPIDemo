//
//  ReadyResponse.swift
//  App
//
//  Created by Klaus Villaca on 6/19/19.
//

import Vapor

public final class ReadyResponse: Codable {
    
    static func success(messageString: String, dataString: String) throws -> HTTPResponse {
        let responseMessages: ResponseMessages!
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        
        // Validate messageString
        let message: String!
        if (messageString.isEmpty) {
            message = HTTPStatus.ok.reasonPhrase
        } else {
            message = messageString
        }
        
        // Validate dataString
        if (dataString.isEmpty) {
            responseMessages = ResponseMessages(httpCode: HTTPStatus.ok.code, messages: [message])
        } else {
            responseMessages = ResponseMessages(httpCode: HTTPStatus.ok.code, messages: [dataString, message])
        }
        let jsonData = try jsonEncoder.encode(responseMessages)
        let dataReturn = String(data: jsonData, encoding: String.Encoding.utf8)
        let responseBadRequest = HTTPResponse(status: HTTPResponseStatus.ok, body: dataReturn!)
        return responseBadRequest
    }
    
    
    static func badRequest(dataString: String) throws -> HTTPResponse {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        let responseMessages = ResponseMessages(httpCode: HTTPStatus.badRequest.code, messages: [dataString, "Bad data."])
        let jsonData = try jsonEncoder.encode(responseMessages)
        let dataReturn = String(data: jsonData, encoding: String.Encoding.utf8)
        let responseBadRequest = HTTPResponse(status: HTTPResponseStatus.badRequest, body: dataReturn!)
        return responseBadRequest
    }
    
    
    static func internalServerError(dataString: String) throws -> HTTPResponse {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        let responseMessages = ResponseMessages(httpCode: HTTPStatus.internalServerError.code, messages: [dataString, HTTPStatus.internalServerError.reasonPhrase])
        let jsonData = try jsonEncoder.encode(responseMessages)
        let dataReturn = String(data: jsonData, encoding: String.Encoding.utf8)
        let responseBadRequest = HTTPResponse(status: HTTPResponseStatus.internalServerError, body: dataReturn!)
        return responseBadRequest
    }
    
}

import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post("shutdownServer") { req -> Future<HTTPResponse> in
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
                let responseMessages = ResponseMessages(httpCode: HTTPStatus.ok.code, messages: ["Shutting down the container."])
                let jsonData = try jsonEncoder.encode(responseMessages)
                let dataReturn = String(data: jsonData, encoding: String.Encoding.utf8)
                response = HTTPResponse(status: HTTPResponseStatus.ok, body: dataReturn!)
//                cleanupMongoSwift()
                //                try? app(.detect()).syncShutdownGracefully()
            }
            return response
        }
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

import Vapor
import MongoSwift

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
    
    
    // Close all MongoDB connections and leave the container ready for be stopped
    let shutdownController = ShutdownController()
    router.post("prepareContainerShutdown", use: shutdownController.prepareShutdown)
    

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    
//     CURD for MongoDB
    let mongoCRUD = MongoCRUDController()
    router.put("insertRecord", use: mongoCRUD.insertRecord)
    
//    router.put("insertRecord") { req throws -> Future<HTTPResponse> in
//        let mongoCRUD = MongoCRUDController()
//        let httpResponse = try! mongoCRUD.insertRecord(req)
//        return httpResponse
//    }
    

}

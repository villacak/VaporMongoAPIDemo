import FluentSQLite
import Vapor
import MongoSwift

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentSQLiteProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)
    
    // MongoDB Connection
    let clientMongoDB = try! MongoClient("mongodb://admin:password@localhost:27017")
    let db = try! clientMongoDB.db(Constant.DATABASE_NAME)
    let mongoCollection: MongoCollection<Document>
    do {
        mongoCollection = try db.createCollection(Constant.COLLECTION_NAME)
    } catch {
        mongoCollection = try db.collection(Constant.COLLECTION_NAME)
    }
    cleanupMongoSwift()
    services.register(clientMongoDB)
}

extension MongoClient: Service {}

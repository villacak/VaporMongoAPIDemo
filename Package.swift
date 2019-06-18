// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "apiDemo02",
    products: [
        .library(name: "apiDemo02", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        // MongoDB
        .package(url: "https://github.com/mongodb/mongo-swift-driver.git", .upToNextMajor(from: "0.1.0"))
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "MongoSwift"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)


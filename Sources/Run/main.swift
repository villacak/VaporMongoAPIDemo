import App

do {
    try app(.detect()).run()
} catch {
    try? app(.detect()).syncShutdownGracefully()
    throw error
}


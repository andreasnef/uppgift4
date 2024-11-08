//
//  ModernaSwiftUppgift4App.swift
//  ModernaSwiftUppgift4
//
//  Created by Andreas Nef on 07.11.2024.
//

import SwiftUI
import SwiftData

@main
struct ModernaSwiftUppgift4App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

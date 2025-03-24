//
//  prioritizerApp.swift
//  prioritizer
//
//  Created by Alexa G on 3/24/25.
//

import SwiftUI

@main
struct prioritizerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TasksView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

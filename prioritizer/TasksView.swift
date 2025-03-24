//  ContentView.swift
//  prioritizer
//
//  Created by Alexa G on 3/24/25.
//

import SwiftUI
import CoreData


struct TasksView: View {
    @Environment(\.managedObjectContext) private var viewContext
    private var repository: TaskRepository {
            TaskRepository(context: viewContext)
        }
    
    @State private var viewModel = ViewModel()
    @State private var showAddTaskView = false

    @FetchRequest(
        entity: TaskItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.taskId, ascending: true)],
        animation: .default)
    private var taskItems: FetchedResults<TaskItem>

    var body: some View {
        NavigationStack {
    
            List {
                ForEach(taskItems) { task in // Temporary static data
                    TaskRow(task: task)
                }
                .onDelete(perform: deleteItems)
                
            }
            .navigationTitle("Tasks")
        
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: AddTaskView(repository: repository)) {
                        Label("Add Task", systemImage: "plus")
                    }
                }
            }
        }
    }
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { taskItems[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    TasksView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

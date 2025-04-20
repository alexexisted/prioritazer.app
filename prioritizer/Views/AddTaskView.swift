//
//  AddTask.swift
//  prioritizer
//
//  Created by Alexa G on 3/25/25.
//

import Foundation

import SwiftUI

struct AddTaskView: View {
    
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(repository: TaskRepository) {
            _viewModel = State(initialValue: ViewModel(repository: repository))
        }
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $viewModel.taskName)
                TextField("Description", text: $viewModel.taskDescription)
            }
            
            Section(header: Text("Deadline")) {
                DatePicker("Select Date", selection: $viewModel.deadline, displayedComponents: .date)
            }
            
            Section(header: Text("Estimated Time")) {
                Picker("Time (hours)", selection: $viewModel.estimatedTime) {
                    ForEach(1...20, id: \.self) { time in
                        Text("\(time) h").tag(time)
                    }
                }
            }
            
            Section(header: Text("Priority Settings")) {
                Picker("Urgency", selection: $viewModel.urgency) {
                    ForEach(1...5, id: \.self) { level in
                        Text("\(level)").tag(level)
                    }
                }
                Picker("Importance", selection: $viewModel.importance) {
                    ForEach(1...5, id: \.self) { level in
                        Text("\(level)").tag(level)
                    }
                }
            }
            
            HStack {
                Button("Cancel", action: {dismiss()})
                .font(.system(.title3, design: .rounded))
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .clipShape(Capsule())
                .keyboardShortcut(.cancelAction)
                
                Spacer(minLength: 100)
                
                Button("Save", action: {
                    viewModel.onSave()
                    dismiss()
                })
                .font(.system(.title3, design: .rounded))
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .clipShape(Capsule())
            }
            .listRowBackground(Color.clear)
            
            
            
            
        }
        .navigationTitle("New Task")
    }
}


//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView(repository: TaskRepository)
//    }
//}

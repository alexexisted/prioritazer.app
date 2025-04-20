//
//  TaskRow.swift
//  prioritizer
//
//  Created by Alexa G on 3/25/25.
//

import Foundation
import SwiftUI
import CoreData

struct TaskRow: View { 
    let task: TaskItem
    @State private var isOn = false
    
    var body: some View {
        HStack {
            Toggle(isOn: $isOn) {
                
            }
            .toggleStyle(CheckboxUIStyle())
            
            VStack(alignment: .leading) {
                Text(task.taskName ?? "Unnamed Task")
                    .font(.headline)

                if let deadline = task.deadline {
                    Text("Deadline: \(formatDate(deadline))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Estimated time: \(task.evaluatedTime) hours")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text("Priority: \(task.priority)/10")
                        .font(.subheadline)
                        .foregroundColor(.red)
                
                }
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    private func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
}

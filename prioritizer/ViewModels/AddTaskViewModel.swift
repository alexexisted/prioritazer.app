//
//  CreateTaskViewModel.swift
//  prioritizer
//
//  Created by Alexa G on 3/27/25.
//

import Foundation
import CoreData

extension AddTaskView {
    @Observable
    class ViewModel {
        
        var taskName: String = ""
        var taskDescription: String = ""
        var deadline: Date = Date()
        var estimatedTime: Int = 2 //in hours
        var urgency: Int = 3
        var importance: Int = 3
        var isDone: Bool = false //for checkboxes to check if task done
        
        private let repository: TaskRepository

        init(repository: TaskRepository) {
            self.repository = repository
        }
        
        
        func onSave() {
            repository.saveTask(
                taskName: taskName,
                description: taskDescription,
                deadline: deadline,
                estimatedTime: estimatedTime,
                urgency: urgency,
                importance: importance)
            
            }
        
        func onCancel() {
        }
        
        private func calculatePriority() -> Int {
            let today = Date()
            let calendar = Calendar.current
            
            let daysLeft = calendar.dateComponents([.day], from: today, to: deadline).day ?? 0
            let urgencyFactor = urgency * 2
            let importanceFactor = importance * 3
            
            let deadlineFactor = max(10 - daysLeft, 1) //than closer deadline then higher priority
            
            let priority = (urgencyFactor + importanceFactor) * deadlineFactor
            return min(priority, 100) //100 is max
            
        }
        
    }
}

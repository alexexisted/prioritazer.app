//
//  TaskRepository.swift
//  prioritizer
//
//  Created by Alexa G on 3/29/25.
//

import CoreData

class TaskRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveTask(taskName: String, 
                  description: String,
                  deadline: Date,
                  estimatedTime: Int,
                  urgency: Int,
                  importance: Int) {
        
        let newTask = TaskItem(context: context)
        newTask.taskId = UUID()
        newTask.taskName = taskName
        newTask.taskDescription = description
        newTask.deadline = deadline
        newTask.evaluatedTime = Int16(estimatedTime)
        newTask.priority = calculatePriority(urgency: urgency, importance: importance, deadline: deadline)
        newTask.isDone = false

        do {
            try context.save()
        } catch {
            print("Failed to save task: \(error)")
        }
    }

    func fetchTasks() -> [TaskItem] {
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }

    private func calculatePriority(urgency: Int, importance: Int, deadline: Date) -> Int16 {
        let today = Date()
        let calendar = Calendar.current

        let daysLeft = calendar.dateComponents([.day], from: today, to: deadline).day ?? 0
        let urgencyFactor = urgency * 2
        let importanceFactor = importance * 3
        let deadlineFactor = max(10 - daysLeft, 1)

        let priority = (urgencyFactor + importanceFactor) * deadlineFactor

        let minPriority = 5
        let maxPriority = 250

        let normalizedPriority = ((Double(priority) - Double(minPriority)) / (Double(maxPriority) - Double(minPriority))) * 10

        return Int16(max(0, min(10, normalizedPriority)))
    }

}

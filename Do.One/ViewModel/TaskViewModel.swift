//
//  TaskViewModel.swift
//  Do.One
//
//  Created by Clément OMNES on 16/03/2025.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    let storageKey = "tasks"
    
    init() {
        loadTasks()
        removeOldTasks()
    }
    
    func addTask(_ title: String) {
        guard !title.isEmpty else { return }
        tasks.append(Task(title: title))
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func removeOldTasks() {
        let threshold = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        tasks.removeAll { $0.isCompleted && $0.createdAt < threshold! }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: savedData) {
            tasks = decodedTasks
        }
    }
}

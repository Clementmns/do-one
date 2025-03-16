//
//  ContentView.swift
//  Do.One
//
//  Created by Clément OMNES on 16/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        VStack {
            Text("Do.One")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.top, 20)
            
            Text("Focus on what matters")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.isCompleted, color: .secondary)
                            .foregroundColor(task.isCompleted ? .secondary : .primary)
                            .font(.body)
                        Spacer()
                        if task.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.purple)
                                .transition(.scale)
                        }
                    }
                    .padding(.vertical, 5)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            viewModel.toggleTaskCompletion(task)
                        }
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        viewModel.deleteTask(at: indexSet)
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
            VStack(spacing: 10) {
                TextField("What’s next?", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding(.horizontal)
                
                Button(action: {
                    withAnimation {
                        viewModel.addTask(newTaskTitle)
                        newTaskTitle = ""
                    }
                }) {
                    Text("Add Task")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 20)
            .background(Color(UIColor.systemGray6))
        }
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    ContentView()
}

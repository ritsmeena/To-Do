//
//  ContentView.swift
//  To-Do
//
//  Created by Ritika Meena on 27/05/24.

import SwiftUI

struct ContentView: View {
    @State private var todos: [TodoItem] = ["Sample Task 1", "Sample Task 2", "Sample Task 3", "Sample Task 4", "Sample Task 5", "Sample Task 6", "Sample Task 7", "Sample Task 8", "Sample Task 9", "Sample Task 10"].map { TodoItem(name: $0, isChecked: false, isDelete: false) }
    @State private var showSheet = false
    @State private var selectedTodoIndex: Int?
    @State private var hideDone = false
    @State private var newToDo = TodoItem(name: "", isChecked: false)
    @State private var onEdit = false
    @State private var selectAllToEdit = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !onEdit{
                    Text("\(todos.count) to-dos")
                        .padding(.leading, 20)
                        .foregroundColor(Color.gray)
                }else {
                    Spacer()
                }
                
                ToDoListView(todos: $todos, onEdit: $onEdit, selectedTodoIndex: $selectedTodoIndex, showSheet: $showSheet, hideDone: $hideDone)
                
            }
            .navigationTitle(onEdit ? "Select items" : "To-dos")
            .navigationBarItems(
                leading:
                    Group {
                        if onEdit {
                            Button(action: {
                                onEdit = false
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                            }
                        }
                    },
                trailing:
                    //conditional view group and any-object
                Group {
                    if onEdit {
                        Button(action: {
                            selectAllToEdit.toggle()
                            todos = todos.map { todo in
                                var updatedTodo = todo
                                updatedTodo.isDelete = selectAllToEdit
                                return updatedTodo
                            }
                            
                        }) {
                            Image(systemName: selectAllToEdit ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectAllToEdit ? .yellow : .gray)
                        }
                    } else {
                        MenuContentView(onEdit: $onEdit, hideDone: $hideDone)
                    }
                }
            )
            .overlay(
                Group {
                    if !onEdit {
                        Button(action: {
                            selectedTodoIndex = nil
                            showSheet.toggle()
                        }) {
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.yellow)
                                .overlay(
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                )
                        }
                        .padding()
                    }
                },
                alignment: .bottomTrailing
            )
            .sheet(isPresented: $showSheet) {
                if let selectedTodoIndex = selectedTodoIndex {
                    EditToDo(showEdit: $showSheet, newTodo: $todos[selectedTodoIndex].name)
                        .presentationDetents([.fraction(0.3)])
                } else {
                    EditToDo(showEdit: $showSheet, newTodo: $newToDo.name)
                        .presentationDetents([.fraction(0.3)])
                        .onDisappear {
                            if !newToDo.name.isEmpty {
                                todos.append(newToDo)
                            }
                            newToDo = TodoItem(name: "", isChecked: false)
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if onEdit {
                        Button(action: {
                            todos.removeAll { $0.isDelete! }
                            onEdit = false
                        }) {
                            Text("Delete")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

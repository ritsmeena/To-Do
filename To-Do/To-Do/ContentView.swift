//
//  ContentView.swift
//  To-Do
//
//  Created by Ritika Meena on 27/05/24.

import SwiftUI

struct ContentView: View {
    @State public var todos: [TodoItem] = ["Sample Task 1", "Sample Task 2", "Sample Task 3", "Sample Task 4", "Sample Task 5", "Sample Task 6", "Sample Task 7", "Sample Task 8", "Sample Task 9", "Sample Task 10"].map { TodoItem(name: $0, isChecked: false, isDelete: false) }
    @State private var showSheet = false
    @State private var selectedTodoIndex: Int?
    @State private var hideDone = false
    @State private var onEdit = false
    @State private var selectAllToEdit = false
    @State private var navTitleOnEdit = "To-Dos"
    @State private var showAlert = false
    @State private var deleteAlertMsg = "This to-do"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if onEdit || todos.isEmpty {
                    Spacer()
                }else {
                    Text("\(todos.count) to-dos")
                        .padding(.leading, 20)
                        .foregroundColor(Color.gray)
                }
                
                if todos.isEmpty || (todos.allSatisfy({ $0.isChecked }) && hideDone){
                    EmptyFileView(animationFileName: "EmptyList")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ToDoListView(todos: $todos, onEdit: $onEdit, selectedTodoIndex: $selectedTodoIndex, showSheet: $showSheet, hideDone: $hideDone, navTitleOnEdit: $navTitleOnEdit)
                }
                
            }
            .navigationTitle(navTitleOnEdit)
            .navigationBarItems(
                leading:
                    Group {
                        if onEdit {
                            Button(action: {
                                onEdit = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.accentColor)
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
                            Text(selectAllToEdit ? "Deselect all" : "Select all")
                                .foregroundColor(.accentColor)
                        }
                    } else if !todos.isEmpty{
                        MenuContentView(onEdit: $onEdit, hideDone: $hideDone, todos: $todos)
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
                                .foregroundColor(.accentColor)
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
                    EditToDo(todos: $todos, showEdit: $showSheet, selectedTodoIndex: $selectedTodoIndex)
                        .presentationDetents([.fraction(0.3)])
                } else {
                    EditToDo(todos: $todos,showEdit: $showSheet, selectedTodoIndex: $selectedTodoIndex)
                        .presentationDetents([.fraction(0.3)])
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if onEdit {
                        Button(action: {
                            let deletedTodosCount = todos.filter { $0.isDelete! }.count
                            if deletedTodosCount > 1 && deletedTodosCount < todos.count {
                                deleteAlertMsg = "\(deletedTodosCount) to-dos"
                            }else if deletedTodosCount == todos.count {
                                deleteAlertMsg = "All to-dos"
                            }
                            showAlert = true
                        }) {
                            Text("Delete")
                        }
                        .alert("Delete this to-do?", isPresented: $showAlert) {
                            Button("Delete") {
                                todos.removeAll { $0.isDelete! }
                                onEdit = false
                                deleteAlertMsg = "This to-do"
                            }
                            Button("Cancel", role: .cancel) {}
                            
                        } message: {
                            Text("\(deleteAlertMsg) will be permanently deleted from this device.")
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

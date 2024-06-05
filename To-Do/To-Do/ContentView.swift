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
    @State private var onEdit = false
    @State private var selectAllToEdit = false
    @State private var navTitleOnEdit = "To-Dos"
    
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
                                .foregroundColor(selectAllToEdit ? .accentColor : .gray)
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

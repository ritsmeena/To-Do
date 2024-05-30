//
//  ContentView.swift
//  To-Do
//
//  Created by Ritika Meena on 27/05/24.

import SwiftUI

struct ContentView: View {
    @State private var todos: [TodoItem] = ["Sample Task 1", "Sample Task 2","Sample Task 3","Sample Task 4","Sample Task 5","Sample Task 6","Sample Task 7","Sample Task 8","Sample Task 9","Sample Task 10","Sample Task 1", "Sample Task 2","Sample Task 3","Sample Task 4","Sample Task 5","Sample Task 6","Sample Task 7","Sample Task 8","Sample Task 9","Sample Task 10","Sample Task 1", "Sample Task 2","Sample Task 3","Sample Task 4","Sample Task 5","Sample Task 6","Sample Task 7","Sample Task 8","Sample Task 9","Sample Task 10"].map { TodoItem(name: $0, isChecked: false) }
    @State private var showSheet = false
    @State private var selectedTodoIndex: Int?
    @State private var hideDone = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(todos.count) to-dos")
                    .padding(.leading, 20)
                    .foregroundColor(Color.gray)
                
                List {
                    
                    Section(){
                        ForEach(todos.indices.filter { !todos[$0].isChecked }, id: \.self){ index in
                            TodoItemView(todo: $todos[index], index: index, onSelect: { index in
                                selectedTodoIndex = index
                                showSheet.toggle()
                            })
                            
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    
                    if !hideDone{
                        Section(header: Text("Done (\(todos.filter { $0.isChecked }.count))")){
                            ForEach(todos.indices.filter { todos[$0].isChecked }, id: \.self) { index in
                                TodoItemView(todo: $todos[index], index: index, onSelect: { index in
                                    selectedTodoIndex = index
                                    showSheet.toggle()
                                })
                                
                            }
                        }
                        .listRowInsets(EdgeInsets())
                    }
                }
                .padding(.horizontal, 20)
                .listStyle(PlainListStyle())
                .listRowSpacing(10)
                .listRowSeparator(.hidden)
            }
            .navigationTitle("To-dos")
            .navigationBarItems(trailing:
                                    Menu {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Edit")
                })
                Button(action: {
                    hideDone.toggle()
                }, label: {
                    Text(hideDone ? "Show completed" : "Hide completed")
                })
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
            }
                .foregroundColor(.black)
            )
            .overlay(
                Button(action: {
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
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                , alignment: .bottomTrailing
            )
            .sheet(isPresented: $showSheet) {
                if let selectedTodoIndex = selectedTodoIndex {
                    EditToDo(showEdit: $showSheet, newTodo: $todos[selectedTodoIndex].name)
                        .presentationDetents([.fraction(0.3)])
                    
                }else{
                    EditToDo(showEdit: $showSheet, newTodo: $todos[todos.count - 1].name)
                        .presentationDetents([.fraction(0.3)])
                }
            }
        }
    }
    func addNewTodo() {
        todos.append(TodoItem(name: "New Task", isChecked: false))
    }
}

#Preview {
    ContentView()
}

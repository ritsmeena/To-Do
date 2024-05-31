//
//  ToDoListView.swift
//  To-Do
//
//  Created by Ritika Meena on 30/05/24.
//

import Foundation
import SwiftUI

struct ToDoListView : View{
    @Binding var todos: [TodoItem] 
    @Binding var onEdit: Bool
    @Binding var selectedTodoIndex: Int?
    @Binding var showSheet: Bool
    @Binding var hideDone: Bool
    
    var  body: some View{
        List {
            Section {
                ForEach(todos.indices.filter { !todos[$0].isChecked }, id: \.self) { index in
                    if !onEdit{
                        TodoItemView(todo: $todos[index], index: index, onSelect: { index in
                            selectedTodoIndex = index
                            showSheet.toggle()
                            
                        })}else {
                            ToDoItemDeleteView(index: index, todo: $todos[index])
                        }
                }
            }
            .listRowInsets(EdgeInsets())
            
            if !hideDone && (todos.filter { $0.isChecked }.count > 0) {
                Section(header: Group {
                    if todos.filter { $0.isChecked }.count > 0 {
                        Text("Done (\(todos.filter { $0.isChecked }.count))")
                    }
                }) {
                    ForEach(todos.indices.filter { todos[$0].isChecked }, id: \.self) { index in
                        if !onEdit{
                            TodoItemView(todo: $todos[index], index: index, onSelect: { index in
                                selectedTodoIndex = index
                                showSheet.toggle()
                                
                            })}else {
                                ToDoItemDeleteView(index: index, todo: $todos[index])
                            }
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
}

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
    @Binding var navTitleOnEdit: String
    
    var  body: some View{
        VStack {
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
        .onAppear {
                    updateNavTitle()
                }
        .onChange(of: todos){
                    updateNavTitle()
                }
        .onChange(of: onEdit){
                    updateNavTitle()
                }
        .onDisappear{
            updateNavTitle()
        }
    }
    
    private func updateNavTitle() {
        if !onEdit{
            navTitleOnEdit = "ToDos"
            
        } else {
            
            let selectedCount = todos.filter { $0.isDelete! }.count
            if selectedCount > 0 && selectedCount != todos.count {
                navTitleOnEdit = "\(selectedCount) Selected"
            } else if selectedCount == todos.count {
                navTitleOnEdit = "All Selected"
            } else {
                navTitleOnEdit = "Select Items"
            }
        }
        
    }
}

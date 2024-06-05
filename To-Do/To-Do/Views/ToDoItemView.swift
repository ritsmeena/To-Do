//
//  ToDoItemView.swift
//  To-Do
//
//  Created by Ritika Meena on 29/05/24.
//

import Foundation
import SwiftUI

struct TodoItem: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var isChecked: Bool
    var isDelete: Bool?
}

struct TodoItemView : View {
    @Binding var todo: TodoItem
    var index: Int
    var onSelect: (Int) -> Void
    
    var body: some View {
        Rectangle()
            .frame(height: 50)
            .foregroundColor(todo.isChecked ? Color.gray.opacity(0.1) : Color.accentColor.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Spacer()
                    Toggle(isOn: $todo.isChecked) {
                        Text(todo.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .foregroundColor(todo.isChecked ? .gray : .black)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onSelect(index)
                    })
    }
}

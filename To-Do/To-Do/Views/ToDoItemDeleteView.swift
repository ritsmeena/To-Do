//
//  ToDoItemDeleteView.swift
//  To-Do
//
//  Created by Ritika Meena on 30/05/24.
//

import Foundation
import SwiftUI

struct ToDoItemDeleteView: View {
    var index: Int
    @Binding var todo: TodoItem
    
    var body: some View {
        Rectangle()
            .frame(height: 50)
            .foregroundColor(todo.isChecked ?? false ? Color.gray.opacity(0.1) : Color.accentColor.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Text(todo.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        todo.isDelete?.toggle()
                    }) {
                        Image(systemName: todo.isDelete ?? false ? "checkmark.square.fill" : "square")
                            .foregroundColor(todo.isDelete ?? false ? .accentColor : .gray)
                    }
                    .frame(alignment: .trailing)
                    .padding(.trailing, 20)
                }
                .contentShape(Rectangle())
            )
            .onTapGesture {
                todo.isDelete?.toggle()
            }
    }
}

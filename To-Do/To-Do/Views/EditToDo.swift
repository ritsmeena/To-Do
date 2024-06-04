//
//  EditToDo.swift
//  To-Do
//
//  Created by Ritika Meena on 28/05/24.
//

import Foundation
import SwiftUI

struct EditToDo: View {
    
    @Binding var todos: [TodoItem]
    @Binding var showEdit: Bool
    @Binding private var selectedTodoIndex: Int?
    @State private var setReminder = false
    @State private var newTodoTextField: String = ""
    
    init(todos: Binding<[TodoItem]>, showEdit: Binding<Bool>, selectedTodoIndex: Binding<Int?>) {
        self._todos = todos
        self._showEdit = showEdit
        self._selectedTodoIndex = selectedTodoIndex
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    if (todos[selectedTodoIndex!].name == "") && (newTodoTextField == "") {
                        todos.remove(at: selectedTodoIndex!)
                    }
                    showEdit.toggle()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.accentColor)
                })
                Spacer()
                Text(selectedTodoIndex != nil ? "Edit To-Do" : "New to-do")
                Spacer()
                Button(action: {
                    if newTodoTextField == ""{
                        todos.remove(at: selectedTodoIndex!)
                    }else {
                        todos[selectedTodoIndex!].name = newTodoTextField
                    }
                    showEdit.toggle()
                }, label: {
                    Text("Save")
                        .foregroundColor(.accentColor)
                })
            }
            .padding()
            TextField("New to-do", text: $newTodoTextField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Button(action: {
                    setReminder.toggle()
                }, label: {
                    Image(systemName: "bell")
                        .foregroundColor(.black)
                })
                Spacer()
            }
            .padding(.vertical)
            .padding(.leading, 20)
        }
        .onAppear {
            if let index = selectedTodoIndex, index < todos.count {
                newTodoTextField = todos[index].name
            }
        }
        .sheet(isPresented: $setReminder) {
            ScheduleReminder(setReminder: $setReminder)
                .presentationDetents([.fraction(0.8)])
        }
    }
}

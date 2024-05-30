//
//  EditToDo.swift
//  To-Do
//
//  Created by Ritika Meena on 28/05/24.
//

import Foundation
import SwiftUI

struct EditToDo: View {
    
    @Binding var showEdit: Bool
    @Binding var newTodo: String
    @State private var setReminder = false
    @State private var newTodoTextField: String = ""
    
    init(showEdit: Binding<Bool>, newTodo: Binding<String>) {
        _showEdit = showEdit
        _newTodo = newTodo
        _newTodoTextField = State(initialValue: newTodo.wrappedValue)
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    showEdit.toggle()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.yellow)
                })
                Spacer()
                Text("Edit To-Do")
                Spacer()
                Button(action: {
                    newTodo = newTodoTextField
                    showEdit.toggle()
                }, label: {
                    Text("Save")
                        .foregroundColor(.yellow)
                })
            }
            .padding()
            TextField("Edit to-do", text: $newTodoTextField)
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
        .sheet(isPresented: $setReminder) {
            ScheduleReminder(setReminder: $setReminder)
                    .presentationDetents([.fraction(0.8)])
        }
    }
}

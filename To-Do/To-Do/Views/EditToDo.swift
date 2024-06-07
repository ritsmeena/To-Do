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
    
    @State private var newReminderDate: Date? = nil
    @State private var newReminderTime: Date? = nil
    @State private var newRepeat: String = "Never"
    @State private var newAlarmIsOn: Bool = false

    init(todos: Binding<[TodoItem]>, showEdit: Binding<Bool>, selectedTodoIndex: Binding<Int?>) {
        self._todos = todos
        self._showEdit = showEdit
        self._selectedTodoIndex = selectedTodoIndex
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    if let selectedTodoIndex = selectedTodoIndex{
                        if (todos[selectedTodoIndex].name == "") && (newTodoTextField == "") {
                            todos.remove(at: selectedTodoIndex)
                        }
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
                    if newTodoTextField == "" {
                        if let index = selectedTodoIndex {
                            todos.remove(at: index)
                        }
                    } else {
                        if let index = selectedTodoIndex {
                            todos[index].name = newTodoTextField
                            todos[index].reminderDate = newReminderDate
                            todos[index].reminderTime = newReminderTime
                            todos[index].Repeat = newRepeat
                            todos[index].alarmIsOn = newAlarmIsOn
                        } else {
                            todos.append(TodoItem(name: newTodoTextField, isChecked: false, reminderDate: newReminderDate, reminderTime: newReminderTime, Repeat: newRepeat, alarmIsOn: newAlarmIsOn))
                        }
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
                Group {
                    if let selectedTodoIndex = selectedTodoIndex,
                       let reminderDate = todos[selectedTodoIndex].reminderDate,
                       let reminderTime = todos[selectedTodoIndex].reminderTime {
                        HStack {
                            Button(action: {
                                setReminder.toggle()
                            }, label: {
                                Image(systemName: "bell")
                                    .foregroundColor(.black.opacity(0.8))
                                Text(getReminder(reminderDate: reminderDate, reminderTime: reminderTime))
                            })
                            Button(action:{
                                todos[selectedTodoIndex].reminderDate = nil
                                todos[selectedTodoIndex].reminderTime = nil
                                todos[selectedTodoIndex].Repeat = "Never"
                                todos[selectedTodoIndex].alarmIsOn = false
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black.opacity(0.8))
                            })
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    } else if newReminderDate != nil && newReminderTime != nil {
                        HStack {
                            Button(action: {
                                setReminder.toggle()
                            }, label: {
                                Image(systemName: "bell")
                                    .foregroundColor(.black.opacity(0.8))
                                Text(getReminder(reminderDate: newReminderDate!, reminderTime: newReminderTime!))
                            })
                            Button(action: {
                                newReminderDate = nil
                                newReminderTime = nil
                                newRepeat = "Never"
                                newAlarmIsOn = false
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black.opacity(0.8))
                            })
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    } else {
                        Button(action: {
                            setReminder.toggle()
                        }, label: {
                            Image(systemName: "bell")
                                .foregroundColor(.black.opacity(0.8))
                        })
                    }
                }
                Spacer()
            }
            
            .padding(.vertical)
            .padding(.leading, 20)
        }
        .onAppear {
            if let index = selectedTodoIndex, index < todos.count {
                newTodoTextField = todos[index].name
                newReminderDate = todos[index].reminderDate
                newReminderTime = todos[index].reminderTime
                newRepeat = todos[index].Repeat
                newAlarmIsOn = todos[index].alarmIsOn ?? false
            }
        }
        .sheet(isPresented: $setReminder) {
            ScheduleReminder(setReminder: $setReminder, repeatOption: $newRepeat, reminderDate: $newReminderDate, reminderTime: $newReminderTime, alarmIsOn: $newAlarmIsOn)
                .presentationDetents([.large])
        }
    }
    
    func getReminder(reminderDate: Date, reminderTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        let formattedDate = dateFormatter.string(from: reminderDate)
        let formattedTime = timeFormatter.string(from: reminderTime)
        
        return "\(formattedDate), \(formattedTime)"
    }
}

//
//  ScheduleReminder.swift
//  To-Do
//
//  Created by Ritika Meena on 29/05/24.
//

import SwiftUI

struct ScheduleReminder: View {
    @Binding var setReminder: Bool
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var dateIsSelected = true
    @State private var timeIsSelected = false
    @State private var Repeat: String = "Never"
    @State private var alarmIsOn = false
    @State private var repeatOptions = ["Never", "Every day", "Every week", "Every 2 weeks", "Every month", "Every year"]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    setReminder.toggle()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.yellow)
                })

                Spacer()

                Text("Schedule Reminder")

                Spacer()

                Button(action: {
                    setReminder.toggle()
                }, label: {
                    Text("Save")
                        .foregroundColor(.yellow)
                })
            }
            .padding()

            VStack {
                HStack {
                    Text("Remind me on")

                    Spacer()

                    Button(action: {
                        dateIsSelected.toggle()
                        if timeIsSelected {
                            timeIsSelected = false
                        }
                    }) {
                        Text(formattedDate)
                            .padding()
                            .background(dateIsSelected ? Color.black : Color.gray.opacity(0.3))
                            .foregroundColor(dateIsSelected ? Color.white : Color.black)
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        timeIsSelected.toggle()
                        if dateIsSelected {
                            dateIsSelected = false
                        }
                    }) {
                        Text(formattedTime)
                            .padding()
                            .background(timeIsSelected ? Color.black : Color.gray.opacity(0.3))
                            .foregroundColor(timeIsSelected ? Color.white : Color.black)
                            .cornerRadius(8)
                    }
                }
                .padding()

                if dateIsSelected {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.horizontal)
                } else if timeIsSelected {
                    DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding(.horizontal)
                }

                List {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Repeat")
                                .foregroundColor(.black)
                            Text("\(Repeat)")
                                .foregroundColor(.yellow)
                        }
                        Spacer()
                        Menu {
                            ForEach(repeatOptions, id: \.self) { option in
                                Button(action: {
                                    Repeat = option
                                }) {
                                    Text(option)
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }

                    HStack {
                        Text("Alarm")
                        Spacer()
                        Toggle(isOn: $alarmIsOn) {
                            Text("")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .yellow))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        alarmIsOn.toggle()
                    }
                }
                .scrollDisabled(true)
            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(8)
            )
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedTime)
    }
}

import SwiftUI

struct ScheduleReminder: View {
    @Binding var setReminder: Bool
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var dateIsSelected = false
    @State private var timeIsSelected = false
    
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
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                ViewThatFits {
                    if dateIsSelected {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding(.horizontal)
                            .cornerRadius(8)
                    } else if timeIsSelected {
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .padding(.horizontal)
                            .cornerRadius(8)
                    }
                }
                .padding()
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

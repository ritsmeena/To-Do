//
//  MenuContentView.swift
//  To-Do
//
//  Created by Ritika Meena on 30/05/24.
//

import Foundation
import SwiftUI

struct MenuContentView : View{
    @Binding var onEdit: Bool
    @Binding var hideDone: Bool
    @Binding var todos: [TodoItem]
    
    var body: some View{
        Menu {
            if todos.filter{$0.isChecked}.count == todos.count && hideDone{
                
            }else {
                Button(action: {
                    onEdit.toggle()
                }, label: {
                    Text("Edit")
                })
            }
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
    }
}

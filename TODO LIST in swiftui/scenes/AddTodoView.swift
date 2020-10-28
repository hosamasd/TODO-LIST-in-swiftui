//
//  AddTodoView.swift
//  TODO LIST in swiftui
//
//  Created by hosam on 10/27/20.
//

import SwiftUI
import CoreData

struct AddTodoView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var pritority = "Normal"
    
    @State private var errorShowing = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    let priorites = ["High","Normal","Low"]
    
    
    var body: some View {
        NavigationView{
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Todo",text:$name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    Picker("Priority",selection:$pritority){
                        ForEach(priorites,id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if name != "" {
                        let todo = Todo(context:self.managedObjectContext)
                        todo.name=self.name
                        todo.priority=self.pritority
                        
                        do {
                            try self.managedObjectContext.save()
                          
                        }catch {
                            print(error)
                        }
                            
                        }else {
                            errorShowing=true
                            errorTitle="Invalid Name"
                            errorMessage="Make sure to input valid name"
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    })
                   
                }
                .padding(.horizontal)
                .padding(.vertical,30)
                Spacer()
            }
            
            .navigationBarTitle("New Todo",displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                    })
            
            .alert(isPresented: $errorShowing, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            })
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}

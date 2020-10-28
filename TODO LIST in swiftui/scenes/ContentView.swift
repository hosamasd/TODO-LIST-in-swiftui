//
//  ContentView.swift
//  TODO LIST in swiftui
//
//  Created by hosam on 10/27/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var iconsSettings:IconsNames
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos:FetchedResults<Todo>
    @State private var showAdd=false
    @State private var animateButton=false
    @State private var showSettingViews=false
    
    var body: some View {
        NavigationView  {
            ZStack {
                List {
                    ForEach(self.todos) {todo in
                        HStack{
                            Text(todo.name ?? "UNKNOWN")
                            Spacer()
                            Text(todo.priority ?? "UNKNOWN")
                        }
                        
                    }
                    .onDelete(perform:deleteTodo)
                }
                
                .navigationBarTitle("New Todo",displayMode: .inline)
                
                .navigationBarItems(
                    leading:EditButton(),
                    trailing:
                        Button(action: {
                            self.showSettingViews.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        }
                        .sheet(isPresented: $showSettingViews, content: {
                            SettingView().environmentObject(self.iconsSettings)
                            //                                .environment(\.managedObjectContext, self.managedObjectContext)
                        })
                )
                
                if todos.count == 0 {
                    EmptyListView()
                }
                
            }
            .sheet(isPresented: $showAdd) {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animateButton ?  0.2 : 0)
                            .scaleEffect(self.animateButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animateButton ? 0.15 : 0)
                            .scaleEffect(self.animateButton ? 1 : 0)
                            
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeIn)
                    //                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    
                    Button(action: {
                        self.showAdd.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit().background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                    .onAppear(perform: {
                        self.animateButton.toggle()
                    })
                }
                .padding(.bottom,15)
                .padding(.trailing,15)
                ,alignment: .bottomTrailing
            )
            
        }
        
    }
    
    private func deleteTodo(at offsets:IndexSet){
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch  {
                print(error)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        ContentView()
            .environment(\.managedObjectContext, context)
    }
}

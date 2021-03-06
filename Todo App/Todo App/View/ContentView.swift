//
//  ContentView.swift
//  Todo App
//
//  Created by Naufal Gagambani Sumbi on 15/02/21.
//

import SwiftUI

struct ContentView: View {
   
    //Mark: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
   
    @FetchRequest( entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)] ) var todos: FetchedResults<Todo>
    
    @EnvironmentObject var iconSettings: IconNames
   
    @State private var showingSettingsView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
   
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
   
    //Mark: - Body
    var body: some View{
       
        NavigationView{
            ZStack{
                List{
                    ForEach(self.todos, id: \.self) { todo in
                        HStack{
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(.pink)
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                           
                            Spacer()
                           
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                           
                        }//: HStack
                        .padding(.vertical, 10)
                       
                    }//: ForEach
                    .onDelete(perform: deleteTodo)
                }//:List
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton().accentColor(themes[self.theme.themeSettings].themeColor),
                    trailing:
                        Button(action: {
                            self.showingSettingsView.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        }//: Setting Button
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                        .sheet(isPresented: $showingSettingsView) {
                            SettingsView().environmentObject(self.iconSettings)
                        }
                )
               
                if todos.count == 0 {
                    EmptyListView()
                }
            }//:ZStack
            .sheet(isPresented: $showingAddTodoView){
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
           
        }//:Navigation
    }
    //MARK: Functions
    //Delete
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
           
            do {
                try managedObjectContext.save()
               
            } catch {
                print(error)
            }
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
            .previewDevice("iphone 11 pro")
    }
}

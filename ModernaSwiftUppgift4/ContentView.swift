//
//  ContentView.swift
//  ModernaSwiftUppgift4
//
//  Created by Andreas Nef on 07.11.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Todo]

    @State private var newDesc: String = ""
    
     // Static DateFormatter for reuse
     private static let dateFormatter: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .short
         return formatter
     }()

    var body: some View {
        NavigationSplitView {
            HStack {
                TextField("New Todo", text: $newDesc)
                Button(action: addItem) {
                    Label("Add Todo", systemImage: "plus")
                }
            }.padding()
            List {
                ForEach(items.sorted(by: { !$0.isCompleted && $1.isCompleted })) { todo in
                    HStack {
                        Text(Self.dateFormatter.string(from: todo.created))
                        Text(todo.desc)
                        Text(todo.isCompleted ? "(done)" : "(open)")
                    }.padding()
                    .onTapGesture {
                        todo.isCompleted.toggle()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newTodo = Todo(desc: newDesc)
            modelContext.insert(newTodo)
            newDesc = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self, inMemory: true)
}

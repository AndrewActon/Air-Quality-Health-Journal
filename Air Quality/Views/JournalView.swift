//
//  JournalView.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/23/24.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) var context
    @ObservedObject var homeScreenViewModel = HomeScreenViewModel()
    @Query(sort: \JournalEntry.date) var entries: [JournalEntry]
    @State private var isShowingEntrySheet = false
    @State private var entryToEdit: JournalEntry?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(entries) { entry in
                    EntryCell(entry: entry)
                        .environmentObject(homeScreenViewModel)
                        .onTapGesture {
                            entryToEdit = entry
                        }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(entries[index])
                    }
                })
            }
            .navigationTitle("Journal Entries")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingEntrySheet, content: { NewEntrySheet() })
            .sheet(item: $entryToEdit) { entry in
                UpdateEntrySheet(entry: entry)
            }
            .toolbar {
                if !entries.isEmpty {
                    Button("Create New Journal Entry", systemImage: "plus") {
                        isShowingEntrySheet = true
                    }
                }
            }
            .overlay {
                if entries.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Journal Entries", systemImage: "book.pages")
                    }, description: {
                        Text("Create a new journal entry to track your health compared to local air quality.")
                    }, actions: {
                        Button("New Entry") { isShowingEntrySheet = true }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}



#Preview {
    JournalView()
}

//
//  AllRoutinesView.swift
//  BluesMaker
//
//  Created by Kangiriyanka The Single Leaf on 2025/04/22.
//

import SwiftUI
import SwiftData

struct AllRoutinesView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var routines: [Routine]
    @State private var isPresentingConfirmed: Bool = false
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            
            if routines.isEmpty {
               
                ContentUnavailableView {
                    Label("No routines added", systemImage: "music.quarternote.3")
                } description: {
                    Text("Add your first routine by tapping the \(Image(systemName: "figure.dance")) button in the Routines tab.").padding([.top], 5)
                }
                
            }
            
            List {
                ForEach(routines) { routine in
                    HStack {
                        NavigationLink(destination: EditRoutineView(routine: routine)) {
                            HStack {
                                Text("\(routine.title)")
                                
                                Spacer()
                                Text("\(routine.parts.count)")
                                    .foregroundStyle(.secondary)
                                    .padding(5)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray,style: StrokeStyle(lineWidth: 1))
                                    )
                            }
                       
                           
                           
                        }
                     
                        
                        
                      
                        
                    }
                }
                
            }
           
            
            .navigationTitle("All Routines")
            .searchable(text: $searchText , placement: .navigationBarDrawer(displayMode: .always))
//            #if targetEnvironment(simulator)
//            .toolbar {
//                
//                Button("Clear Routines",   systemImage: "trash", role: .destructive) {
//                    isPresentingConfirmed = true
//                }
//                .confirmationDialog("Are you sure?",
//                                    isPresented: $isPresentingConfirmed) {
//                    Button("Would you like to clear all routines?", role: .destructive) {
//                        deleteAllRoutines()
//                    }
//                }
//                
//           
//                }
//            #endif
                
            }
    }
    
    func deleteAllRoutines() {
        
        let fileManager = FileManager.default
        for routine in routines {
            routine.parts.forEach { part in
                
                if let partURL = part.location {
                    do {
                        try fileManager.removeItem(at: partURL)
                        
                    } catch {
                        print("Error: \(error)")
                    }
                    
                }
                
                
            }
        }
        
        for routine in routines {
            modelContext.delete(routine)
            
        }
        
    }
}

#Preview {
    let container = Routine.preview
    
    AllRoutinesView()
        .modelContainer(container)
  
}

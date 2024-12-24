//
//  HomeView.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 24/12/24.
//

import SwiftUI
import MaterialComponents.MaterialButtons

struct HomeView: View {
    @Binding var notes: [Note]
    var onAddNote: () -> Void
    var onSearch: () -> Void
    var onDelete: (Int) -> Void
    var onSelectNote: (Int) -> Void

    var body: some View {
        ZStack {
            Color("appBlack")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                // Header
                HStack {
                    Text("Notes")
                        .font(.custom("Nunito-SemiBold", size: 43))
                        .foregroundColor(Color("background"))
                        .padding(.leading, 24)
                    
                    Spacer()
                    
                    Button(action: {
                        onSearch()
                    }) {
                        Image("search")
                            .frame(width: 50, height: 50)
                            .background(Color("appGray"))
                            .cornerRadius(15)
                    }
                    .padding(.trailing, 25)
                }
                .padding(.top, 75)
                
                // Notes List
                if notes.isEmpty {
                    
                    Spacer()
                    PlaceholderView()
                        .frame(maxWidth: .infinity)
                    Spacer() 
                } else {
                    List {
                        ForEach(notes.indices, id: \.self) { index in
                            NoteRow(note: notes[index])
                                .onTapGesture {
                                    onSelectNote(index)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        onDelete(index)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            
            // Floating Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        onAddNote()
                    }) {
                        Image("add")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .background(Color("appBlack"))
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding(.bottom, 49)
                    .padding(.trailing, 35)
                }
            }
        }
    }
}

struct NoteRow: View {
    let note: Note
    
    var body: some View {
        Text(note.title ?? "No Title")
    }
}

struct PlaceholderView: View {
    var body: some View {
        VStack {
            Image("notesImg")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text("Create your first note!")
                .font(.custom("Nunito-Regular", size: 20))
                .foregroundColor(Color("background"))
                .padding(.top, 8)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            notes: .constant([]),
            onAddNote: {},
            onSearch: {},
            onDelete: { _ in },
            onSelectNote: { _ in }
        )
        .previewLayout(.device)
        .background(Color("appBlack"))
    }
}

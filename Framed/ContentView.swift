//
//  ContentView.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedAlbum = [Album]()

    @Query var albums: [Album]

    var body: some View {
        NavigationStack(path: $selectedAlbum) {
            List {
                ForEach(albums) { album in
                    NavigationLink(value: album) {
                        Text("\(album.name) (\(album.photos.count))")
                    }
                }
                .onDelete(perform: deleteAlbum)
            }
            .navigationTitle("Framed")
            .navigationDestination(for: Album.self, destination: AlbumEditor.init)
            .toolbar {
                Button("Add new album", systemImage: "plus", action: createNewAlbum)
            }
        }
    }

    func createNewAlbum() {
        let newAlbum = Album(name: "New album", photos: [], speed: 10)
        modelContext.insert(newAlbum)
        try? modelContext.save()
        selectedAlbum = [newAlbum]
    }

    func deleteAlbum(_ indexSet: IndexSet) {
        for item in indexSet {
            let album = albums[item]
            modelContext.delete(album)
        }
    }
}

#Preview {
    ContentView()
}

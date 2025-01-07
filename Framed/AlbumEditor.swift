//
//  AlbumEditor.swift
//  Framed
//
//  Created by Eric on 07/01/2025.
//

import PhotosUI
import SwiftUI

struct AlbumEditor: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @Environment(\.modelContext) private var modelContext
    @Bindable var album: Album

    let gridItems: [GridItem] = [.init(.adaptive(minimum: 100, maximum: 100))]

    var body: some View {
        Form {
            LazyVGrid(columns: gridItems) {
                ForEach(album.photos, id: \.self) { photo in
                    Text(photo)
                }
            }
            .listRowBackground(Color.clear)
        }
            .toolbar {
                PhotosPicker(selection: $selectedItems, matching: .images) {
                    Label("Select images", systemImage: "photo.badge.plus")
                }
            }
            .onChange(of: selectedItems) {
                Task {
                    for item in selectedItems {
                        guard let imageData = try? await item.loadTransferable(type: Data.self) else { continue }

                        let imageID = UUID().uuidString

                        do {
                            try imageData.write(to: imageID.documentsURL)
                            album.photos.append(imageID)
                        } catch {
                            print("Failed to write image to \(imageID.documentsURL): \(error.localizedDescription)")
                        }
                    }
                    selectedItems.removeAll()
                    try? modelContext.save()
                }
            }
    }
}

#Preview {
    AlbumEditor(album: Album(name: "Preview Album", photos: [], speed: 10))
}

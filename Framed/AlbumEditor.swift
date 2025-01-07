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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .toolbar {
                PhotosPicker(selection: $selectedItems, matching: .images) {
                    Label("Select images", systemImage: "photo.badge.plus")
                }
            }
            .onChange(of: selectedItems) {
                Task {
                    for item in selectedItems {
                        guard let imageData = try? await item.loadTransferable(type: Data.self) else { continue }
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

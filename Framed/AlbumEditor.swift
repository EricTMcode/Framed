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
    @State private var slideshowAlbum: Album?
    @Bindable var album: Album

    let gridItems: [GridItem] = [.init(.adaptive(minimum: 100, maximum: 100))]

    var body: some View {
        Form {
            Section {
                Picker("Speed", selection: $album.speed) {
                    Text("Slow (60s)").tag(60)
                    Text("Medium (30s)").tag(30)
                    Text("Fast (10s)").tag(10)
                    #if DEBUG
                    Text("Ultra (3s)").tag(3)
                    #endif
                }
            }

            LazyVGrid(columns: gridItems) {
                ForEach(album.photos, id: \.self) { photo in
                    Menu {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            album.photos.removeAll { element in
                                element == photo
                            }

                            try? modelContext.save()
                        }
                    } label: {
                        DocumentsImageView(url: photo.thumbnailURL)
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle($album.name)
            .toolbar {
                PhotosPicker(selection: $selectedItems, matching: .images) {
                    Label("Select images", systemImage: "photo.badge.plus")
                }

                if album.photos.isEmpty == false {
                    Button("Start slideshow", systemImage: "play") {
                        slideshowAlbum = album
                    }
                    .symbolVariant(.fill)
                }
            }
            .fullScreenCover(item: $slideshowAlbum, content: SlideshowViewer.init)
            .onChange(of: selectedItems) {
                Task {
                    for item in selectedItems {
                        guard let imageData = try? await item.loadTransferable(type: Data.self) else { continue }

                        guard let uiImage = UIImage(data: imageData) else { continue }
                        guard let imageThumbnailData = uiImage.createThumbnail(at: CGSize(width: 100, height: 100)) else { continue }

                        let imageID = UUID().uuidString

                        do {
                            try imageData.write(to: imageID.documentsURL)
                            try imageThumbnailData.write(to: imageID.thumbnailURL)
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

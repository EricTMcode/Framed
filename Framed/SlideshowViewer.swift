//
//  SlideshowViewer.swift
//  Framed
//
//  Created by Eric on 07/01/2025.
//

import SwiftUI

struct SlideshowViewer: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentImageIndex = 0
    var album: Album

    var body: some View {
        Button {
            dismiss()
        } label: {
            DocumentsImageView(url: album.photos[currentImageIndex].documentsURL)
        }
        .ignoresSafeArea()
        .persistentSystemOverlays(.hidden)
        .statusBarHidden()
        .background(.black)
        .task {
            changeSlide()
        }
    }

    func changeSlide() {
        Task {
            try await Task.sleep(for: .seconds(album.speed))

            withAnimation(.easeIn(duration: 1)) {
                currentImageIndex = (currentImageIndex + 1) % album.photos.count
            }

            changeSlide()
        }
    }
}

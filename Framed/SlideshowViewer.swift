//
//  SlideshowViewer.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import SwiftUI

struct SlideshowViewer: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentImageIndex = 0
    @State private var isZoomed = false
    var album: Album


    var body: some View {
        Button {
            dismiss()
        } label: {
            DocumentsImageView(url: album.photos[currentImageIndex].documentURL)
        }
        .scaleEffect(isZoomed ? 1.25 : 1)
        .ignoresSafeArea()
        .persistentSystemOverlays(.hidden)
        .statusBarHidden()
        .background(.black)
        .task {
            changeSlide()
        }
    }

    func changeSlide() {
        withAnimation(.linear(duration: Double(album.speed))) {
            isZoomed.toggle()
        }

        Task {
            try await Task.sleep(for: .seconds(album.speed))

            withAnimation(.easeInOut(duration: 1)) {
                currentImageIndex = (currentImageIndex + 1) % album.photos.count
            }

            changeSlide()
        }
    }
}

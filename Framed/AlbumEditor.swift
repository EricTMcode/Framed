//
//  AlbumEditor.swift
//  Framed
//
//  Created by Eric on 07/01/2025.
//

import SwiftUI

struct AlbumEditor: View {
    @Bindable var album: Album

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AlbumEditor(album: Album(name: "Preview Album", photos: [], speed: 10))
}

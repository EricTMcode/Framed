//
//  DocumentsImageView.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import SwiftUI

struct DocumentsImageView: View {
    var url: URL

    var body: some View {
        Image(uiImage: UIImage(contentsOfFile: url.path()) ?? .add)
            .resizable()
            .scaledToFill()
    }
}

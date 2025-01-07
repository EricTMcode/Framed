//
//  ContentView.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var albums: [Album]

    var body: some View {
        NavigationStack {
            List {
                ForEach(albums) { album in
                    NavigationLink(value: album) {
                        Text("\(album.name) (\(album.photos.count))")
                    }
                }
            }
            .navigationTitle("Framed")
        }
    }
}

#Preview {
    ContentView()
}

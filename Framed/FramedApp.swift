//
//  FramedApp.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import SwiftUI
import SwiftData

@main
struct FramedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Album.self)
        }
    }
}

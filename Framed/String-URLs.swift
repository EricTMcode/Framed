//
//  String-URLs.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import Foundation

extension String {
    var documentURL: URL {
        URL.documentsDirectory.appending(path: self)
    }
}

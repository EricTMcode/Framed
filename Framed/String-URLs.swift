//
//  String-URLs.swift
//  Framed
//
//  Created by Eric on 07/01/2025.
//

import Foundation

extension String {
    var documentsURL: URL {
        URL.documentsDirectory.appending(path: self)
    }
}

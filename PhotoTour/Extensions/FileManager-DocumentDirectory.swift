//
//  FileManager-DocumentDirectory.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import Foundation

extension FileManager {
    static var path: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

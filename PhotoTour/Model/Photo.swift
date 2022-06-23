//
//  Photo.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import UIKit
import CoreLocation
import Foundation

struct Photo: Identifiable, Comparable, Codable, CustomStringConvertible {
    // Identifiable protocol
    let id: UUID
    
    // photo struct attributes
    let jpegData: Data
    let title: String
    let note: String?
    var latitude: Double?
    var longitude: Double?
    
    var location: CLLocationCoordinate2D? {
        get {
            if latitude != nil && longitude != nil {
                return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            } else {
                return nil
            }
        }
        set {
            if let newLocation = newValue {
                self.latitude = newLocation.latitude
                self.longitude = newLocation.longitude
            } else {
                self.latitude = nil
                self.longitude = nil
            }
        }
    }
    
    init(uiImage: UIImage, title: String, note: String? = nil, location: CLLocationCoordinate2D?) {
        id = UUID()
        jpegData = uiImage.jpegData(compressionQuality: 1) ?? Data()
        self.title = title
        self.note = note
        self.location = location
    }
    
    // Comparable protocol
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.title < rhs.title
    }
    
    // CustomStringConvertible
    var description: String {
        return "ID: \(id.uuidString)\nTitle: \(title)\nNote: \(note ?? "nil")\nLatitude: \(String(describing: latitude ?? nil))\nLongitude: \(String(describing: longitude ?? nil))\n"
    }
    
    
    // Example data
    static let examplePhoto = Photo(uiImage: UIImage(systemName: "photo")!, title: "Test Title", note: nil, location: exampleLocation)
    static let examplePhotoWithNote = Photo(uiImage: UIImage(systemName: "photo")!, title: "Test Title", note: "This is a Test Note!", location: exampleLocation)
    static let examplePhotoWithLongNote = Photo(uiImage: UIImage(systemName: "photo")!, title: "Test Title", note: longNote, location: exampleLocation)
    
    static let longNote = """
        Swift is a general-purpose, multi-paradigm, compiled programming language developed by Apple Inc.
        and the open-source community. First released in 2014, Swift was developed as a replacement
        for Apple's earlier programming language Objective-C, as Objective-C had been largely unchanged
        since the early 1980s and lacked modern language features.
        
        Swift works with Apple's Cocoa and Cocoa Touch frameworks, and a key aspect of Swift's design was
        the ability to interoperate with the huge body of existing Objective-C code developed for Apple
        products over the previous decades. It was built with the open source LLVM compiler framework
        and has been included in Xcode since version 6, released in 2014.
        
        On Apple platforms,[10] it uses the Objective-C runtime library, which allows C, Objective-C, C++
        and Swift code to run within one program.
    """
    
    static let exampleLocation = CLLocationCoordinate2D(latitude: 48.77, longitude: 9.18)
}

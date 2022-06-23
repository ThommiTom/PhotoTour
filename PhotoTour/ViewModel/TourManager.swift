//
//  TourManager.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import CoreLocation
import Foundation
import SwiftUI

class TourManager: ObservableObject {
    @Published var photos: [Photo]
    
    fileprivate let dataPath = FileManager.path.appendingPathComponent("savedData")
    
    init() {
        do {
            let data = try Data(contentsOf: dataPath)
            let decodedPhotos = try JSONDecoder().decode([Photo].self, from: data)
            photos = decodedPhotos.sorted()
            return
        } catch {
            print("[ERROR] Unable to load data from document directory")
        }
        
        photos = []
    }
    
    func save() {
        do {
            let encodedData = try JSONEncoder().encode(photos)
            try encodedData.write(to: dataPath)
        } catch {
            print("[ERROR] Unable to save data to document directory")
        }
    }
    
    func addNewPhoto(newPhoto: Photo) {
        var tempPhotos = photos
        tempPhotos.append(newPhoto)
        
        withAnimation {
            photos = tempPhotos.sorted()
        }
        
        save()
    }
    
    func createAndAddNewPhoto(uiImage: UIImage, title: String, note: String? = nil, location: CLLocationCoordinate2D? = nil) {
        let newPhoto = Photo(uiImage: uiImage, title: title, note: note, location: nil)
        addNewPhoto(newPhoto: newPhoto)
    }
    
    func removeItems(at offset: IndexSet) {
        photos.remove(atOffsets: offset)
        save()
    }
}

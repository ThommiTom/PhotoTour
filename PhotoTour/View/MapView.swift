//
//  MapView.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import MapKit
import SwiftUI

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var mapRegion: MKCoordinateRegion
    
    let photo: Photo
    var photos: [Photo] = []
    
    init(photo: Photo) {
        self.photo = photo
        photos.append(photo)
        _mapRegion = State(wrappedValue: MKCoordinateRegion(center: self.photo.location ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $mapRegion, annotationItems: photos) { photo in
                MapMarker(coordinate: photo.location!)
            }

            Image(uiImage: UIImage(data: photo.jpegData)!)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .padding(.trailing, 25)
                .padding(.bottom, 50)
                .onTapGesture {
                    dismiss()
                }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(photo: Photo.examplePhoto)
    }
}

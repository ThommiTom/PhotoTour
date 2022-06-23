//
//  ContentView.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import SwiftUI

struct PhotoTourListView: View {
    @StateObject private var tourManager = TourManager()
    
    @State private var addPhoto = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(tourManager.photos) { photo in
                        NavigationLink {
                            PhotoDetailView(photo: photo)
                        } label: {
                            PhotoRowItem(photo: photo)
                        }
                    }
                    .onDelete(perform: tourManager.removeItems)
                }
                .listStyle(.plain)
                
                NavigationLink(isActive: $addPhoto) {
                    AddPhotoView(tourManager: tourManager)
                } label: {}
            }
            .navigationTitle("Photo Tour")
            .toolbar {
                Button {
                    addPhoto = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTourListView()
    }
}

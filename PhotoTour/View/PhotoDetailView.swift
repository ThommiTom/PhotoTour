//
//  PhotoDetailView.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    
    @State private var showLocationOnMap = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Image(uiImage: UIImage(data: photo.jpegData)!)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Spacer()
                }
                
                if photo.note != nil {
                    HStack {
                        Text("Note")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    .opacity(0.6)
                    
                    ScrollView {
                        Text(photo.note!)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                    
                }
                
                Spacer()
            }
            
            NavigationLink(isActive: $showLocationOnMap) {
                MapView(photo: photo)
                    .ignoresSafeArea()
            } label: {}

        }
        .navigationTitle(photo.title)
        .toolbar {
            Button {
                showLocationOnMap = true
            } label: {
                Image(systemName: "mappin.and.ellipse")
            }

        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo.examplePhotoWithLongNote)
    }
}

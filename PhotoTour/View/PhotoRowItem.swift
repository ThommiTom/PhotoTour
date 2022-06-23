//
//  PhotoRowItem.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import SwiftUI

struct PhotoRowItem: View {
    let photo: Photo
    
    var body: some View {
        HStack(alignment: .center, spacing: 25) {
            Image(uiImage: UIImage(data: photo.jpegData)!)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(photo.title)
                .font(.headline)
        }
    }
}

struct PhotoRowItem_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowItem(photo: Photo.examplePhoto)
    }
}

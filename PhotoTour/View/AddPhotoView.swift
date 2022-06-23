//
//  AddPhotoView.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import SwiftUI

struct AddPhotoView: View {
    @ObservedObject var tourManager: TourManager
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var onTitle: Bool // this seems not to work!
    
    @State var uiImage: UIImage?
    @State private var image: Image? = nil
    
    @State private var name: String = ""
    @State private var note: String = ""
    
    @State private var presentLibrary = false
    @State private var presentCamera = false
    @State private var presentEditor = false
    
    private let locationFetcher = LocationFetcher()
    
    private var isDisabled: Bool {
        return  name.trimmingCharacters(in: .whitespaces).isEmpty || image == nil
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Button {
                        self.locationFetcher.start()
                        presentLibrary = true
                    } label: {
                        Label("Select photo from library", systemImage: "photo.on.rectangle.angled")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    
                    Text("or")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Button {
                        self.locationFetcher.start()
                        presentCamera = true
                    } label: {
                        Label("Take photo with camera", systemImage: "camera.shutter.button")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .padding()
                .opacity(image == nil ? 0.6 : 0)
                
                image?
                    .resizable()
                    .scaledToFit()
            }
            .padding()
            .frame(height: 250)
            .onTapGesture {
                presentLibrary = true
            }
            
            Divider()
                .padding(.horizontal)
            
            TextField("Add title", text: $name)
                .font(.headline)
                .padding()
                .focused($onTitle)
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                if note.isEmpty {
                    Text("Add note")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                        .onTapGesture {
                            presentEditor = true
                        }
                    
                    Spacer()
                    
                } else {
                    Text(note)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            onTitle = false
                            presentEditor = true
                        }
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Add new memory")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save") {
                let newPhoto: Photo
                
                guard let uiImage = uiImage else { return }
                
                if let currentLocation = self.locationFetcher.lastKnownLocation {
                    newPhoto = Photo(uiImage: uiImage, title: name, note: note.isEmpty ? nil : note, location: currentLocation)
                } else {
                    newPhoto = Photo(uiImage: uiImage, title: name, note: note.isEmpty ? nil : note, location: nil)
                }
                
                print(newPhoto.description)
                
                tourManager.addNewPhoto(newPhoto: newPhoto)
                
                dismiss()
            }
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.5 : 1)
        }
        .sheet(isPresented: $presentLibrary) {
            ImagePicker(image: $uiImage)
        }
        .sheet(isPresented: $presentCamera) {
            PictureTaker(image: $uiImage)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $presentEditor) {
            EditorView(image: image, note: $note)
        }
        .onChange(of: uiImage) { newValue in
            setPicture()
        }
    }
    
    func setPicture() {
        if let uiImage = uiImage {
            image = Image(uiImage: uiImage)
        }
    }
}


struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView(tourManager: TourManager())
    }
}

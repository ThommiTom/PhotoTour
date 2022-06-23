//
//  EditorView.swift
//  PhotoTour
//
//  Created by Thomas Schatton on 03.06.22.
//

import SwiftUI

struct EditorView: View {
    @Environment(\.dismiss) var dismiss
    
    let image: Image?
    @Binding var note: String
    
    @FocusState private var editorActive: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top)
                
                TextEditor(text: $note)
                    .focused($editorActive)
                    .padding()
            }
            .navigationTitle("Add note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button {
                        self.editorActive = false
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
                }
            }
            .toolbar {
                Button("Done") {
                    self.editorActive = false
                    dismiss()
                }
            }
        }
        .onAppear {
            //Delayed execution of 0.7s
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7){
                editorActive = true
            }
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(image: Image(uiImage: UIImage(data: Photo.examplePhoto.jpegData)!), note: Binding<String>.constant(Photo.longNote))
    }
}

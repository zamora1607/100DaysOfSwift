//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ania on 13/11/2020.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var publiced = Date()
    
    let gengres = ["Fantasy", "Horror","Kids", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(gengres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    DatePicker(selection: $publiced, in: ...Date(), displayedComponents: .date) {
                        Text("Published")
                    }
                    
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.publiced = self.publiced
                        newBook.genre = !self.genre.isEmpty ? self.genre : self.gengres[1]
                        newBook.review = self.review
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

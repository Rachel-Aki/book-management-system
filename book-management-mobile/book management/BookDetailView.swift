//
//  BookDetailView.swift
//  book management
//
//  Created by Yuxin Wang on 4/23/24.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book?
    @Binding var isCreate: Bool

    @EnvironmentObject var viewModel: BookViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var isEdit = false

    @State private var editedTitle: String = ""
    @State private var editedAuthor: String = ""
    @State private var editedPublicationYear: Int = 0
    @State private var editedIsbn: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            if let book = book, !isEdit && !isCreate{
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Title:").font(.headline)
                        Spacer()
                        Text(book.title).font(.title)
                    }
                    HStack {
                        Text("Author:").font(.headline)
                        Spacer()
                        Text(book.author).font(.headline)
                    }
                    HStack {
                        Text("Publication Year:").font(.headline)
                        Spacer()
                        Text("\(book.publicationYear)").font(.headline)
                    }
                    HStack {
                        Text("ISBN:").font(.headline)
                        Spacer()
                        Text(book.isbn).font(.headline)
                    }
                    HStack {
                        Spacer()
                        Button("Edit") {
                            self.isEdit = true
                            self.editedTitle = self.book?.title ?? ""
                            self.editedAuthor = self.book?.author ?? ""
                            self.editedPublicationYear = self.book?.publicationYear ?? 0
                            self.editedIsbn = self.book?.isbn ?? ""
                        }
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)

                        Button("Delete") {
                            if let book = self.book {
                                self.viewModel.deleteBook(id: book.id ?? 0)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        .padding()
                        .foregroundColor(.red)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                        Spacer()
                    }
                }
            } else if isEdit || isCreate {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Title:").font(.headline)
                        Spacer()
                        TextField("Title", text: $editedTitle).font(.title)
                    }
                    HStack {
                        Text("Author:").font(.headline)
                        Spacer()
                        TextField("Author", text: $editedAuthor).font(.headline)
                    }
                    HStack {
                        Text("Publication Year:").font(.headline)
                        Spacer()
                        TextField("Publication Year", value: $editedPublicationYear, formatter: NumberFormatter()).font(.headline)
                    }
                    HStack {
                        Text("ISBN:").font(.headline)
                        Spacer()
                        TextField("ISBN", text: $editedIsbn).font(.headline)
                    }
                    HStack {
                        Spacer()

                        if isCreate {
                            Button("Create") {
                                self.isCreate = false
                                let newBook = Book(title: self.editedTitle, author: self.editedAuthor, publicationYear: self.editedPublicationYear, isbn: self.editedIsbn)
                                self.viewModel.createBook(newBook)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            .padding()
                            .foregroundColor(.blue)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                        } else if isEdit{
                            Button("Save") {
                                self.isEdit = false
                                if let book = self.book {
                                    let updatedBook = Book(id: book.id, title: self.editedTitle, author: self.editedAuthor, publicationYear: self.editedPublicationYear, isbn: self.editedIsbn)
                                    self.viewModel.updateBook(updatedBook)
                                    self.book?.title = self.editedTitle
                                    self.book?.author = self.editedAuthor
                                    self.book?.publicationYear = self.editedPublicationYear
                                    self.book?.isbn = self.editedIsbn
                                }
                            }
                            .padding()
                            .foregroundColor(.blue)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                        }

                        Button("Cancel") {
                            self.isEdit = false
                        }
                        .padding()
                        .foregroundColor(.red)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Book Detail")
        .onAppear(){
            print("Book Detail:")
        }
        .padding()
    }
}

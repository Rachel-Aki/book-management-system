//
//  BookListView.swift
//  book management
//
//  Created by Yuxin Wang on 4/23/24.
//
import SwiftUI

struct BookListView: View {
    @StateObject var viewModel = BookViewModel()
    @State private var showingDetail = false
    @State private var isCreate = false
    @State private var selectedBook: Book?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title).font(.headline)
                            Text(book.author).font(.subheadline)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onTapGesture {
                        self.selectedBook = book
                        self.showingDetail = true
                        print("Selected Book: \(book)")
                    }
                }
            }
            .onAppear(){
                viewModel.fetchBooks()
            }
            .navigationTitle("Books")
            .navigationBarItems(trailing: Button(action: {
                self.isCreate = true
                self.showingDetail = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingDetail) { 
                BookDetailView(book: self.$selectedBook, isCreate: self.$isCreate).environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    BookListView()
}


//
//  BookViewModel.swift
//  book management
//
//  Created by Yuxin Wang on 4/23/24.
//

import SwiftUI
import Moya

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let provider = MoyaProvider<BookService>()

    func fetchBooks() {
        provider.request(.getAllBooks) { result in
            switch result {
            case .success(let response):
                do {
                    let books = try JSONDecoder().decode([Book].self, from: response.data)
                    DispatchQueue.main.async {
                        self.books = books
                    }
                } catch {
                    print("Error decoding books: \(error)")
                }
            case .failure(let error):
                print("Error fetching books: \(error)")
            }
        }
    }
    
    func createBook(_ book: Book) {
        provider.request(.createBook(book)) { result in
            switch result {
            case .success:
                print("Book created successfully")
                self.fetchBooks()
            case .failure(let error):
                print("Error creating book: \(error)")
            }
        }
    }

    func updateBook(_ book: Book) {
        provider.request(.updateBook(book)) { result in
            switch result {
            case .success:
                print("Book updated successfully")
                self.fetchBooks()
            case .failure(let error):
                print("Error updating book: \(error)")
            }
        }
    }

    func deleteBook(id: Int) {
        provider.request(.deleteBook(id)) { result in
            switch result {
            case .success:
                print("Book deleted successfully")
                self.fetchBooks()
            case .failure(let error):
                print("Error deleting book: \(error)")
            }
        }
    }
}

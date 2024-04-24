//
//  BookService.swift
//  book management
//
//  Created by Yuxin Wang on 4/23/24.
//

import Foundation
import Moya

struct Book: Codable, Identifiable, Equatable {
    var id: Int?
    var title: String
    var author: String
    var publicationYear: Int
    var isbn: String
}

enum BookService {
    case getAllBooks
    case getBookById(Int)
    case createBook(Book)
    case updateBook(Book)
    case deleteBook(Int)
}

extension BookService: TargetType {
    var baseURL: URL { return URL(string: "http://localhost:8080/api/books")! }
    
    var path: String {
        switch self {
            case .getAllBooks, .createBook:
                return ""
            case .getBookById(let bookId), .deleteBook(let bookId):
                return "/\(bookId)"
            case .updateBook(let book):
                return "/\(book.id)"
            }
        }
    
    var method: Moya.Method {
        switch self {
        case .getAllBooks, .getBookById(_):
            return .get
        case .createBook:
            return .post
        case .updateBook:
            return .put
        case .deleteBook:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getAllBooks, .getBookById:
            return .requestPlain
        case .createBook(let book), .updateBook(let book):
            return .requestJSONEncodable(book)
        case .deleteBook:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

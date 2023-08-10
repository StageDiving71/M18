//
//  Search response.swift
//  
//
//  Created by Владимир Бурлинов on 17.09.2022.
//

import Foundation


    // MARK: - Welcome
//    struct Welcome: Decodable {                 //change codable decodable
//        let searchType: SearchTypeEnum
//        let expression: String
//        let results: [Result1]
//        let errorMessage: String
//    }
//
//    // MARK: - Result
//    struct Result1: Decodable {
//        let id: String
//        let resultType: SearchTypeEnum
//        let image: String
//        let title, resultDescription: String
//
//        enum CodingKeys: String, CodingKey {
//            case id, resultType, image, title
//            case resultDescription = "description"
//        }
//    }
//
//    enum SearchTypeEnum: String, Codable {
//        case title = "Title"
//    }

protocol ModelViewControllerProtocol: AnyObject {
    func reloadTable()
    
}

//struct Welcome: Codable {
//    let search: [Search]
//    let totalResults, response: String
//
//    enum CodingKeys: String, CodingKey {
//        case search = "Search"
//        case totalResults
//        case response = "Response"
//    }
//}
//
//// MARK: - Search
//struct Search: Codable {
//    let title, year, imdbID: String
//    let type: TypeEnum
//    let poster: String
//
//    enum CodingKeys: String, CodingKey {
//        case title = "Title"
//        case year = "Year"
//        case imdbID
//        case type = "Type"
//        case poster = "Poster"
//    }
//}
//
//enum TypeEnum: String, Codable {
//    case game = "game"
//    case movie = "movie"
//    case series = "series"
//}

struct Welcome: Codable {
    let keyword: String
    let pagesCount, searchFilmsCountResult: Int
    let films: [Film]
    
     init(keyword: String,
                 pageCount: Int,
                 searchFilmsCountResult: Int,
                 films: [Film]) {
        self.keyword = keyword
        self.pagesCount = pageCount
        self.searchFilmsCountResult = searchFilmsCountResult
        self.films = films
    }
}

// MARK: - Film
struct Film: Codable {
    let filmID: Int
    let nameRu, nameEn, type, year: String
    let description, filmLength: String
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterURL: String
    let posterURLPreview: String

    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, nameEn, type, year, description, filmLength, countries, genres, rating, ratingVoteCount
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           filmID = try container.decode(Int.self, forKey: .filmID)
           nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu) ?? ""
           nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn) ?? ""
           type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
           year = try container.decodeIfPresent(String.self, forKey: .year) ?? ""
           description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
           filmLength = try container.decodeIfPresent(String.self, forKey: .filmLength) ?? ""
           countries = try container.decode([Country].self, forKey: .countries)
           genres = try container.decode([Genre].self, forKey: .genres)
           rating = try container.decodeIfPresent(String.self, forKey: .rating) ?? ""
           ratingVoteCount = try container.decodeIfPresent(Int.self, forKey: .ratingVoteCount) ?? 0
           posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL) ?? ""
           posterURLPreview = try container.decodeIfPresent(String.self, forKey: .posterURLPreview) ?? ""
       }

}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}


// case filmID = "filmId"
//case nameRu = "nameRu"
//case nameEn = "nameEn"
//case type = "type"
//case year = "year"
//case description = "description"
//case filmLength = "filmLength"
//case countries = "countries"
//case genres = "genres"
//case rating = "rating"
//case ratingVoteCount = "ratingVoteCount"
//case posterURL = "posterUrl"
//case posterURLPreview = "posterUrlPreview"

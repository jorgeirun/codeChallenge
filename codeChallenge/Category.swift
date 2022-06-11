//
//  Category.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/10/22.
//

struct Category: Decodable {

    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    
    enum CodingKeys: String, CodingKey {
        case idCategory
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
    }
}

//
//  Ingredient.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

struct Ingredient: Decodable {

    let idIngredient: String
    let strIngredient: String
    
    enum CodingKeys: String, CodingKey {
        case idIngredient
        case strIngredient
    }
}

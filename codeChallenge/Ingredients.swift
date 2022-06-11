//
//  Ingredients.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

struct Ingredients: Decodable {
  let all: [Ingredient]
  
  enum CodingKeys: String, CodingKey {
    case all = "meals"
  }
}

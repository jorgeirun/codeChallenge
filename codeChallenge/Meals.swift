//
//  Meals.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

struct Meals: Decodable {
  let all: [Meal]
  
  enum CodingKeys: String, CodingKey {
    case all = "meals"
  }
}

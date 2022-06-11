//
//  Categories.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/10/22.
//

struct Categories: Decodable {
  let all: [Category]
  
  enum CodingKeys: String, CodingKey {
    case all = "categories"
  }
}

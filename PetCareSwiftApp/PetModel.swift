//
//  PetModel.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 20.12.2022.
//

import Foundation

struct Pet: Identifiable, Codable{
    let id : Int
    let name : String
    let date_of_birth : String
    let is_adopted : Bool
    let age : Int
}


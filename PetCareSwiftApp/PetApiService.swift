//
//  PetApiService.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 20.12.2022.
//

import Foundation

enum APIError : Error{
    case invalidUrl, requestError, decodingError, statusNotOk
}

let get_pets_url = K.URL.get_pets
let get_pet_url = K.URL.get_pet

struct APIService {
    
    let defaults = UserDefaults.standard
    
    
    func getPets () async throws -> [Pet]{
        
        //send notifications if fetch api is ok
        
        
        
        let jwtToken = defaults.string(forKey : DefaultsKeys.keyOne)
        
        
        
        guard let url = URL(string : get_pets_url) else{
            print("invalidURL")
            throw APIError.invalidUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            print("request error")
            throw APIError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            print("status not ok")
            throw APIError.statusNotOk
        }
        
        print(data)
        
        guard let result = try? JSONDecoder().decode([Pet].self, from : data) else{
            print("decoding error")
            throw APIError.decodingError
        }
        
        
        
        
        return result
    }
    
    
}

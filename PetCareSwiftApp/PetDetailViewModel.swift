//
//  PetDetailViewModel.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 20.12.2022.
//

import Foundation


func getPet (pet_id : Int) async throws -> Pet{
    
    let defaults = UserDefaults.standard
    
    let jwtToken = defaults.string(forKey : DefaultsKeys.keyOne)
    
    
    
    guard let url = URL(string : get_pet_url + String(pet_id)) else{
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
    
    guard let result = try? JSONDecoder().decode(Pet.self, from : data) else{
        print("decoding error")
        throw APIError.decodingError
    }
    
    return result
}

@MainActor
class PetDetailViewModel: ObservableObject{
    
    @Published var pet : Pet? = nil
    @Published var errorMessage : String = ""
    @Published var hasError : Bool = false
    
    func getPets(pet_id : Int) async {
        
        guard let data = try? await getPet(pet_id: pet_id) else{
            self.pet = nil
            self.hasError = true
            self.errorMessage = "Server Error"
            return
        }
        self.pet = data
    }
    
}

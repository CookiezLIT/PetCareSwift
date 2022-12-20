//
//  PetViewModel.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 20.12.2022.
//

import Foundation

@MainActor
class PetViewModel: ObservableObject{
    
    @Published var pets : [Pet] = []
    @Published var errorMessage : String = ""
    @Published var hasError : Bool = false
    
    func getPets() async {
        
        guard let data = try? await APIService().getPets() else{
            self.pets = []
            self.hasError = true
            self.errorMessage = "Server Error"
            return
        }
        self.pets = data
    }
    
}

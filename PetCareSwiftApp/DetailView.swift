//
//  DetailView.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 21.12.2022.
//

import SwiftUI

struct DetailView: View {
    
    var pet_id : Int
    
    @StateObject var pet_vm = PetDetailViewModel()
    
    var body: some View {
        
        VStack{
            
            if pet_vm.pet != nil{
                
                let searched_pet = pet_vm.pet
                
                Text("Name:\(searched_pet?.name ?? "None")")
                    .padding()
                    
                Text("Age:\(String(searched_pet?.age ?? 0))")
                    .padding()
                Text("Birth date:\(searched_pet?.date_of_birth ?? "None")")
                    .padding()
                
                
            }
            
        }
        .task{
            await pet_vm.getPets(pet_id : pet_id)
        }
    }
}


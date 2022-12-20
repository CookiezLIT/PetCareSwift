//
//  AllPetsView.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 20.12.2022.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var vm = PetViewModel()
    
    var body: some View {
        Text("HALLOOO")
        List {
            ForEach(vm.pets) {
                pet in HStack{
                    Text("\(pet.name)")
                }
            }
        }
        .task{
            await vm.getPets()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

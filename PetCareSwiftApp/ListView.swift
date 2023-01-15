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
        //NavigationView {
            Text("Pets")
        NavigationView{
            List {
                ForEach(vm.pets) {
                    pet in HStack{
                        NavigationLink(destination: PetDetailContentView(pet_id : pet.id) ){
                            Text("\(pet.name)")
                        }
                    }
                }
            }
            .task{
                await vm.getPets()
            }
        }
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

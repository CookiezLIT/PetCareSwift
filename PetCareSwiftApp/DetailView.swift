//
//  DetailView.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 21.12.2022.
//

import SwiftUI


struct PetDetailContentView : View {
    
    @State var editPet = false
    
    var pet_id : Int
    var body: some View{
        
        return Group{
            if editPet{
                EditPetView(pet_id : pet_id)
            }
            else{
                DetailView(pet_id: pet_id, editPet: $editPet)
            }
        }
        
    }
}


struct DetailView: View {
    
    var pet_id : Int
    
    @StateObject var pet_vm = PetDetailViewModel()
    
    @Binding var editPet : Bool
    
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
                
                Button(action:{
                    self.editPet = true
                }){
                    Text("Edit Pet")
                }
            }
            
        }
        .task{
            await pet_vm.getPets(pet_id : pet_id)
        }
    }
}


enum IsAdopted : String, CaseIterable, Identifiable{
    case True, False
    var id: Self{self}
}


func post_pet(pet_id : Int, name : String, age_string : String) -> Bool{
    
    let defaults = UserDefaults.standard

    let url = URL(string :K.URL.put_pet + String(pet_id))!
    
    var request = URLRequest(url : url)
    
    let jwtToken = defaults.string(forKey : DefaultsKeys.keyOne)
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: ["id" : pet_id, "name" : name, "date_of_birth" : "2022-05-15", "is_adopted" : "True", "age" : age_string])
    }catch let error{
        print(error.localizedDescription)
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    request.httpMethod = "PUT"
    var response_code = 0
    print("Sending post_pet request")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in

        if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            response_code = httpResponse.statusCode

            }
    }

    task.resume()

    sleep(1)
    
    print("Response status code for post_pet request:")
    print(response_code)
    
    if (response_code == 200){
        return true
    }
    else{
        return false
    }
    
}

struct EditPetView : View{
    var pet_id : Int
    @State var name : String = ""
    @State var is_adopted : IsAdopted = .True
    @State var age_string : String = ""
    @State var data_fetched : Bool = false
    var body: some View{
        VStack{
            
            
            //name
            Text("New pet name:").padding()
            TextField("New pet name:", text:$name).padding()
            
            
            //age
            Text("New pet age:").padding()
            TextField("Age", text:$age_string).padding()
            
            //is_adopted
            Text("Is pet adopted:").padding()
            Picker(selection: $is_adopted, label: Text("Avocado:")) {
                Text("True").tag(IsAdopted.True)
                Text("False").tag(IsAdopted.False)
            }.pickerStyle(.segmented).padding()
            
            //button with action to do post request
            Button(action: {
                
                data_fetched = post_pet(pet_id: pet_id, name: name, age_string: age_string)
                if (data_fetched){
                    NotificationManager.instance.sendNotification(title: "Pet added to the server", message: "Pet data send to the server")
                    
                }
                else{
                    NotificationManager.instance.sendNotification(title: "Pet saved locally", message: "Pet data could not be sent to the server")
                }
                        
                
                
                
                
            }){
                Text("Update Pet")
            }
        }
    }
    
}

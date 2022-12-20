//
//  ContentView.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 20.12.2022.
//

import SwiftUI

func login(username : String, password : String) -> Bool
{
    
    //set the login data
    let loginString = String(format: "%@:%@", username, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    
    
    
    let url = URL(string :K.URL.login_url)!
    
    var request = URLRequest(url : url)
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: ["username" : username, "password" : password])
    }catch let error{
        print(error.localizedDescription)
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.httpMethod = "POST"
    var response_code = 0
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in

        if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            response_code = httpResponse.statusCode
            }
        
    }
    
    task.resume()
    
    sleep(1)
    
    print("Response status code:")
    print(response_code)
    
    if response_code == 404 || response_code == 400 {
        return false
    }
    if response_code == 200{
        return true
    }
    
    
    return true
}


struct ContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Enter a username", text: $username)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(80.0)
                    .padding(.bottom, 20)
                    .autocapitalization(.none)
                SecureField("Enter a password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(80.0)
                    .padding(.bottom,20)
                    .autocapitalization(.none)
                Button(action : {login(username: username, password: password)}){
                    Text("Sign In")
                }
            }
            .navigationTitle("Login")
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

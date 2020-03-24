//
//  Login.swift
//  CupcaKE Corner
//
//  Created by jitu Nayak on 3/24/20.
//  Copyright © 2020 jitu Nayak. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State var username = ""
        @State var password = ""
        
        var DisabledForm: Bool
        {
            username.isEmpty || password.count<5 && username.count<5
        }
        var body: some View {

            NavigationView{
            Form{
                Section{
                    TextField("Username", text: $username)
                    TextField("Password", text: $password)
                }
                Section{
                   
                    NavigationLink(destination: ContentView())
                    {
                        Button("Create account")
                            {
                                print("Account created")
                        }
                    }
                    
                    
                }.disabled(DisabledForm)
            }
            
            .navigationBarTitle(Text("Cupcake Corner"))
        }
        }
    }

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

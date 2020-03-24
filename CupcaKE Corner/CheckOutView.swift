//
//  CheckOutView.swift
//  CupcaKE Corner
//
//  Created by jitu Nayak on 3/24/20.
//  Copyright © 2020 jitu Nayak. All rights reserved.
//

import SwiftUI

struct CheckOutView: View {
    
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader{
            geo in ScrollView{
                VStack{
                    Image("cupcake")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total bill is $\(self.order.cost, specifier:"%.2f")")
                        .font(.title)
                    
                    Button("Please order"){
                        self.placeOrder()
                }.padding()
                    
                }
        }
        }.navigationBarTitle("Check out page", displayMode: .inline)
        .alert(isPresented: $showingConfirmation)
        {
            Alert(title: Text("Thank you"),message:
            Text(confirmationMessage), dismissButton:
                .default(Text("OK"))
            )
        }
    }
    
    func placeOrder()
    {
        guard let encoded = try? JSONEncoder().encode(order)
            else{
                print("Failed to encode order")
                return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody =  encoded
        
        URLSession.shared.dataTask(with: request){data,
            response, error in
            guard let data = data else{
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                
                return
            }
            if let decodedOrder = try?
                JSONDecoder().decode(Order.self, from: data)
            {
                self.confirmationMessage="Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way! "
                self.showingConfirmation = true
            }
            else
            {
                print("Invalid resposne")
            }
        }.resume()
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}

//
//  AddressView.swift
//  CupcaKE Corner
//
//  Created by jitu Nayak on 3/24/20.
//  Copyright © 2020 jitu Nayak. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
    
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.StreetAddress)
                TextField("City" , text: $order.city)
                TextField("ZIP Code", text: $order.zip
                )
            }
            
            
                NavigationLink(destination: CheckOutView(order: order))
                {
                    Text("Check Out")
                        .font(.body)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                }.disabled(order.hasValidAddress == false)
            
        }.navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

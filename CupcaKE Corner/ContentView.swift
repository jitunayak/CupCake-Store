//
//  ContentView.swift
//  CupcaKE Corner
//
//  Created by jitu Nayak on 3/24/20.
//  Copyright © 2020 jitu Nayak. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var order = Order()
    
    var body: some View {
       
            Form{
                Section{
                    Picker("Select", selection: $order.type)
                    {
                        ForEach(0..<Order.types.count, id:\.self)
                        {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 1...20)
                    {
                        Text("Number of cakes : \(order.quantity)")
                    }
                }
                Section{
                    Toggle(isOn:
                        $order.specialRequestEnabled.animation())
                    {
                        Text("Any special request")
                    }
                    if order.specialRequestEnabled{
                        Toggle(isOn: $order.extraFrosting){
                            Text("Add extra Frostaing")
                        }
                        
                        Toggle(isOn: $order.extraSprinkes)
                        {
                            Text("Add extra Sprinkes")
                        }
                       
                    }
                    
                }
                Section{
                    NavigationLink(destination: AddressView(order: order))
                    {
                        Text("Delivery Details")
                    }
                }
            
        }.navigationBarTitle("Cupcake Corner")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

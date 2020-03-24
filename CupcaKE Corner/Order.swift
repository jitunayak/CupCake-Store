//
//  Order.swift
//  CupcaKE Corner
//
//  Created by jitu Nayak on 3/24/20.
//  Copyright © 2020 jitu Nayak. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable{
    
    enum CodingKeys: CodingKey
    {
        case type,quantity,extraFrosting,extraSprinkes,name,
            StreetAddress, city,zip
    }
    static let types = ["Chocolate","Strawberry","Pinaple","Rosemerry"]
    
 
    @Published var type = 0
    @Published var quantity = 3
    @Published var extraFrosting = false
    @Published var extraSprinkes = false
    @Published var name = ""
    @Published var StreetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
   
    var cost: Double{
        var cost = Double(quantity) * 14
        cost += Double(type) / 2
        
        if extraFrosting{
            cost += Double(quantity)
        }
        if extraSprinkes{
            cost += Double(quantity)
        }
        
        return cost
    }
    
    init(){}
    
    required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           type = try container.decode(Int.self, forKey: .type)
           quantity = try container.decode(Int.self, forKey: .quantity)
           extraFrosting =  try container.decode(Bool.self, forKey: .extraFrosting)
           extraSprinkes = try container.decode(Bool.self, forKey: .extraSprinkes)
           name = try container.decode(String.self, forKey: .name)
           StreetAddress = try container.decode(String.self, forKey: .StreetAddress)
           city = try container.decode(String.self, forKey: .city)
           zip = try container.decode(String.self, forKey: .zip)
       }
       
       func encode(to encoder: Encoder) throws{
           var container = encoder.container(keyedBy: CodingKeys.self)
            
           try container.encode(type, forKey: .type)
           try container.encode(quantity, forKey: .quantity)
           try container.encode(extraFrosting, forKey: .extraFrosting)
           try container.encode(extraSprinkes, forKey: .extraSprinkes)
           try container.encode(name, forKey: .name)
           try container.encode(StreetAddress, forKey: .StreetAddress)
           try container.encode(city, forKey: .city)
           try container.encode(zip, forKey: .zip)
            
        }

    
    var hasValidAddress: Bool {
          if name.isEmpty || StreetAddress.isEmpty || city.isEmpty || zip.isEmpty
          {
          return false
          }
          return true
      }
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
               extraFrosting = false
               extraSprinkes = false
            }
        }
    }
    
  
  
}

//
//  Superheros.swift
//  Superheroes_and_Laureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct Superheros: Codable {
    var squadName: String
    var homeTown: String
    var formed: Int
    var secretBase: String
    var active: Bool
    var members: [Members]
}

struct Members: Codable {
    var name: String
    var age: Int
    var secretIdentity: String
    var powers: [String]
}

class Superheroes {
    
    static var shared = Superheroes()
    
    var superMembers: [Members]
    
    init(){
        superMembers = []
    }
    
    let superHeroesurl: String = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    func fetchSuperheroesFromURL(){
        let urlSession = URLSession.shared
        let url = URL(string: superHeroesurl)
        urlSession.dataTask(with: url!, completionHandler: decodeSuperheroes).resume()
    }
    
    func decodeSuperheroes(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        do {
            let decoder = JSONDecoder()
            let superheroesDecoded = try decoder.decode(Superheros.self, from: data!)
            self.superMembers = superheroesDecoded.members
            NotificationCenter.default.post(name: NSNotification.Name("Superheroes data delivered"), object: nil)
        }catch {
            print(error)
        }
    }
}

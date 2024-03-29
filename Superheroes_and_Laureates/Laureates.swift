//
//  Laureates.swift
//  Superheroes_and_Laureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct Laureate {
    var firstname: String?
    var surname: String?
    var born: String?
    var died: String?
}

class Laureates {
    
    var laureatesurl = "https://www.dropbox.com/s/7dhdrygnd4khgj2/laureates.json?dl=1"
    
    static var shared = Laureates()
    
    var laureates: [Laureate]
    
    init(){
        laureates = []
    }
    
    func fetchLaureatesFromURL(){
        let urlSession = URLSession.shared
        let url = URL(string: laureatesurl)
        urlSession.dataTask(with: url!, completionHandler: decodeLaureates).resume()
    }
    
    func decodeLaureates(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var laureates:[[String:Any]]!
        var firstname: String?
        var surname: String?
        var born: String?
        var died: String?
        do {
            try laureates = JSONSerialization.jsonObject(with: data!, options: .allowFragments)  as?  [[String:Any]]
            for i in 0..<laureates!.count {
                firstname = ((laureates![i]["firstname"] as? String))
                surname = ((laureates![i]["surname"] as? String))
                born = (laureates![i]["born"] as? String)
                died = (laureates![i]["died"] as? String)
                self.laureates.append(Laureate(firstname: firstname, surname: surname, born: born, died: died))
            }
            NotificationCenter.default.post(name: NSNotification.Name("Laureates data delivered"), object: nil)
        } catch {
            print(error)
        }
    }
    
}

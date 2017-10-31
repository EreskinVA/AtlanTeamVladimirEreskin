//
//  UsersViewController.swift
//  AtlanTeam_VladimirEreskin
//
//  Created by E.Vladimir A. on 30.10.2017.
//  Copyright © 2017 E.Vladimir A. All rights reserved.
//

import UIKit

// подготавливаем структуру получаемых данных

struct Users: Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}
 
struct Address: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo: Decodable {
    var lat: String
    var lng: String
}

struct Company: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}

class UsersViewController: UIViewController {
    
    @IBOutlet weak var user1: UITextView!
    @IBOutlet weak var user2: UITextView!
    @IBOutlet weak var user3: UITextView!
    @IBOutlet weak var user4: UITextView!
    @IBOutlet weak var user5: UITextView!
    
    var usersArray: [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for userNumber in 1...5 {
            
            // подготавливаем URL
            var urlString = "https://jsonplaceholder.typicode.com"
            
            urlString += "/users/\(userNumber)"
            
            // проверяем URL
            guard let url = URL(string: urlString) else { return }
            
            // получаем данные
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // проверяем есть ли данные и нет ли ошибок
                guard let data = data else { return }
                guard error == nil else { return }
                
                do {
                    let user = try JSONDecoder().decode(Users.self, from: data)
                    DispatchQueue.main.async {
                        
                        // выаодим полученные данные в главном потоке
                        switch user.id {
                        case 1: self.user1.text = "\(user)"
                        case 2: self.user2.text = "\(user)"
                        case 3: self.user3.text = "\(user)"
                        case 4: self.user4.text = "\(user)"
                        case 5: self.user5.text = "\(user)"
                            
                        default:
                            print("")
                        }
                    }
                } catch let error {
                    print(error)
                }
                }.resume()
            
        }

    }

}

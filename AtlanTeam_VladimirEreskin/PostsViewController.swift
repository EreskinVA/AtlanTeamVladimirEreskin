//
//  PostsViewController.swift
//  AtlanTeam_VladimirEreskin
//
//  Created by E.Vladimir A. on 30.10.2017.
//  Copyright © 2017 E.Vladimir A. All rights reserved.
//

import UIKit

// подготавливаем структуру получаемых данных
struct Posts: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class PostsViewController: UIViewController {
    
    @IBOutlet weak var postsUserId: UILabel!
    @IBOutlet weak var postsId: UILabel!
    @IBOutlet weak var postsTitle: UILabel!
    @IBOutlet weak var postsBody: UILabel!
    
    var postsNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // подготавливаем URL
        var urlString = "https://jsonplaceholder.typicode.com"
        
        urlString += "/posts/\(postsNumber)"
        
        // проверяем URL
        guard let url = URL(string: urlString) else { return }

        // получаем данные
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // проверяем есть ли данные и нет ли ошибок
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let posts = try JSONDecoder().decode(Posts.self, from: data)
                DispatchQueue.main.async {
                    
                    // выаодим полученные данные в главном потоке
                    self.postsUserId.text = "User ID = \(posts.userId)"
                    self.postsId.text = "ID = \(posts.id)"
                    self.postsTitle.text = "Title = \(posts.title)"
                    self.postsBody.text = "BODY = \(posts.body)"
                    
                }
            } catch let error {
                print(error)
            }
            }.resume()
    }
    
}

//
//  CommentsViewController.swift
//  AtlanTeam_VladimirEreskin
//
//  Created by E.Vladimir A. on 30.10.2017.
//  Copyright © 2017 E.Vladimir A. All rights reserved.
//

import UIKit

// подготавливаем структуру получаемых данных
struct Comments: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentsPostId: UILabel!
    @IBOutlet weak var commentsId: UILabel!
    @IBOutlet weak var commentsName: UILabel!
    @IBOutlet weak var commentsEmail: UILabel!
    @IBOutlet weak var commentsBody: UILabel!
    
    var commentsNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // подготавливаем URL
        var urlString = "https://jsonplaceholder.typicode.com"
        
        urlString += "/comments/\(commentsNumber)"
        
        // проверяем URL
        guard let url = URL(string: urlString) else { return }
        
        // получаем данные
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // проверяем есть ли данные и нет ли ошибок
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let comments = try JSONDecoder().decode(Comments.self, from: data)
                DispatchQueue.main.async {
                    
                    // выаодим полученные данные в главном потоке
                    self.commentsPostId.text = "Post Id = \(comments.postId)"
                    self.commentsId.text = "Id = \(comments.id)"
                    self.commentsName.text = "Name = \(comments.name)"
                    self.commentsEmail.text = "E-mail = \(comments.email)"
                    self.commentsBody.text = "Body = \(comments.body)"
                }
            } catch let error {
                print(error)
            }
            }.resume()
    }
    
}

//
//  TodosViewController.swift
//  AtlanTeam_VladimirEreskin
//
//  Created by E.Vladimir A. on 30.10.2017.
//  Copyright © 2017 E.Vladimir A. All rights reserved.
//



import UIKit

// подготавливаем структуру получаемых данных
struct Todos: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

class TodosViewController: UIViewController {
    
    @IBOutlet weak var todosUserId: UILabel!
    @IBOutlet weak var todosId: UILabel!
    @IBOutlet weak var todosTitle: UILabel!
    @IBOutlet weak var todosCompleted: UILabel!
    
    var todosNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // подготавливаем URL
        var urlString = "https://jsonplaceholder.typicode.com"
        
        urlString += "/todos/\(todosNumber)"
        
        // проверяем URL
        guard let url = URL(string: urlString) else { return }
        
        // получаем данные
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // проверяем есть ли данные и нет ли ошибок
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let todos = try JSONDecoder().decode(Todos.self, from: data)
                DispatchQueue.main.async {
                    
                    // выаодим полученные данные в главном потоке
                    self.todosUserId.text = "User ID = \(todos.userId)"
                    self.todosId.text = "ID = \(todos.id)"
                    self.todosTitle.text = "Title = \(todos.title)"
                    self.todosCompleted.text = "BODY = \(todos.completed)"
                }
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
}

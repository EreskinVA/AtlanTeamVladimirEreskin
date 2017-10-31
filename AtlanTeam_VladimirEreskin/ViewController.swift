//
//  ViewController.swift
//  AtlanTeam_VladimirEreskin
//
//  Created by E.Vladimir A. on 30.10.2017.
//  Copyright © 2017 E.Vladimir A. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var postsNumber: UITextField!        // номер получаемого поста
    @IBOutlet weak var commentsNumber: UITextField!     // номер получаемого комментария
    @IBOutlet weak var scrollView: UIScrollView!
    
    var userStringArray: [Users] = []                   // массив для данных USERS
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsNumber.delegate = self
        commentsNumber.delegate = self
        
        
        // создаем Tap жесть для скрытия клавиатуры при нажатии на ScrollView
        let sampleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.sampleTapGestureTapped(recognizer:)))
        self.view.addGestureRecognizer(sampleTapGesture)
        
    }
    
    // скрытие клавиатуры при нажатии на ScrollView
    @objc func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        scrollView.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // переходим на ViewController для отображения данных введенного номера поста
        if segue.identifier == "posts" {
            let dest = segue.destination as! PostsViewController
            
            // проверяем если не введен номер поста для загрузки, то выдаем сообщение
            if postsNumber.text == "" {
                let alertView = UIAlertController(title: "Ошибка", message: "Не введен номер Posts", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK!", style: .default)
                alertView.addAction(okAction)
                self.present(alertView, animated: true)
            } else {
                dest.postsNumber = Int(postsNumber.text!)!
            }
        }
          
        // переходим на ViewController для отображения данных введенного номера комментария
        if segue.identifier == "comments" {
            let dest = segue.destination as! CommentsViewController
            
            // проверяем если не введен номер комментария для загрузки, то выдаем сообщение
            if commentsNumber.text == "" {
                let alertView = UIAlertController(title: "Ошибка", message: "Не введен номер Comments", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK!", style: .default)
                alertView.addAction(okAction)
                self.present(alertView, animated: true)
            } else {
                dest.commentsNumber = Int(commentsNumber.text!)!
            }
        }
        
        // переходим на ViewController для отображения данных 5-ти первых пользователей
        if segue.identifier == "users" {
            let dest = segue.destination as! UsersViewController
            dest.usersArray = userStringArray
        }
        
        // переходим на ViewController для отображения данных случайной задачи
        if segue.identifier == "todos" {
            let dest = segue.destination as! TodosViewController
            let randomNum: UInt32 = arc4random_uniform(200) // генерируем случайный номер
            dest.todosNumber = Int(randomNum)               // передаем случайный номер
        }
    }
    
    // ограничиваем длину вводимой строки в TextField, 3-мя знаками
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        if newText.length > 3 {
            return false
        }
       if newText.length == 0 {

        }

        return true
    
    }
    
    // ограничиваем диапазон вводимого числа для выбора Posts
    @IBAction func editTextField(_ sender: UITextField) {
        
        if self.postsNumber.text?.characters.count == 0 {
            
        } else {
            if self.postsNumber.text?.characters.count == 1 {
                if self.postsNumber.text != "1" {
                    
                }
            } else if (Int(self.postsNumber.text!)! > 100) {
                self.postsNumber.text = "1"
            }
        }
        
    }
    
    // ограничиваем диапазон вводимого числа для выбора Comments
    @IBAction func editTextFieldComments(_ sender: UITextField) {
        
        if self.commentsNumber.text?.characters.count == 0 {
            
        } else if (Int(self.commentsNumber.text!)! < 1) || (Int(self.commentsNumber.text!)! > 500) {
            self.commentsNumber.text = "1"
        }
        
    }
    
    
}


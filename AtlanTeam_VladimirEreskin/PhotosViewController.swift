//
//  PhotosViewController.swift
//  AtlanTeam_VladimirEreskin
//
//  Created by E.Vladimir A. on 30.10.2017.
//  Copyright © 2017 E.Vladimir A. All rights reserved.
//

import UIKit

// подготавливаем структуру получаемых данных
struct Photos: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

class PhotosViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var photosAlbumId: UILabel!
    @IBOutlet weak var photosId: UILabel!
    @IBOutlet weak var photosTitle: UILabel!
    @IBOutlet weak var photosWebView: UIWebView!
    @IBOutlet weak var activityIndicatorLoadImage: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // подготавливаем URL
        var urlString = "https://jsonplaceholder.typicode.com"
        
        urlString += "/photos/\(3)"
        self.photosWebView.delegate = self
        self.activityIndicatorLoadImage.isHidden = true
        
        // проверяем URL
        guard let url = URL(string: urlString) else { return }
        
        // получаем данные
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // проверяем есть ли данные и нет ли ошибок
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let photos = try JSONDecoder().decode(Photos.self, from: data)
                DispatchQueue.main.async {
                    
                    // выаодим полученные данные в главном потоке
                    self.photosAlbumId.text = "Album Id = \(photos.albumId)"
                    self.photosId.text = "Id = \(photos.id)"
                    self.photosTitle.text = "Title = \(photos.title)"
                    
                    let photoURL = URL(string: photos.thumbnailUrl)
                    let photoURLRequest = URLRequest(url: photoURL!)
                    
                    self.photosWebView.loadRequest(photoURLRequest)
                    
                }
                
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
    // запускаем и показываем анимацию показывающую что загружаются данные
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityIndicatorLoadImage.isHidden = false
        self.activityIndicatorLoadImage.startAnimating()
    }
    
    // останавливаем и скрываем анимацию показывающую что загружаются данные
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicatorLoadImage.isHidden = true
        self.activityIndicatorLoadImage.stopAnimating()
    }
    
}

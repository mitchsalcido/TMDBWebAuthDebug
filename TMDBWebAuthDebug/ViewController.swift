//
//  ViewController.swift
//  TMDBWebAuthDebug
//
//  Created by Mitchell Salcido on 6/11/22.
//

import UIKit
//https://github.com/mitchsalcido/TMDBWebAuthDebug.git
class ViewController: UIViewController {
        
    let apikey = "ea5530947a898e99eb0d439c1f0cb9ab"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tmdbWebAuthLoginButtonPressed(_ sender: Any) {
        print("tmdbWebAuthLoginButtonPressed")
        
        getRequestToken()
    }
}

extension ViewController {
    
    func getRequestToken() {
        
        let urlStr = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apikey)"
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            let obj = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            guard let requestToken = obj["request_token"] as? String else {
                return
            }
            print("requestToken: \(requestToken)")
            
            let urlStr = "https://www.themoviedb.org/authenticate/" + requestToken + "?redirect_to=tmdbwebauthdebug:authenticate"
            guard let url = URL(string: urlStr) else {
                return
            }
            print("URL: \(url)")
            
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        task.resume()
    }
}

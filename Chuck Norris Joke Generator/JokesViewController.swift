//
//  ViewController.swift
//  Chuck Norris Joke Generator
//
//  Created by Matthew Harkey on 2/25/19.
//  Copyright © 2019 Matthew Harkey. All rights reserved.
//

import UIKit

class JokesViewController: UITableViewController {

    var jokes = [[String: String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jokes"
        let query = "http://api.icndb.com/jokes/random/"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["status"] == "success" {
                    parse(json: json)
                    return
                }
            }
        }
        loadError()
    }
    
    func parse(json: JSON){
        for result in json["value"].arrayValue {
            let id = result["id"].stringValue
            let joke = result["joke"].stringValue
            let categories = result["categories"].arrayValue
            let source = ["id": id, "joke": joke, "categories": categories] as [String : Any]
            jokes.append(source as! [String : String])
        }
        tableView.reloadData()
    }
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the joke",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
}


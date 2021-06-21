//
//  ViewController.swift
//  QiitaApp
//
//  Created by mi729 on 2021/06/21.
//  
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var articleListTableView: UITableView!
    
    let decoder: JSONDecoder = JSONDecoder()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        getQiitaArticles()
    }

    private func getQiitaArticles() {
        AF.request("https://qiita.com/api/v2/items").responseJSON { response in
            switch response.result {
            case .success:
                do {
                    self.articles = try self.decoder.decode([Article].self, from: response.data!)
                    self.articleListTableView.reloadData()
                } catch {
                    print("failed")
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }

}


//MARK:- UITableViewDelegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}

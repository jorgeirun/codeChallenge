//
//  ViewController.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/10/22.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //URLs
    let categoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    var categories : [Category] = []
    let cellReuseIdentifier = "categoryCell"
    var rowSelected : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // table set up
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        // other
        self.title = "Loading.."
        
        // get categories
        self.getMealCategories()
    }
    
    func getMealCategories() {
        let request = AF.request(categoriesURL)
        request.responseDecodable(of: Categories.self) { (response) in
            guard let items = response.value else { return }
            self.categories = items.all
            self.tableView.reloadData()
            self.title = "Categories"
          }
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoryTableViewCell
        cell.categoryTitle.text = self.categories[indexPath.row].strCategory
        cell.categoryDetails.text = self.categories[indexPath.row].strCategoryDescription
        cell.cagegoryImage.sd_setImage(with: URL(string: self.categories[indexPath.row].strCategoryThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        rowSelected = indexPath.row
        performSegue(withIdentifier: "showMealsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealsSegue" {
            let dc = segue.destination as! MealsViewController
            dc.mealCategory = self.categories[rowSelected!].strCategory
        }
    }

}

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
    @IBOutlet var searchButton: UIBarButtonItem!
    
    //URLs
    let categoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    var categories : [Category] = []
    let cellReuseIdentifier = "categoryCell"
    var rowSelected : Int?
    var isSearching = false
    var searchResults = [Category]()
    
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

    @IBAction func searchButtonPressed(_ sender: Any) {
        //
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.searchResults.count;
         } else {
             return self.categories.count;
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoryTableViewCell
        
        cell.categoryTitle.textColor = .label
        cell.categoryDetails.textColor = .label
        
        if isSearching {
            cell.categoryTitle.text = self.searchResults[indexPath.row].strCategory
            cell.categoryDetails.text = self.searchResults[indexPath.row].strCategoryDescription
            cell.cagegoryImage.sd_setImage(with: URL(string: self.searchResults[indexPath.row].strCategoryThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
        } else {
            cell.categoryTitle.text = self.categories[indexPath.row].strCategory
            cell.categoryDetails.text = self.categories[indexPath.row].strCategoryDescription
            cell.cagegoryImage.sd_setImage(with: URL(string: self.categories[indexPath.row].strCategoryThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
        }
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
            dc.mealsBy = "category"
            if isSearching {
                dc.mealTerm = self.searchResults[rowSelected!].strCategory
            } else {
                dc.mealTerm = self.categories[rowSelected!].strCategory
            }
        }
    }

}

extension ViewController: UISearchBarDelegate {
     
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         searchResults = categories.filter({$0.strCategory.lowercased().prefix(searchText.count) == searchText.lowercased()})
         isSearching = true
         tableView.reloadData()
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         isSearching = false
         searchBar.text = ""
         tableView.reloadData()
     }
 }

//
//  MealsViewController.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

import UIKit
import Alamofire
import SDWebImage

class MealsViewController: UIViewController {
    
    @IBOutlet weak var mealsTableView: UITableView!
    
    // URLs
    var mealsBy = "" // "category" or "ingredient"
    var mealTerm = "" // selected category or ingredient
    let mealsByCategoryURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    let mealsByIngredientURL = "https://www.themealdb.com/api/json/v1/1/filter.php?i="
    var meals : [Meal] = []
    let cellReuseIdentifier = "mealCell"
    var rowSelected : Int?
    var isSearching = false
    var searchResults = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table set up
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        mealsTableView.separatorStyle = .none
        mealsTableView.showsVerticalScrollIndicator = false
        
        // other
        self.title = "Loading.."
        
        // get categories
        self.getMeals()
    }
    
    func getMeals() {
        var selectedURL = ""
        if mealsBy == "category" {
            selectedURL = mealsByCategoryURL
        }else{
            selectedURL = mealsByIngredientURL
        }
        let request = AF.request(selectedURL + self.mealTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        request.responseDecodable(of: Meals.self) { (response) in
            guard let items = response.value else { return }
            self.meals = items.all
            self.mealsTableView.reloadData()
            self.title = "Meals"
          }
    }

}

extension MealsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.searchResults.count;
         } else {
             return self.meals.count;
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MealsTableViewCell
        if isSearching {
            cell.mealsTitle.text = self.searchResults[indexPath.row].strMeal
            cell.mealsImage.sd_setImage(with: URL(string: self.searchResults[indexPath.row].strMealThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
        } else {
            cell.mealsTitle.text = self.meals[indexPath.row].strMeal
            cell.mealsImage.sd_setImage(with: URL(string: self.meals[indexPath.row].strMealThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mealsTableView.deselectRow(at: indexPath, animated: true)
        rowSelected = indexPath.row
        performSegue(withIdentifier: "showMealsDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealsDetailsSegue" {
            let dc = segue.destination as! MealDetailViewController
            if isSearching {
                dc.mealId = self.searchResults[rowSelected!].idMeal
            } else {
                dc.mealId = self.meals[rowSelected!].idMeal
            }
        }
    }
}

extension MealsViewController: UISearchBarDelegate {
     
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         searchResults = meals.filter({$0.strMeal.lowercased().prefix(searchText.count) == searchText.lowercased()})
         isSearching = true
         mealsTableView.reloadData()
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         isSearching = false
         searchBar.text = ""
         mealsTableView.reloadData()
     }
 }

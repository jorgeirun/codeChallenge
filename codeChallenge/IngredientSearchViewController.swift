//
//  IngredientSearchViewController.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

import UIKit
import Alamofire

class IngredientSearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let ingredientsListURL = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
    var ingredients: [Ingredient] = []
    let cellReuseIdentifier = "ingredientsCell"
    var rowSelected : Int?
    var isSearching = false
    var searchResults = [Ingredient]()
    
    override func viewDidLoad() {
        self.getIngredients()
    }
    
    func getIngredients() {
        let request = AF.request(ingredientsListURL)
        request.responseDecodable(of: Ingredients.self) { (response) in
            print(response)
            guard let items = response.value else { return }
            self.ingredients = items.all
            self.tableView.reloadData()
          }
    }

}

extension IngredientSearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.searchResults.count;
         } else {
             return self.ingredients.count;
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! IngredientTableViewCell

        cell.ingredientTitle.textColor = .label

        if isSearching {
            cell.ingredientTitle.text = self.searchResults[indexPath.row].strIngredient
        } else {
            cell.ingredientTitle.text = self.ingredients[indexPath.row].strIngredient
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        rowSelected = indexPath.row
        performSegue(withIdentifier: "showMealsbyIngredientSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealsbyIngredientSegue" {
            let dc = segue.destination as! MealsViewController
            dc.mealsBy = "ingredient"
            if isSearching {
                dc.mealTerm = self.searchResults[rowSelected!].strIngredient
            } else {
                dc.mealTerm = self.ingredients[rowSelected!].strIngredient
            }
        }
    }

}

extension IngredientSearchViewController: UISearchBarDelegate {
     
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         searchResults = ingredients.filter({$0.strIngredient.lowercased().prefix(searchText.count) == searchText.lowercased()})
         isSearching = true
         tableView.reloadData()
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         isSearching = false
         searchBar.text = ""
         tableView.reloadData()
     }
 }

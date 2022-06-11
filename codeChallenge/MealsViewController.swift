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
    var mealCategory = ""
    let mealsURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    var meals : [Meal] = []
    let cellReuseIdentifier = "mealCell"
    var rowSelected : Int?

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
        self.getMealsForCategory()
    }
    
    func getMealsForCategory() {
        let request = AF.request(mealsURL + self.mealCategory)
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
        return self.meals.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MealsTableViewCell
        cell.mealsTitle.text = self.meals[indexPath.row].strMeal
        cell.mealsImage.sd_setImage(with: URL(string: self.meals[indexPath.row].strMealThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
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
            dc.mealId = self.meals[rowSelected!].idMeal
        }
    }
}

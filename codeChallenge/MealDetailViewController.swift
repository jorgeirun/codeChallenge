//
//  MealDetailViewController.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

import UIKit
import Alamofire
import SDWebImage
import youtube_ios_player_helper

class MealDetailViewController: UIViewController, YTPlayerViewDelegate {

    var mealId = ""
    let mealURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var instructions: String?
    var ingredients: String?
    
    @IBOutlet var playerview: YTPlayerView!
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealCategory: UILabel!
    @IBOutlet weak var mealArea: UILabel!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var mealTags: UILabel!
    
    @IBOutlet weak var mealInstructionsButton: UIButton!
    @IBOutlet weak var mealIngredientsButton: UIButton!
    
    override func viewDidLoad() {
        
        // other
        self.title = "Loading.."
        
        // get meal details
        self.getMealsById()
    }

    func getMealsById() {
        let request = AF.request(mealURL + self.mealId)
        request.responseDecodable(of: Meals.self) { (response) in
            guard let item = response.value else { return }
            self.updateDetails(meals: item.all)
          }
    }
    
    func updateDetails(meals: [Meal]) {
        let meal = meals[0]
        self.title = meal.strMeal
        
        self.mealImage.sd_setImage(with: URL(string: meal.strMealThumb), placeholderImage: UIImage(named: "pleaceholder.jpeg"))
        
        self.mealCategory.text = "Category: \(meal.strCategory ?? "")"
        self.mealArea.text = "Area: \(meal.strArea ?? "")"
        self.mealTitle.text = "Name: \(meal.strMeal)"
        self.mealTags.text = "Tags: \(meal.strTags ?? "")"
        
        self.instructions = meal.strInstructions

        // this is needed due to bad API design
        self.ingredients = "Ingredients: \n\n"
        if (meal.strIngredient1?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient1 ?? "") - \(meal.strMeasure1 ?? "")\n" }
        if (meal.strIngredient2?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient2 ?? "") - \(meal.strMeasure2 ?? "")\n" }
        if (meal.strIngredient3?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient3 ?? "") - \(meal.strMeasure3 ?? "")\n" }
        if (meal.strIngredient4?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient4 ?? "") - \(meal.strMeasure4 ?? "")\n" }
        if (meal.strIngredient5?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient5 ?? "") - \(meal.strMeasure5 ?? "")\n" }
        if (meal.strIngredient6?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient6 ?? "") - \(meal.strMeasure6 ?? "")\n" }
        if (meal.strIngredient7?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient7 ?? "") - \(meal.strMeasure7 ?? "")\n" }
        if (meal.strIngredient8?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient8 ?? "") - \(meal.strMeasure8 ?? "")\n" }
        if (meal.strIngredient9?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient9 ?? "") - \(meal.strMeasure9 ?? "")\n" }
        if (meal.strIngredient10?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient10 ?? "") - \(meal.strMeasure10 ?? "")\n" }
        if (meal.strIngredient11?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient11 ?? "") - \(meal.strMeasure11 ?? "")\n" }
        if (meal.strIngredient12?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient12 ?? "") - \(meal.strMeasure12 ?? "")\n" }
        if (meal.strIngredient13?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient13 ?? "") - \(meal.strMeasure13 ?? "")\n" }
        if (meal.strIngredient14?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient14 ?? "") - \(meal.strMeasure14 ?? "")\n" }
        if (meal.strIngredient15?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient15 ?? "") - \(meal.strMeasure15 ?? "")\n" }
        if (meal.strIngredient16?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient16 ?? "") - \(meal.strMeasure16 ?? "")\n" }
        if (meal.strIngredient17?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient17 ?? "") - \(meal.strMeasure17 ?? "")\n" }
        if (meal.strIngredient18?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient18 ?? "") - \(meal.strMeasure18 ?? "")\n" }
        if (meal.strIngredient19?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient19 ?? "") - \(meal.strMeasure19 ?? "")\n" }
        if (meal.strIngredient20?.isEmpty == false) { self.ingredients = self.ingredients! + "\(meal.strIngredient20 ?? "") - \(meal.strMeasure20 ?? "")\n" }
        
        // laod youtube video if any
        if (meal.strYoutube?.isEmpty == false) {
            let videoId = (meal.strYoutube?.deletingPrefix("https://www.youtube.com/watch?v="))! as String
            playerview.delegate = self
            playerview.load(withVideoId: videoId, playerVars: ["playsinline" : 1])
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    @IBAction func instructionsButtonPressed(_ sender: Any) {
        
        let viewControllerToPresent = InstructionsSheetViewcontroller()
        viewControllerToPresent.instructions = self.instructions

        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @IBAction func ingredientsButtonPressed(_ sender: Any) {
        let viewControllerToPresent = IngredientsSheetViewController()
        viewControllerToPresent.ingredients = self.ingredients

        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

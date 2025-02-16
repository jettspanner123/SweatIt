//
//  DietViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 29/01/25.
//

import UIKit
import SwiftUI

class DietViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let sView = UIScrollView()
        //        sView.backgroundColor = .red
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    var contentView: UIView = {
        let cView = UIView()
        //        cView.backgroundColor = .yellow
        return cView
    }()
    
    
    var horizontalScrollView: UIScrollView = {
        let sView = UIScrollView()
        //        sView.backgroundColor = .red
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    var horizontalContentView: UIView = {
        let cView = UIView()
        //        cView.backgroundColor = .yellow
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.addLinearGradient(colorOne: UIColor(named: "DarkBG") ?? .black, colorTwo: .black, from: CGPoint(x: 0.5, y: 0), to: CGPoint(x: 0.5, y: 1.6))
        let pageHeading = self.addPageHeading()
        let navigationBar = self.addNavigationBar(whichPage: "Coach")
        
        self.setupScrollView()
        
        self.addPageElements()
        
        self.view.bringSubviewToFront(pageHeading)
        self.view.bringSubviewToFront(navigationBar)
    }
    
    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 2.5),
        ])
    }
    
    private func addPageElements() {
        let barcodeScannerButton = UIHostingController(rootView: PrimaryButton(title: "Barcode", icon: "Barcode", colors: [.appRedLight, .appRedDark]){
            
        })
        let addFoodButton = UIHostingController(rootView: PrimaryButton(title: "Add Food", icon: "Plus", colors: [.appThanosLight, .appThanosDark]){
            
        })
        let nutritionHeading = UIHostingController(rootView: TertiaryHeading(titleHeading: "Nutrition", wantSecondaryHeading: true, secondaryHeading: "per gram body wght", bottomSpace: false))
        let homePageCalories = UIHostingController(rootView: HomePageCalories(caloriesConsumed: 1900, caloriesBurned: 125, totalCalories: 2500))
        let macrosCard = UIHostingController(rootView: MacrosCard())
        let caloriesIntakeHeading = UIHostingController(rootView: TertiaryHeading(titleHeading: "Calories Intake", wantSecondaryHeading: true, secondaryHeading: "as per today", bottomSpace: false))
        let raitingFoodCardOne = UIHostingController(rootView: RatingFoodCard(isTop: true, name: "Basmati Rice", title: "Carbs: 28g,Protein: 0, Fats: 5g", cal: 130))
        let raitingFoodCardTwo = UIHostingController(rootView: RatingFoodCard(isTop: false, name: "Chicken Masala", title: "Carbs: 0,Protein: 21g, Fats: 5g", cal: 200, image: "chickenDish"))
        let raitingFoodCardThree = UIHostingController(rootView: RatingFoodCard(isTop: false, name: "Brocolly Salad", title: "Carbs: 8g,Protein: 0, Fats: 15g", cal: 180, image: "me"))
        let raitingFoodCardFour = UIHostingController(rootView: RatingFoodCard(isTop: false, isBottom: true,name: "Basmati Rice", title: "Carbs: 28g,Protein: 0, Fats: 5g", cal: 130))
        let recommendationsHeading = UIHostingController(rootView: TertiaryHeading(titleHeading: "Recomendations", wantSecondaryHeading: false, secondaryHeading: "", bottomSpace: false))
        
        self.contentView.addSubview(self.horizontalScrollView)
        self.horizontalScrollView.addSubview(self.horizontalContentView)
        
        [barcodeScannerButton.view, addFoodButton.view, nutritionHeading.view, homePageCalories.view, macrosCard.view, caloriesIntakeHeading.view, raitingFoodCardOne.view, raitingFoodCardTwo.view, raitingFoodCardThree.view, raitingFoodCardFour.view, recommendationsHeading.view].forEach {
            $0.frame = CGRect(origin: .zero, size: $0.sizeThatFits(self.contentView.bounds.size))
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            barcodeScannerButton.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            barcodeScannerButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            addFoodButton.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            addFoodButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            nutritionHeading.view.topAnchor.constraint(equalTo: barcodeScannerButton.view.bottomAnchor),
            nutritionHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 3),
            nutritionHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            homePageCalories.view.topAnchor.constraint(equalTo: nutritionHeading.view.bottomAnchor, constant: 20),
            homePageCalories.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            homePageCalories.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            macrosCard.view.topAnchor.constraint(equalTo: homePageCalories.view.bottomAnchor, constant: 20),
            macrosCard.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            macrosCard.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            caloriesIntakeHeading.view.topAnchor.constraint(equalTo: macrosCard.view.bottomAnchor),
            caloriesIntakeHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            caloriesIntakeHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            raitingFoodCardOne.view.topAnchor.constraint(equalTo: caloriesIntakeHeading.view.bottomAnchor, constant: 20),
            raitingFoodCardOne.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            raitingFoodCardOne.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            raitingFoodCardTwo.view.topAnchor.constraint(equalTo: raitingFoodCardOne.view.bottomAnchor),
            raitingFoodCardTwo.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            raitingFoodCardTwo.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            raitingFoodCardThree.view.topAnchor.constraint(equalTo: raitingFoodCardTwo.view.bottomAnchor),
            raitingFoodCardThree.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            raitingFoodCardThree.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            raitingFoodCardFour.view.topAnchor.constraint(equalTo: raitingFoodCardThree.view.bottomAnchor),
            raitingFoodCardFour.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            raitingFoodCardFour.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            recommendationsHeading.view.topAnchor.constraint(equalTo: raitingFoodCardFour.view.bottomAnchor),
            recommendationsHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            recommendationsHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.horizontalScrollView.topAnchor.constraint(equalTo: recommendationsHeading.view.bottomAnchor, constant: 20),
            self.horizontalScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.horizontalScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.horizontalScrollView.heightAnchor.constraint(equalToConstant: 280),
            
            self.horizontalContentView.topAnchor.constraint(equalTo: self.horizontalScrollView.topAnchor),
            self.horizontalContentView.leadingAnchor.constraint(equalTo: self.horizontalScrollView.leadingAnchor),
            self.horizontalContentView.trailingAnchor.constraint(equalTo: self.horizontalScrollView.trailingAnchor),
            self.horizontalContentView.bottomAnchor.constraint(equalTo: self.horizontalScrollView.bottomAnchor),
            self.horizontalContentView.heightAnchor.constraint(equalTo: self.horizontalScrollView.heightAnchor),
            self.horizontalContentView.widthAnchor.constraint(equalTo: self.horizontalScrollView.widthAnchor, multiplier: 2),
        ])
        
        
        
    }
    
    
    
    private func addNavigationBar(whichPage: String) -> UIView {
        @State var something = 0
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Diet", wantOffset: false, homeScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, workoutScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExercisePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, coachScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CoachPage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
            
        }, dietScreenAction: {
        }, profileScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfilePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }))
        navigationBar.view.frame = CGRect(origin: .zero, size: navigationBar.sizeThatFits(in: self.view.bounds.size))
        navigationBar.view.backgroundColor = .clear
        
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBar.view)
        NSLayoutConstraint.activate([
            navigationBar.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 48),
            navigationBar.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navigationBar.view.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        return navigationBar.view
        
    }
    
    
    private func addPageHeading() -> UIView {
        let pageHeading = UIHostingController(rootView: PageHeader(pageHeaderTitle: "Diet", wantOffset: false))
        pageHeading.view.frame = CGRect(origin: .zero, size: pageHeading.sizeThatFits(in: self.view.bounds.size))
        
        pageHeading.view.backgroundColor = .clear
        
        pageHeading.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageHeading.view)
        
        NSLayoutConstraint.activate([
            pageHeading.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -64),
            pageHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageHeading.view.heightAnchor.constraint(equalToConstant: 200),
            pageHeading.view.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
        ])
        
        return pageHeading.view
        
    }
    
    private func addLinearGradient(colorOne: UIColor, colorTwo: UIColor, from: CGPoint, to: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.startPoint = from
        gradientLayer.endPoint = to
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}


#Preview {
    DietViewController()
}

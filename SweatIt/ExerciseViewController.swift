//
//  ExerciseViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 21/01/25.
//

import UIKit
import SwiftUI

class ExerciseViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLinearGradient(colorOne: UIColor(named: "DarkBG") ?? .black, colorTwo: .black, from: CGPoint(x: 0.5, y: 0), to: CGPoint(x: 0.5, y: 1.6))
        
        let pageHeading = self.addPageHeading(headingTitle: "Workout")
        self.addNavigationBar(whichPage: "Workout")
        
        self.setupScrollView()
        
        
        self.buttonZone()

        self.view.bringSubviewToFront(pageHeading)

        
    }
    
    
    
    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.contentView)
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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1.5),
        ])
    }
    
    private func addLinearGradient(colorOne: UIColor, colorTwo: UIColor, from: CGPoint, to: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.startPoint = from
        gradientLayer.endPoint = to
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addPageHeading(headingTitle: String) -> UIView {
        let pageHeading = UIHostingController(rootView: PageHeader(pageHeaderTitle: headingTitle, wantOffset: false))
        pageHeading.view.frame = CGRect(origin: .zero, size: pageHeading.sizeThatFits(in: self.view.bounds.size))
        pageHeading.view.backgroundColor = .clear
        
        pageHeading.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageHeading.view)
        
        NSLayoutConstraint.activate([
            pageHeading.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -64),
            pageHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageHeading.view.heightAnchor.constraint(equalToConstant: 200),
            pageHeading.view.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
        ])
        
        return pageHeading.view
        
    }
    
    
    private func addNavigationBar(whichPage: String) {
        @State var something = 0
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Workout", wantOffset: false))
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
        
    }
    
    private func buttonZone() {
        
        let workouts: Array<(String, String)> = [("Upper Body", "Easy"), ("Lower Body", "Easy"), ("Arm Builder", "Medium"), ("Core Create", "Hard"), ("Shoulder Boulder", "Hard"), ("Shoulder Boulder II", "Hard")]
        let firstButton = UIHostingController(rootView: PrimaryButton(title: "Challenges", icon: "xbox", colors: [Color("AppRedLight"), Color("AppRedDark")]))
        let secondButton = UIHostingController(rootView: PrimaryButton(title: "Today's Split", icon: "bucket", colors: [Color("AppThanosLight"), Color("AppThanosDark")]))
        let searchButton = UIHostingController(rootView: WorkoutPageSearchBar())
        
        let workoutHeading = UIHostingController(rootView: SecondaryHeading(title: "Workouts"))
        
        firstButton.view.frame = CGRect(origin: .zero, size: firstButton.sizeThatFits(in: self.contentView.bounds.size))
        secondButton.view.frame = CGRect(origin: .zero, size: secondButton.sizeThatFits(in: self.contentView.bounds.size))
        searchButton.view.frame = CGRect(origin: .zero, size: searchButton.sizeThatFits(in: self.contentView.bounds.size))
        workoutHeading.view.frame = CGRect(origin: .zero, size: workoutHeading.sizeThatFits(in: self.contentView.bounds.size))
        
        firstButton.view.backgroundColor = .clear
        secondButton.view.backgroundColor = .clear
        searchButton.view.backgroundColor = .clear
        workoutHeading.view.backgroundColor = .clear
       
        firstButton.view.translatesAutoresizingMaskIntoConstraints = false
        secondButton.view.translatesAutoresizingMaskIntoConstraints = false
        searchButton.view.translatesAutoresizingMaskIntoConstraints = false
        workoutHeading.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(firstButton.view)
        self.contentView.addSubview(secondButton.view)
        self.contentView.addSubview(searchButton.view)
        self.contentView.addSubview(workoutHeading.view)
        
        NSLayoutConstraint.activate([
            searchButton.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 170),
            searchButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            searchButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
           
            firstButton.view.topAnchor.constraint(equalTo: searchButton.view.bottomAnchor, constant: 20),
            firstButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            secondButton.view.topAnchor.constraint(equalTo: searchButton.view.bottomAnchor, constant: 20),
            secondButton.view.trailingAnchor.constraint(equalTo: searchButton.view.trailingAnchor, constant: -20),
            
            workoutHeading.view.topAnchor.constraint(equalTo: firstButton.view.bottomAnchor),
            workoutHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            workoutHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

        ])
        
        
    }
    
}

#Preview {
    ExerciseViewController()
}

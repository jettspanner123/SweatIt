//
//  ExerciseViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 21/01/25.
//

import UIKit
import SwiftUI

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let workouts: Array<(String, String, String, CGFloat)> = [("Upper Body", "Easy", "upperbody", 20), ("Lower Body", "Easy", "lowerbody", 20), ("Arm Builder", "Medium", "arms", 20), ("Core Create", "Hard", "core", 20), ("Delto Blast", "Hard", "shoulderone", 20), ("Delto Blast II", "Hard", "shouldertwo", 20)]
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        return tableView
        
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentView.subviews.forEach{ $0.removeFromSuperview() }
       
        let workoutCard = UIHostingController(rootView: WorkoutCard(image: workouts[indexPath.row].2, name: workouts[indexPath.row].0, difficulty: workouts[indexPath.row].1, wantMargin: indexPath.row == 0 ? false : true, sideOffset: workouts[indexPath.row].3))
        
        workoutCard.view.backgroundColor = .black
        cell.contentView.addSubview(workoutCard.view)
        cell.contentView.backgroundColor = .clear
        
        workoutCard.view.frame = CGRect(origin: .zero, size: workoutCard.sizeThatFits(in: cell.contentView.bounds.size))
        
        workoutCard.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workoutCard.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            workoutCard.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            workoutCard.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            workoutCard.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            
        ])
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
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
        let navigationBar = self.addNavigationBar(whichPage: "Workout")
        
        self.setupScrollView()
        
        
        self.buttonZone()

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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1.9),
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
    
    
    private func addNavigationBar(whichPage: String) -> UIView {
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
        
        return navigationBar.view
        
    }
    
    private func buttonZone() {
        
        let firstButton = UIHostingController(rootView: PrimaryButton(title: "Challenges", icon: "xbox", colors: [Color("AppRedLight"), Color("AppRedDark")]))
        let secondButton = UIHostingController(rootView: PrimaryButton(title: "Split Today", icon: "bucket", colors: [Color("AppThanosLight"), Color("AppThanosDark")]))
        let searchButton = UIHostingController(rootView: WorkoutPageSearchBar())
        
        let workoutHeading = UIHostingController(rootView: SecondaryHeading(title: "Workouts"))
        let exerciseOfTheDayHeading = UIHostingController(rootView: SecondaryHeading(title: "Exercise of the day"))
        
        firstButton.view.frame = CGRect(origin: .zero, size: firstButton.sizeThatFits(in: self.contentView.bounds.size))
        secondButton.view.frame = CGRect(origin: .zero, size: secondButton.sizeThatFits(in: self.contentView.bounds.size))
        searchButton.view.frame = CGRect(origin: .zero, size: searchButton.sizeThatFits(in: self.contentView.bounds.size))
        workoutHeading.view.frame = CGRect(origin: .zero, size: workoutHeading.sizeThatFits(in: self.contentView.bounds.size))
        exerciseOfTheDayHeading.view.frame = CGRect(origin: .zero, size: exerciseOfTheDayHeading.sizeThatFits(in: self.contentView.bounds.size))
        
        firstButton.view.backgroundColor = .clear
        secondButton.view.backgroundColor = .clear
        searchButton.view.backgroundColor = .clear
        workoutHeading.view.backgroundColor = .clear
        exerciseOfTheDayHeading.view.backgroundColor = .clear
       
        firstButton.view.translatesAutoresizingMaskIntoConstraints = false
        secondButton.view.translatesAutoresizingMaskIntoConstraints = false
        searchButton.view.translatesAutoresizingMaskIntoConstraints = false
        workoutHeading.view.translatesAutoresizingMaskIntoConstraints = false
        exerciseOfTheDayHeading.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(firstButton.view)
        self.contentView.addSubview(secondButton.view)
        self.contentView.addSubview(searchButton.view)
        self.contentView.addSubview(workoutHeading.view)
        self.contentView.addSubview(exerciseOfTheDayHeading.view)
        
        NSLayoutConstraint.activate([
            searchButton.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 105),
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
        
        
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.tableView)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: workoutHeading.view.bottomAnchor, constant: 5),
            self.tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.tableView.heightAnchor.constraint(equalToConstant: 900),
            
         
            exerciseOfTheDayHeading.view.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: -10),
            exerciseOfTheDayHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            exerciseOfTheDayHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

        ])
        
        let exerciseOne = UIHostingController(rootView: ExerciseOfTheDayCard(isTop: true, title: "Pushups", tags: ["Chest", "Triceps", "Shoulders"]))
        let exerciseTwo = UIHostingController(rootView: ExerciseOfTheDayCard(isTop: false, title: "Pullups", tags: ["Back", "Biceps"], url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShb8VZi2YQ1R4rXOSk1OZ4YuppENuRQtrBnA-Rh__mOeOWP4IqAF2jSsD90xMdYbekj9Q&usqp=CAU"))
        
        exerciseOne.view.frame = CGRect(origin: .zero, size: exerciseOne.sizeThatFits(in: self.contentView.bounds.size))
        exerciseTwo.view.frame = CGRect(origin: .zero, size: exerciseOne.sizeThatFits(in: self.contentView.bounds.size))

        exerciseOne.view.backgroundColor = .clear
        exerciseTwo.view.backgroundColor = .clear

        exerciseOne.view.translatesAutoresizingMaskIntoConstraints = false
        exerciseTwo.view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(exerciseOne.view)
        self.contentView.addSubview(exerciseTwo.view)

        NSLayoutConstraint.activate([
            exerciseOne.view.topAnchor.constraint(equalTo: exerciseOfTheDayHeading.view.bottomAnchor, constant: 5),
            exerciseOne.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            exerciseOne.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            exerciseTwo.view.topAnchor.constraint(equalTo: exerciseOne.view.bottomAnchor),
            exerciseTwo.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            exerciseTwo.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ])
    }
    
}

#Preview {
    ExerciseViewController()
}

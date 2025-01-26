//
//  ExerciseViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 21/01/25.
//

import UIKit
import SwiftUI

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let workouts: Array<(String, String, String, CGFloat)> = [("Upper Body", "Easy", "upperbody", 50), ("Lower Body", "Easy", "lowerbody", 65), ("Arm Builder", "Medium", "arms", 40), ("Core Create", "Hard", "core", 70), ("Delto Blast", "Hard", "shoulderone", 10), ("Delto Blast II", "Hard", "shouldertwo", 60)]
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
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
        
        cell.contentView.addSubview(workoutCard.view)
        
        workoutCard.view.frame = CGRect(origin: .zero, size: workoutCard.sizeThatFits(in: cell.contentView.bounds.size))
        
        workoutCard.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workoutCard.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            workoutCard.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            workoutCard.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            workoutCard.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            
        ])
        
        cell.contentView.backgroundColor = .clear
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
        
        let firstButton = UIHostingController(rootView: PrimaryButton(title: "Challenges", icon: "xbox", colors: [Color("AppRedLight"), Color("AppRedDark")]) {
            print("Navigation Started")
            self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChallengesPage"), animated: true)
            print("Navigation Ended")

        })
        let secondButton = UIHostingController(rootView: PrimaryButton(title: "Split Today", icon: "bucket", colors: [Color("AppThanosLight"), Color("AppThanosDark")]) {
            
        })
        let searchButton = UIHostingController(rootView: WorkoutPageSearchBar())
        
        let workoutHeading = UIHostingController(rootView: SecondaryHeading(title: "Workouts"))
        let exerciseOfTheDayHeading = UIHostingController(rootView: SecondaryHeading(title: "Exercise of the day"))
        
        let firstWorkout = UIHostingController(rootView: WorkoutCard(image: self.workouts[0].2, name: self.workouts[0].0, difficulty: self.workouts[0].1, sideOffset: self.workouts[0].3))
        let secondWorkout = UIHostingController(rootView: WorkoutCard(image: self.workouts[1].2, name: self.workouts[1].0, difficulty: self.workouts[1].1, sideOffset: self.workouts[1].3))
        let thirdWorkout = UIHostingController(rootView: WorkoutCard(image: self.workouts[2].2, name: self.workouts[2].0, difficulty: self.workouts[2].1, sideOffset: self.workouts[2].3))
        let fourthWorkout = UIHostingController(rootView: WorkoutCard(image: self.workouts[3].2, name: self.workouts[3].0, difficulty: self.workouts[3].1, sideOffset: self.workouts[3].3))
        let fifthWorkout = UIHostingController(rootView: WorkoutCard(image: self.workouts[4].2, name: self.workouts[4].0, difficulty: self.workouts[4].1, sideOffset: self.workouts[4].3))
        let sixthWorkout = UIHostingController(rootView: WorkoutCard(image: self.workouts[5].2, name: self.workouts[5].0, difficulty: self.workouts[5].1, sideOffset: self.workouts[5].3))
        
        [firstButton.view,searchButton.view, secondButton.view, workoutHeading.view, firstWorkout.view, secondWorkout.view, thirdWorkout.view, fourthWorkout.view, fifthWorkout.view, sixthWorkout.view, exerciseOfTheDayHeading.view].forEach {
            $0.frame = CGRect(origin: .zero, size: $0.sizeThatFits(self.contentView.bounds.size))
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        
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
            
            firstWorkout.view.topAnchor.constraint(equalTo: workoutHeading.view.bottomAnchor, constant: 10),
            firstWorkout.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            firstWorkout.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            secondWorkout.view.topAnchor.constraint(equalTo: firstWorkout.view.bottomAnchor, constant: 17),
            secondWorkout.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            secondWorkout.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            thirdWorkout.view.topAnchor.constraint(equalTo: secondWorkout.view.bottomAnchor, constant: 17),
            thirdWorkout.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thirdWorkout.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            fourthWorkout.view.topAnchor.constraint(equalTo: thirdWorkout.view.bottomAnchor, constant: 17),
            fourthWorkout.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            fourthWorkout.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            fifthWorkout.view.topAnchor.constraint(equalTo: fourthWorkout.view.bottomAnchor, constant: 17),
            fifthWorkout.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            fifthWorkout.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            sixthWorkout.view.topAnchor.constraint(equalTo: fifthWorkout.view.bottomAnchor, constant: 17),
            sixthWorkout.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            sixthWorkout.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            exerciseOfTheDayHeading.view.topAnchor.constraint(equalTo: sixthWorkout.view.bottomAnchor),
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
            exerciseOne.view.topAnchor.constraint(equalTo: exerciseOfTheDayHeading.view.bottomAnchor, constant: 10),
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

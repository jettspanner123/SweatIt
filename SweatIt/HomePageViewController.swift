//
//  HomePageViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 23/01/25.
//

import UIKit
import SwiftUI

class HomePageViewController: UIViewController {
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .red
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
//        contentView.backgroundColor = .yellow
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLinearGradient()
        self.setupScrollView()
        
        let pageHeading = self.addPageHeading()
        let navigationBar = self.addNavigationBar(whichPage: "Home")
        
        self.addPageElements()

        self.view.bringSubviewToFront(pageHeading)
        self.view.bringSubviewToFront(navigationBar)
    }
    
    
    private func addNavigationBar(whichPage: String) -> UIView {
        @State var something = 0
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Home", wantOffset: false, homeScreenAction: {
            
        }, workoutScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExercisePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, coachScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CoachPage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, dietScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DietPage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
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
    
    private func addLinearGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.darkBG.cgColor, UIColor.black.cgColor]
        
        
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.6)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1.88),

        ])
    }
    
    private func addPageElements() {
        let homePageStepCounter = UIHostingController(rootView: HomePageStepCounter(currentStepCount: 8000, goalStepCount: 15000))
        let homePageCalories = UIHostingController(rootView: HomePageCalories(caloriesConsumed: 1900, caloriesBurned: 193, totalCalories: 2500))
        let homePageHydrationCounter = UIHostingController(rootView: HomePageHydrationCounter(hydrationCount: 500, increaseCount: 250))
        let agendaHeading = UIHostingController(rootView: SecondaryHeading(title: "Agenda Today"))
        let agendaTodayList = UIHostingController(rootView: AgendaTodayList())
        let recentActivitiesHeading = UIHostingController(rootView: SecondaryHeading(title: "Recent Activities"))
        let activitiesButton = UIHostingController(rootView: PrimaryButton(title: "Activities", icon: "Bell", colors: [Color.appRedLight, Color.appRedDark]){
            print("actiity clicke")
        })
        let workoutButton = UIHostingController(rootView: PrimaryButton(title: "Workout", icon: "Workout", colors: [Color.appThanosLight, Color.appThanosDark]){
            print("actiity clicke")
        })
        let activityCardOne = UIHostingController(rootView: ActivityCard(isTop: true, heading: "Chest Workout", secondaryHeading: "Chest, Triceps", tertiaryHeading: "🔥 320 kCal", image: "pushups"))
        let activityCardTwo = UIHostingController(rootView: ActivityCard(isTop: false, isBottom: true, heading: "Basmati Rice", secondaryHeading: "Carbs: 28g", tertiaryHeading: "🥦 190 kCal", image: "rice"))

        
        
        
        [homePageStepCounter.view, homePageCalories.view, homePageHydrationCounter.view, agendaHeading.view, agendaTodayList.view, recentActivitiesHeading.view, activitiesButton.view, workoutButton.view, activityCardOne.view, activityCardTwo.view].forEach {
            $0.frame = CGRect(origin: .zero, size: $0.sizeThatFits(self.contentView.bounds.size))
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            homePageStepCounter.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            homePageStepCounter.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            homePageStepCounter.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            homePageCalories.view.topAnchor.constraint(equalTo: homePageStepCounter.view.bottomAnchor, constant: 15),
            homePageCalories.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            homePageCalories.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            homePageHydrationCounter.view.topAnchor.constraint(equalTo: homePageCalories.view.bottomAnchor, constant: 15),
            homePageHydrationCounter.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            homePageHydrationCounter.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            agendaHeading.view.topAnchor.constraint(equalTo: homePageHydrationCounter.view.bottomAnchor, constant: 0),
            agendaHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            agendaHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            agendaTodayList.view.topAnchor.constraint(equalTo: agendaHeading.view.bottomAnchor, constant: 10),
            agendaTodayList.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            agendaTodayList.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            recentActivitiesHeading.view.topAnchor.constraint(equalTo: agendaTodayList.view.bottomAnchor),
            recentActivitiesHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            recentActivitiesHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            activitiesButton.view.topAnchor.constraint(equalTo: recentActivitiesHeading.view.bottomAnchor, constant: 10),
            activitiesButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            
            workoutButton.view.topAnchor.constraint(equalTo: recentActivitiesHeading.view.bottomAnchor, constant: 10),
            workoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            
            activityCardOne.view.topAnchor.constraint(equalTo: activitiesButton.view.bottomAnchor, constant: 15),
            activityCardOne.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            activityCardOne.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            activityCardTwo.view.topAnchor.constraint(equalTo: activityCardOne.view.bottomAnchor),
            activityCardTwo.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            activityCardTwo.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
         
            
        ])
        
    }
    
    
    
    private func addPageHeading() -> UIView {
        let pageHeading = UIHostingController(rootView: PageHeader(pageHeaderTitle: "Home", wantOffset: false))
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
    
    
    
}

#Preview {
    HomePageViewController()
}

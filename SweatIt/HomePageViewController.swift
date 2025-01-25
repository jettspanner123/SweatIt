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
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLinearGradient()
        let pageHeading = self.addPageHeading()
        let navigationBar = self.addNavigationBar(whichPage: "Home")
        
        self.setupScrollView()
        self.addHomePageStepCounter()

        self.view.bringSubviewToFront(pageHeading)
        self.view.bringSubviewToFront(navigationBar)
    }
    
    
    private func addNavigationBar(whichPage: String) -> UIView {
        @State var something = 0
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Home", wantOffset: false))
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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 2),
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
    
    private func addHomePageStepCounter() {
        @State var currentStepCount: Int = 8000
        @State var goalStepCount: Int = 15000
        
        let homePageStepCounter = UIHostingController(rootView: HomePageStepCounter(currentStepCount: currentStepCount, goalStepCount: goalStepCount))
        let homePageCalories = UIHostingController(rootView: HomePageCalories(caloriesConsumed: 195, caloriesBurned: 1900, totalCalories: 2500))
        
        homePageStepCounter.view.frame = CGRect(origin: .zero, size: homePageStepCounter.sizeThatFits(in: self.contentView.bounds.size))
        homePageCalories.view.frame = CGRect(origin: .zero, size: homePageCalories.sizeThatFits(in: self.contentView.bounds.size))
        
        
        homePageStepCounter.view.backgroundColor = .clear
        homePageCalories.view.backgroundColor = .clear
        homePageStepCounter.view.translatesAutoresizingMaskIntoConstraints = false
        homePageCalories.view.translatesAutoresizingMaskIntoConstraints = false

        
        self.contentView.addSubview(homePageStepCounter.view)
        self.contentView.addSubview(homePageCalories.view)

        NSLayoutConstraint.activate([
            homePageStepCounter.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160),
            homePageStepCounter.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            homePageStepCounter.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            homePageCalories.view.topAnchor.constraint(equalTo: homePageStepCounter.view.bottomAnchor, constant: 15),
            homePageCalories.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            homePageCalories.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        
        
        
    }
    
}

#Preview {
    HomePageViewController()
}

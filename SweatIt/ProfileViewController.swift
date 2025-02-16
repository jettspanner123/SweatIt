//
//  ProfileViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 24/01/25.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    
    
    let options: Array<(String, String, Int)> = [("User Details", "User", 0), ("Notifications", "Bell", 1), ("Recommendations", "Like", 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageHeader = self.addPageHeading(headingTitle: "Profile")
        let navigationBar = self.addNavigationBar(whichPage: "Profile")
        self.addLinearGradient()
        self.setupScrollView()
        
        self.addItems()
        
        self.view.bringSubviewToFront(pageHeader)
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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 2),
        ])
    }
    
    private func addLinearGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.darkBG.cgColor, UIColor.black.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.6)
        
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
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Profile", wantOffset: false, homeScreenAction: {
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
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DietPage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, profileScreenAction: {
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
    
    private func addItems() {
        let profileHeader = UIHostingController(rootView: ProfilePageImageHeader())
        let profileLevelView = UIHostingController(rootView: ProfilePageLevelsCard())
        
        let firstTile = UIHostingController(rootView: SettingLable(text: "User Details", imageName: "User", isTop: true))
        let secondTile = UIHostingController(rootView: SettingLable(text: "Notifications", imageName: "Bell"))
        let thirdTile = UIHostingController(rootView: SettingLable(text: "Recommendations", imageName: "Like", isBottom: true))
        
        let pastStatisticsHeading = UIHostingController(rootView: HeadingWithLink(titleHeading: "Past Statistics", extraHeading: "", showExtraHeading: false))
        let stepCountGraph = UIHostingController(rootView: AvgStepCountGraph())
        let topPerformersHeading = UIHostingController(rootView: HeadingWithLink(titleHeading: "Top Performers", extraHeading: "", showExtraHeading: false))
        
        let firstPerformer = UIHostingController(rootView: Performer(name: "jettspanner123", points: 1000, imageName: "jettspanner", isTop: true, rank: 1))
        let secondPerformer = UIHostingController(rootView: Performer(name: "ronny_irani", points: 2000, imageName: "ronny", rank: 2))
        let thirdPerformer = UIHostingController(rootView: Performer(name: "soham_lobo66", points: 3000, imageName: "soham", isBottom: true, rank: 3))
        
        profileHeader.view.frame = CGRect(origin: .zero, size: profileHeader.sizeThatFits(in: self.contentView.bounds.size))
        profileLevelView.view.frame = CGRect(origin: .zero, size: profileLevelView.sizeThatFits(in: self.contentView.bounds.size))
        pastStatisticsHeading.view.frame = CGRect(origin: .zero, size: pastStatisticsHeading.sizeThatFits(in: self.contentView.bounds.size))
        stepCountGraph.view.frame = CGRect(origin: .zero, size: stepCountGraph.sizeThatFits(in: self.contentView.bounds.size))
        topPerformersHeading.view.frame = CGRect(origin: .zero, size: topPerformersHeading.sizeThatFits(in: self.contentView.bounds.size))
        
        firstTile.view.frame = CGRect(origin: .zero, size: firstTile.sizeThatFits(in: self.contentView.bounds.size))
        secondTile.view.frame = CGRect(origin: .zero, size: secondTile.sizeThatFits(in: self.contentView.bounds.size))
        thirdTile.view.frame = CGRect(origin: .zero, size: thirdTile.sizeThatFits(in: self.contentView.bounds.size))
        
        [profileHeader.view, profileLevelView.view, pastStatisticsHeading.view, stepCountGraph.view, topPerformersHeading.view, firstTile.view, secondTile.view, thirdTile.view, firstPerformer.view, secondPerformer.view, thirdPerformer.view].forEach {
            $0?.backgroundColor = .clear
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.contentView.addSubview(profileHeader.view)
        self.contentView.addSubview(profileLevelView.view)
        self.contentView.addSubview(firstTile.view)
        self.contentView.addSubview(secondTile.view)
        self.contentView.addSubview(thirdTile.view)
        self.contentView.addSubview(pastStatisticsHeading.view)
        self.contentView.addSubview(stepCountGraph.view)
        self.contentView.addSubview(topPerformersHeading.view)
        self.contentView.addSubview(firstPerformer.view)
        self.contentView.addSubview(secondPerformer.view)
        self.contentView.addSubview(thirdPerformer.view)
        
        NSLayoutConstraint.activate([
            profileHeader.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            profileHeader.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            profileHeader.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            profileLevelView.view.topAnchor.constraint(equalTo: profileHeader.view.bottomAnchor, constant: 25),
            profileLevelView.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            profileLevelView.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            firstTile.view.topAnchor.constraint(equalTo: profileLevelView.view.bottomAnchor, constant: 25),
            firstTile.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            firstTile.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            secondTile.view.topAnchor.constraint(equalTo: firstTile.view.bottomAnchor),
            secondTile.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            secondTile.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            thirdTile.view.topAnchor.constraint(equalTo: secondTile.view.bottomAnchor),
            thirdTile.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thirdTile.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            pastStatisticsHeading.view.topAnchor.constraint(equalTo: thirdTile.view.bottomAnchor, constant: 0),
            pastStatisticsHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            pastStatisticsHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            stepCountGraph.view.topAnchor.constraint(equalTo: pastStatisticsHeading.view.bottomAnchor, constant: -10),
            stepCountGraph.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stepCountGraph.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            topPerformersHeading.view.topAnchor.constraint(equalTo: stepCountGraph.view.bottomAnchor, constant: 10),
            topPerformersHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            topPerformersHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            firstPerformer.view.topAnchor.constraint(equalTo: topPerformersHeading.view.bottomAnchor, constant: -10),
            firstPerformer.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            firstPerformer.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            secondPerformer.view.topAnchor.constraint(equalTo: firstPerformer.view.bottomAnchor),
            secondPerformer.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            secondPerformer.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            thirdPerformer.view.topAnchor.constraint(equalTo: secondPerformer.view.bottomAnchor),
            thirdPerformer.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thirdPerformer.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
        ])
    }
    
}

#Preview {
    ProfileViewController()
}

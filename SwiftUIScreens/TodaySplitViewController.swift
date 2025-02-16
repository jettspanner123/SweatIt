//
//  TodaySplitViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 27/01/25.
//

import UIKit
import SwiftUI

class TodaySplitViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let sView = UIScrollView()
//        sView.backgroundColor = .red
        return sView
    }()
    
    var contentView: UIView = {
        let cView = UIView()
//        cView.backgroundColor = .yellow
        return cView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLinearGradient()
        let pageHeading = self.addPageHeading()
        
        self.setupScrollView()
        self.addPageElements()
        
        self.view.bringSubviewToFront(pageHeading)
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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1.05),
        ])
        
    }
    
    private func addPageElements() {
        let chooseWorkoutText = UIHostingController(rootView: Text_t(text: "Choose your workout split"))
        let chestWorkoutButton = UIHostingController(rootView: OptionView(title: "Chest Workout"))
        let backWorkoutButton = UIHostingController(rootView: OptionView(title: "Back Workout"))
        let armWorkoutButton = UIHostingController(rootView: OptionView(title: "Arm Workout"))
        let shoulderWorkoutButton = UIHostingController(rootView: OptionView(title: "Shoulder Workout"))
        let legWorkoutButton = UIHostingController(rootView: OptionView(title: "Leg Workout"))
        let fullBodyWorkoutButton = UIHostingController(rootView: OptionView(title: "Full Body Workout"))
        let floatingButton = UIHostingController(rootView: FloatingButtonBluredBackground(text: "Next"))
        
        chooseWorkoutText.view.translatesAutoresizingMaskIntoConstraints = false
        chooseWorkoutText.view.frame = CGRect(origin: .zero, size: chooseWorkoutText.sizeThatFits(in: self.contentView.bounds.size))
        chooseWorkoutText.view.backgroundColor = .clear
        self.contentView.addSubview(chooseWorkoutText.view)
        
        floatingButton.view.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.view.frame = CGRect(origin: .zero, size: floatingButton.sizeThatFits(in: self.view.bounds.size))
        floatingButton.view.backgroundColor = .clear
        self.view.addSubview(floatingButton.view)
        
        
        
        [chestWorkoutButton, backWorkoutButton, armWorkoutButton, shoulderWorkoutButton, legWorkoutButton, fullBodyWorkoutButton].forEach { someView in
            someView.view.frame = CGRect(origin: .zero, size: someView.sizeThatFits(in: self.contentView.bounds.size))
            someView.view.translatesAutoresizingMaskIntoConstraints = false
            someView.view.backgroundColor = .clear
            self.contentView.addSubview(someView.view)
        }
        
        
        
        self.contentView.addSubview(chooseWorkoutText.view)
        
        
        NSLayoutConstraint.activate([
            chooseWorkoutText.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 110),
            chooseWorkoutText.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            chooseWorkoutText.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            chestWorkoutButton.view.topAnchor.constraint(equalTo: chooseWorkoutText.view.bottomAnchor, constant: 20),
            chestWorkoutButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            chestWorkoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            backWorkoutButton.view.topAnchor.constraint(equalTo: chestWorkoutButton.view.bottomAnchor, constant: 20),
            backWorkoutButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            backWorkoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            armWorkoutButton.view.topAnchor.constraint(equalTo: backWorkoutButton.view.bottomAnchor, constant: 20),
            armWorkoutButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            armWorkoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            shoulderWorkoutButton.view.topAnchor.constraint(equalTo: armWorkoutButton.view.bottomAnchor, constant: 20),
            shoulderWorkoutButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            shoulderWorkoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            legWorkoutButton.view.topAnchor.constraint(equalTo: shoulderWorkoutButton.view.bottomAnchor, constant: 20),
            legWorkoutButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            legWorkoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            fullBodyWorkoutButton.view.topAnchor.constraint(equalTo: legWorkoutButton.view.bottomAnchor, constant: 20),
            fullBodyWorkoutButton.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            fullBodyWorkoutButton.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            floatingButton.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            floatingButton.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            floatingButton.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
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
    
    public func addPageHeading() ->UIView{
        let pageHeading = UIHostingController(rootView: AccentPageHeader(pageHeaderTitle: "Workout Split",wantOffset: false ,action: {
            self.dismiss(animated: true)
        }))
        
        pageHeading.view.frame = CGRect(origin: .zero, size: pageHeading.sizeThatFits(in: self.view.bounds.size))
        pageHeading.view.backgroundColor = .clear
        
        pageHeading.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageHeading.view)
        
        NSLayoutConstraint.activate([
            pageHeading.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -30),
            pageHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        
        return pageHeading.view
    }
    
}

#Preview {
    TodaySplitViewController()
}

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
//        scrollView.backgroundColor = .red.withAlphaComponent(0.5)
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
//        contentView.backgroundColor = .yellow.withAlphaComponent(0.5)
        return contentView
    }()

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
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Profile", wantOffset: false))
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
        profileHeader.view.frame = CGRect(origin: .zero, size: profileHeader.sizeThatFits(in: self.contentView.bounds.size))
        
        profileHeader.view.backgroundColor = .clear
        profileHeader.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(profileHeader.view)
        
        NSLayoutConstraint.activate([
            profileHeader.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            profileHeader.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            profileHeader.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
    
}

#Preview {
    ProfileViewController()
}

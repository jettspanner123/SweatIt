//
//  ViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 17/01/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @State var hAV: Int = 140
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .blue.withAlphaComponent(0.5)
        return scrollView
    }()
    
    var contentView: UIView = {
        let contentView = UIView()
//        contentView.backgroundColor = .red.withAlphaComponent(0.5)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.hAV = 100
        }
        
        self.addLinearGradient(colorOne: UIColor(named: "DarkBG") ?? .black, colorTwo: .black, from: CGPoint(x: 0.5, y: 0), to: CGPoint(x: 0.5, y: 1.5))
        let screenHeading = self.addHelperScreenPageHeading(headingTitle: "Challenges", heightAnchorValue: hAV)
       
        self.setupScrollView()
        self.view.bringSubviewToFront(screenHeading)

        let firstContestCard = self.getExerciseCardView(fromColor: Color("AppLavaOne"), toColor: Color("AppLavaTwo"), title: "Pushup Contest", desc: "Perform 20 reps in 10 secs.", difficulty: "Medium", image: "pushups", timing: "10 sec")
        let secondContestCard = self.getExerciseCardView(fromColor: Color("AppBlueLight"), toColor: Color("AppBlueDark"), title: "Squat Contest", desc: "Perform 100 reps in 5 mins.", difficulty: "Medium", image: "squats", timing: "5 min")
        let thirdContestCard = self.getExerciseCardView(fromColor: Color("AppCyanLight"), toColor: Color("AppCyanDark"), title: "Marathon Test", desc: "Run 400m in 1 mins.", difficulty: "Medium", image: "running", timing: "1 min")

        firstContestCard.translatesAutoresizingMaskIntoConstraints = false
        secondContestCard.translatesAutoresizingMaskIntoConstraints = false
        thirdContestCard.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(firstContestCard)
        self.contentView.addSubview(secondContestCard)
        self.contentView.addSubview(thirdContestCard)
        
        
        NSLayoutConstraint.activate([
            firstContestCard.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            firstContestCard.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            firstContestCard.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            secondContestCard.topAnchor.constraint(equalTo: firstContestCard.bottomAnchor, constant: 20),
            secondContestCard.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            secondContestCard.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            thirdContestCard.topAnchor.constraint(equalTo: secondContestCard.bottomAnchor, constant: 20),
            thirdContestCard.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thirdContestCard.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),



        ])
        
        
        
        // bure nazar wale tera moo kala
        
    }
    
    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.scrollView.addSubview(self.contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
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
    
    private func addLinearGradient(colorOne: UIColor, colorTwo: UIColor, from: CGPoint, to: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.startPoint = from
        gradientLayer.endPoint = to
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func getExerciseCardView(fromColor: Color, toColor: Color, title: String, desc: String, difficulty: String, image: String, timing: String) -> UIView {
        let exerciseCard = UIHostingController(rootView: ChallengeCard(colorFrom: fromColor, colorTo: toColor, title: title, helperTitle: desc, dificulty: difficulty, image: image, timing: timing))
        exerciseCard.view.frame = CGRect(origin: .zero, size: exerciseCard.sizeThatFits(in: self.view.bounds.size))
        exerciseCard.view.layer.cornerRadius = 17
        exerciseCard.view.backgroundColor = .clear
        
        exerciseCard.view.center = self.view.center
        
        return exerciseCard.view
    }
    
    
}

extension UIViewController {
    func addHelperScreenPageHeading(headingTitle: String, heightAnchorValue: Int) -> UIView {
        let secondaryPageHeading = UIHostingController(rootView: AccentPageHeader(pageHeaderTitle: "Challenges", wantOffset: false, action: {
            print("Clicked")
        }))
        secondaryPageHeading.view.frame = CGRect(origin: .zero, size: secondaryPageHeading.sizeThatFits(in: self.view.bounds.size))
        secondaryPageHeading.view.layer.cornerRadius = 17
        secondaryPageHeading.view.backgroundColor = .clear
        
        
        self.view.addSubview(secondaryPageHeading.view)
        
        NSLayoutConstraint.activate([
            secondaryPageHeading.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            secondaryPageHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            secondaryPageHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            secondaryPageHeading.view.heightAnchor.constraint(equalToConstant: 10),
            secondaryPageHeading.view.widthAnchor.constraint(equalToConstant: self.view.frame.width)
            
        ])
        
        return secondaryPageHeading.view
    }
    
    
}

#Preview {
    ViewController()
}

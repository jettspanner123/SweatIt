//
//  ViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 17/01/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.addLinearGradient(colorOne: UIColor(named: "DarkBG") ?? .black, colorTwo: .black, from: CGPoint(x: 0.5, y: 0), to: CGPoint(x: 0.5, y: 1.5))
        
        let pageHeading = UIHostingController(rootView: AccentPageHeader(pageHeaderTitle: "Challenges",wantOffset: false ,action: {
            self.dismiss(animated: true)
        }))
        
        pageHeading.view.frame = CGRect(origin: .zero, size: pageHeading.sizeThatFits(in: self.view.bounds.size))
        pageHeading.view.backgroundColor = .clear
        
        pageHeading.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageHeading.view)
        
        
        NSLayoutConstraint.activate([
            pageHeading.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -64),
            pageHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
       
        self.setupScrollView()
        

        let firstContestCard = self.getExerciseCardView(fromColor: Color("AppLavaOne"), toColor: Color("AppLavaTwo"), title: "Pushup Contest", desc: "Perform 20 reps in 10 secs.", difficulty: "Medium", image: "pushups", timing: "10 sec")
        let secondContestCard = self.getExerciseCardView(fromColor: Color("AppBlueLight"), toColor: Color("AppBlueDark"), title: "Squat Contest", desc: "Perform 100 reps in 5 mins.", difficulty: "Medium", image: "squats", timing: "5 min")
        let thirdContestCard = self.getExerciseCardView(fromColor: Color("AppCyanLight"), toColor: Color("AppCyanDark"), title: "Marathon Test", desc: "Run 400m in 1 mins.", difficulty: "Medium", image: "running", timing: "1 min")
        
        
        [firstContestCard, secondContestCard, thirdContestCard].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
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
        
        self.view.bringSubviewToFront(pageHeading.view)
        
        
        // bure nazar wale tera moo kala
        
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

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return RightSlideTransition(isPresenting: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return RightSlideTransition(isPresenting: true)
    }
}



class RightSlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.55
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)
        
        if isPresenting {
            toViewController?.view.frame = containerView.bounds.offsetBy(dx: containerView.bounds.width, dy: 0)
            
            containerView.addSubview(toViewController!.view)
            
            let timingFunction = CAMediaTimingFunction(controlPoints: 0.83, 0, 0.17, 1)
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(timingFunction)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewController?.view.frame = containerView.bounds
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
            CATransaction.commit()
            
        } else {
            let timingFunction = CAMediaTimingFunction(controlPoints: 0.83, 0, 0.17, 1) // bhai ye custom cubic bezie hai
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(timingFunction)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromViewController?.view.frame = containerView.bounds.offsetBy(dx: containerView.bounds.width, dy: 0)
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
            CATransaction.commit()
        }
    }
}



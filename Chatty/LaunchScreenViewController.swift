//
//  LaunchScreenViewController.swift
//  Chatty
//
//  Created by Jenny Lee on 5/29/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    private var animate: Bool = false
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud5: UIImageView!
    
    @IBOutlet weak var cloud1Constraint: NSLayoutConstraint!
    @IBOutlet weak var cloud2Constraint: NSLayoutConstraint!
    @IBOutlet weak var cloud5Constraint: NSLayoutConstraint!
    

    private func cloudAnimation() {
      let options: UIView.AnimationOptions = [.curveEaseInOut,
                                              .repeat,
                                              .autoreverse]

        
        UIView.animate(withDuration: 4.0,
                       delay: 0,
                       options: options,
                       animations: { [weak self] in
                        self?.cloud5.frame.size.height *= 1.1
                        self?.cloud5.frame.size.width *= 1.1
        }, completion: nil)
        
      UIView.animate(withDuration: 4.0,
                     delay: 0,
                     options: options,
                     animations: { [weak self] in
                        self?.cloud2.frame.size.height *= 0.8
                        self?.cloud2.frame.size.width *= 0.8
      }, completion: nil)

        UIView.animate(withDuration: 4.0,
                     delay: 0,
                     options: options,
                     animations: { [weak self] in
                      self?.cloud1.frame.size.height *= 1.4
                      self?.cloud1.frame.size.width *= 1.4
      }, completion: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //cloudAnimation()
        
        cloud5Constraint.constant += view.bounds.width * 1.2

//        UIView.animate(withDuration: 3.0, delay: 3.5, options: []) {
//            [weak self] in
//             self?.view.layoutIfNeeded()
//        }
//        
//        cloud2Constraint.constant -= view.bounds.width * 1.5
//
//        UIView.animate(withDuration: 3.5, delay: 3.8, options: []) {
//            [weak self] in
//             self?.view.layoutIfNeeded()
//        }
        
        cloud1Constraint.constant += view.bounds.width * 1.2
        
        UIView.animate(withDuration: 3.0,
                       delay: 4.0,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
                       }) { (true) in
            self.performSegue(withIdentifier: "launchToLogin", sender: nil)
        }
        

    }
//
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //animate
//        view.addSubview(imageView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
    }

    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        imageView.center = view.center
//        animate()
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
//            self.animate()
//        })
//    }
//
//    private func animate() {
//        UIView.animate(withDuration: 1, animations: {
//            let size = self.view.frame.size.width * 1.5
//            let diffX = size - self.view.frame.size.width
//            let diffY = self.view.frame.size.height - size
//            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
//        })
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

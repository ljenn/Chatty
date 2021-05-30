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
    
    @IBOutlet weak var topCloud: UIImageView!
    @IBOutlet weak var bottomCloud: UIImageView!
    @IBOutlet weak var kiteStackView: UIStackView!
    
    @IBOutlet weak var topCloudConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomCloudConstraint: NSLayoutConstraint!
    
    //    private let imageView: UIImageView = {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//        imageView.image = UIImage(named: "logo")
//        return imageView
//    }()
    
    private func cloudAnimation() {
      let options: UIView.AnimationOptions = [.curveEaseInOut,
                                              .repeat,
                                              .autoreverse]

//        UIView.animate(withDuration: 3.0,
//                       delay: 0,
//                       options: options,
//                       animations: { [weak self] in
//                        self?.kiteStackView.frame.size.height *= 1.15
//                        self?.kiteStackView.frame.size.width *= 1.15
//        }, completion: nil)
        
      UIView.animate(withDuration: 2.9,
                     delay: 0,
                     options: options,
                     animations: { [weak self] in
                      self?.bottomCloud.frame.size.height *= 1.18
                      self?.bottomCloud.frame.size.width *= 1.18
      }, completion: nil)

      UIView.animate(withDuration: 3.0,
                     delay: 0,
                     options: options,
                     animations: { [weak self] in
                      self?.topCloud.frame.size.height *= 1.28
                      self?.topCloud.frame.size.width *= 1.28
      }, completion: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cloudAnimation()
        
        bottomCloudConstraint.constant -= (view.bounds.width * 2.0)

//        UIView.animate(withDuration: 3.0, delay: 0) { [weak self] in
//          self?.view.layoutIfNeeded()
//        }

        topCloudConstraint.constant -= (view.bounds.width * 2.0)

        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
                       }) { (true) in
            self.performSegue(withIdentifier: "launchToLogin", sender: nil)
        }
        

//        passwordTextFieldCenterConstraint.constant = 0
//
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.4,
//                       animations: { [weak self] in
//                        self?.view.layoutIfNeeded()
//          }, completion: nil)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1.2,
//                       options: .curveEaseInOut,
//                       animations: { [weak self] in
//                        self?.loginButton.backgroundColor = .systemYellow
//          }, completion: nil)

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
        topCloudConstraint.constant += (view.bounds.width * 1.2)
        bottomCloudConstraint.constant += (view.bounds.width * 1.2)
      
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

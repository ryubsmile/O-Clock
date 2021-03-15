//
//  InitViewController.swift
//  O'Clock
//
//  Created by J.Ryu on 2021/03/14.
//

import UIKit

class InitViewController: UIViewController {

    @IBOutlet weak var LoadAnimationImage: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    func rotateHalf(){
        self.LoadAnimationImage.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func zoom(){
        //self.LoadAnimationImage.transform = .identity
        self.LoadAnimationImage.transform = CGAffineTransform(scaleX: 200.0, y: 200.0)
    }
    
    func animate(){
        UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5,
                               animations: {self.rotateHalf()}
            )
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5,
                               animations: {self.LoadAnimationImage.transform = CGAffineTransform(rotationAngle: .pi - 0.01)}
            )
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5,
                               animations: {self.zoom()}
            )
        }, completion: { [self] finished in
            afterLoad()
        })
    }
    
    func afterLoad(){ //transition to "" vc, "" = arrow
        performSegue(withIdentifier: "test_segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }

}

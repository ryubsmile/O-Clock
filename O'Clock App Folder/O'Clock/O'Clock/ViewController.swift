//
//  ViewController.swift
//  O'Clock
//
//  Created by J.Ryu on 2021/03/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Clock: UIImageView!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var TimeText: UILabel!
    @IBOutlet weak var topBar: UINavigationItem!
    
    static var clicked: Bool = false //for StartButton
    var sec: Int = 1
    var titleText = String()
    var segueSignal = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleText
        
        Clock.layer.masksToBounds = true
        Clock.layer.cornerRadius = Clock.bounds.width / 2
        //Sets the constraints to circular view so that the buttons nearby are not bothered.
        
        TimeText.text = String(format: "%02d:%02d:%02d", sec/3600, (sec%3600)/60, sec%60)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let menuVC = segue.destination as? TableViewController else { return }
        menuVC.timeAdded = sec
        menuVC.segueSignal = segueSignal
        menuVC.dateNow = Date(timeIntervalSinceNow: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        let navigationController: UINavigationController = self.navigationController!

        let controllers: [TableViewController] = navigationController.viewControllers.filter({ $0 is TableViewController }) as! [TableViewController]

        if let viewController: TableViewController = controllers.first {
            viewController.timeAdded = sec
        }
    }
    
    
    private func updateTime(displayTime: Int){
        self.TimeText.text = String(format: "%02d:%02d:%02d", displayTime/3600, (displayTime%3600)/60, displayTime%60)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //toggles bool value for a button, so as it behaves like a switch.
        if(ViewController.clicked){ //when clicked
            StartButton.setTitle("Resume", for: .normal)
            ViewController.clicked = false
        }else{//when running
            StartButton.setTitle("Stop", for: .normal)
            ViewController.clicked = true
        }
        rotate(howManySec: sec)
    }

    private func rotate(howManySec seconds: Int){
        //rotates the second hand.
        UIView.animate(withDuration: 0.6, delay: 0.4,
            options: [],
            animations: {self.Clock.transform = CGAffineTransform(rotationAngle: (6 * .pi * CGFloat(seconds) / 180))},
                completion: { [self] finished in
                    
                    updateTime(displayTime: sec)
                    
                    if(ViewController.clicked){
                        sec = seconds + 1
                        rotate(howManySec: seconds + 1)
                    }
                }
            )
    }
}

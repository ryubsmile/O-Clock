//
//  TableMenuViewController.swift
//  O'Clock
//
//  Created by J.Ryu on 2021/03/15.
//

import UIKit

class TableMenuViewController: UITableViewController {

    @IBOutlet weak var obj1: UIImageView!
    
    func loadNextView(){ //transition to "" vc, "" = arrow
        performSegue(withIdentifier: "TimerSelected", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNextView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

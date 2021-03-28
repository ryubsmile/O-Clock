//
//  TableViewController.swift
//  O'Clock
//
//  Created by J.Ryu on 2021/03/15.
//

import UIKit

struct CellData {
    var activityName : String?
    var timeSpent : Int?
    var lastUsed : Date?
}

class TableViewController: UITableViewController {

    var segueSignal = -1
    var data = [CellData]()
    var timeAdded = 0
    var dateNow = Date(timeIntervalSinceReferenceDate: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let default_sports_category = CellData(activityName: "Sports", timeSpent: timeAdded, lastUsed: dateNow)
        let default_study_category = CellData(activityName: "Study", timeSpent: 32048, lastUsed: Date(timeIntervalSinceReferenceDate: Double.random(in: 1..<10000000)))
        let default_sleep_category = CellData(activityName: "Sleep", timeSpent: 3650, lastUsed: Date(timeIntervalSinceReferenceDate: Double.random(in: 1..<10000000)))

        data.append(default_sports_category)
        data.append(default_study_category)
        data.append(default_sleep_category)
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    //Number of Total Sections.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //cell heights
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = 70.0;
        
        if(indexPath.section == 0){
            cellHeight = 50.0;
        }
        
        return cellHeight
    }
    
    //Number of rows in a particular section[section]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return 3
        }
    }

    //The first row cell = special.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        
        switch indexPath.section{
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
            let data_index = indexPath.row
            let data_forThisRow = data[data_index]
            
            if let activity_name_label = cell.viewWithTag(1) as? UILabel{
                activity_name_label.text = data_forThisRow.activityName
            }
            if let hours_counted_label = cell.viewWithTag(2) as? UILabel{
                let timeSpent = data_forThisRow.timeSpent
                hours_counted_label.text = String(format: "%05dh%02dm%02ds", timeSpent!/3600, (timeSpent!%3600)/60, timeSpent!%60)
            }
            if let last_date_used_label = cell.viewWithTag(3) as? UILabel{
                last_date_used_label.text = formatter.string(from: data_forThisRow.lastUsed ?? Date(timeIntervalSinceReferenceDate: 0))
                if(last_date_used_label.text == formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))){
                    last_date_used_label.text = "Never Used."
                }
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        
            if let label = cell.viewWithTag(999) as? UILabel{
                label.text = "SWIPE TO USE STOPWATCH"
            }
            
            return cell
        }
    }

    //Edit Section title.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle:String = ""

        if(section == 1){
            sectionTitle = "Tasks"
        }
        return sectionTitle
    }
    
    //swipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        switch indexPath.section{
        case 0:
            let open_stopwatch = UIContextualAction(style: .destructive, title: "STOPWATCH") { (action, view, success ) in
                
                self.segueSignal = -1
                self.performSegue(withIdentifier: "open_segue", sender: self)
            }

            let config = UISwipeActionsConfiguration(actions: [open_stopwatch])
            return config
        default:
            return nil
        }
    }
    
    //touch to segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            segueSignal = indexPath.row
            self.performSegue(withIdentifier: "open_segue", sender: self)
        }
    }
    
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? ViewController else { return }
        
        switch segueSignal{
        case -1:
            destinationVC.titleText = "Just a stopwatch..."
        default:
            destinationVC.sec = data[segueSignal].timeSpent!
            destinationVC.titleText = data[segueSignal].activityName!
            destinationVC.segueSignal = segueSignal
        }
    }
    
    //testing
//    @IBAction func didunwindFromTimer(_ sender: UIStoryboardSegue){
//
//        guard let destinationVC = sender.source as? ViewController else { return }
//        timeAdded = destinationVC.sec
//        dateNow = destinationVC.titleText
//
//        switch segueSignal {
//        case -1:
//            break
//        default:
//            data[segueSignal].timeSpent! = timeAdded
//            data[segueSignal].lastUsed! = dateNow
//        }
//    }
    
}

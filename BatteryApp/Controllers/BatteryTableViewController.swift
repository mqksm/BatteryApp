//
//  BatteryTableViewController.swift
//  BatteryApp
//
//  Created by Maks on 10.05.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class BatteryTableViewController: UITableViewController {
    
    var activeApps:[Application] = []
    var sortedApps:[Application] = []
    
    var myTimer: Timer!
    var myTimer2: Timer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getActiveApps()
        updateBatteryUsage()
        sortApps()
        
        //        sortApps()
        
        self.myTimer = Timer(timeInterval: 20.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        RunLoop.main.add(self.myTimer, forMode: .default)
        
        self.myTimer2 = Timer(timeInterval: 3.0, target: self, selector: #selector(refresh2), userInfo: nil, repeats: true)
        RunLoop.main.add(self.myTimer2, forMode: .default)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc
    func refresh() {
        print("timer 1")
        updateBatteryUsage()
        
    }
    
    @objc
    func refresh2() {
        disableApp()
        print("timer 2")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        //        updateBatteryUsage()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Battery Usage"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activeApps.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let app = activeApps[indexPath.row]
        cell.textLabel?.text = app.name
        cell.imageView?.image = UIImage(named: app.picture)
        cell.detailTextLabel?.text = String(app.batteryUsage) + " mAh"
        
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func sortApps()  {
        sortedApps = applications.sorted(by: { $0.batteryUsage > $1.batteryUsage })
    }
    
    func updateBatteryUsage(){
        
        for app in applications{
            app.batteryUsage = Int.random(in: 1..<1000)
        }
        sortApps()
        getActiveApps()
        print("Battery usage updated")
        
    }
    
    func getActiveApps(){
        
        activeApps = sortedApps
        
        //        activeApps = []
        //        for app in sortedApps{
        //            if app.batteryUsage != 0 {
        //                activeApps.append(app)
        //            }
        //        }
        tableView.reloadData()
    }
    
    func disableApp(){
        sortedApps.remove(at: 0)
        print("app removed")
        
        getActiveApps()
    }
    
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        myTimer.invalidate()
        myTimer2.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
}

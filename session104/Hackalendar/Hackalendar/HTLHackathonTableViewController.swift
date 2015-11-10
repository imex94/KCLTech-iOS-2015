//
//  HTLHackathonTableViewController.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

class HTLHackathonTableViewController: UITableViewController, HTLHackathonTableViewDelegate {

    var selectedRow = 0
    var hackathons = [HTLHackathon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchHackathons()
        
        tableView.registerNib(UINib(nibName: "HTLHackathonTableViewCell", bundle: nil), forCellReuseIdentifier: "hackathonCell")
        
        self.navigationController?.navigationBar.topItem?.title = "Hackathons"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchHackathons() {
        
        HTLHackathonProvider.provideHackathonsFor(11) { (hackathons) -> Void in
            
            self.hackathons.appendContentsOf(hackathons)
            self.hackathons.sortInPlace({$0.dateCode < $1.dateCode})
            
            self.geoLocateHackathons()
            
            self.tableView.reloadData()
        }
    }
    
    func geoLocateHackathons() {
        
        for hackathon in hackathons {
            
            HTLLocationUtility.geolocateCityForLocationName(hackathon.city, completitionHandler: { (coordinate) -> Void in
                
                hackathon.coordinate = coordinate
                
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 260.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hackathons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hackathonCell", forIndexPath: indexPath) as! HTLHackathonTableViewCell

        cell.delegate = self
        
        let currentHackathon = hackathons[indexPath.row]
        
        cell.tag = indexPath.row
        cell.hackathonName.text = currentHackathon.title
        cell.hackathonDate.text = currentHackathon.startDate
        cell.HackathonPlace.text = HTLLocationUtility.extractCityFromLocation(currentHackathon.city)
        
        cell.addLocation(currentHackathon.coordinate)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (rowAction, indexPath) -> Void in
            tableView.editing = false
        }
        
        return [deleteAction]
    }
    
    // MARK: - HTLHackathonTableViewDelegate
    
    func performSegueOnMapClick(index: Int) {
        
        selectedRow = index
        performSegueWithIdentifier("showDetails", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destinationViewController as! HTLHackathonDetailViewController
        
//        For example
//        destinationViewController.title = "Row \(selectedRow + 1)"
        
        destinationViewController.title = hackathons[selectedRow].title
    }
}

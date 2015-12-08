//
//  HTLHackathonTableViewController.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import HackalendarSDK

class HCHackathonTableViewController: UITableViewController, HCHackathonTableViewDelegate {

    var selectedRow = 0
    var hackathons = [HSHackathon]()
    
    var currentYear = HSCalendarUtility.getCurrentYear()
    var currentMonth = HSCalendarUtility.getCurrentMonth()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "HCHackathonTableViewCell", bundle: nil), forCellReuseIdentifier: "hackathonCell")
        
        self.navigationController?.navigationBar.topItem?.title = "Hackathons"
        
        hackathons = HSHackathonProvider.loadHackathons(currentYear, month: currentMonth)
        
        if hackathons.count == 0 {
         
            fetchData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        
        HSHackathonProvider.provideHackathonsFor(currentYear, month: currentMonth) { (hackathons) -> Void in
            
            self.hackathons.appendContentsOf(hackathons)

            self.locateHackathons()
            
            self.tableView.reloadData()
        }
    }
    
    func locateHackathons() {
        
        for hackathon in hackathons {
            
            HSLocationUtility.locateCityForLocationName(hackathon.city, completitionHandler: { (coordinate) -> Void in
                
                if let location = coordinate {
                 
                    hackathon.latitude = location.latitude
                    hackathon.longitude = location.longitude
                    
                    // Save context again as we changed the managed object's latitude and longitude
                    HSDataManager.saveContext()
                }
                
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 260.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hackathons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hackathonCell", forIndexPath: indexPath) as! HCHackathonTableViewCell

        cell.delegate = self
        
        let currentHackathon = hackathons[indexPath.row]
        
        cell.tag = indexPath.row
        cell.hackathonName.text = currentHackathon.title
        cell.hackathonDate.text = currentHackathon.startDate
        cell.HackathonPlace.text = HSLocationUtility.extractCityNameFromLocation(currentHackathon.city)

        cell.addLocation(currentHackathon.latitude?.doubleValue, longitude: currentHackathon.longitude?.doubleValue)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // This was missing from the previous code, clicking on the transparent view
        // passed the same hackathon name to the detail view - Now it is fixed
        selectedRow = indexPath.row
        
        performSegueWithIdentifier("showDetails", sender: self)
        
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

    /**
        In a storyboard-based application, you will often want to do a little preparation before navigation
        Get the new view controller using segue.destinationViewController.
        Pass the selected object to the new view controller.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationViewController = segue.destinationViewController as! HCHackathonDetailViewController
        destinationViewController.title = hackathons[selectedRow].title
        // Passing the hackathon object to the detail view
        destinationViewController.hackathon = hackathons[selectedRow]
    }

}

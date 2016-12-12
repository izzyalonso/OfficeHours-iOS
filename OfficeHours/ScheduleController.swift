//
//  ScheduleController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/7/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit


class ScheduleController: UITableViewController, AddCourseDelegate{
    var courses = [CourseModel]()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Automatic height calculation
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Dummy data
        //courses.append(Course(name: "Test", time: "At time"))
        //courses.append(Course(name: "Test 2", time: "At noon"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseCell
        cell.bind(course: courses[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 67
    }
    
    @IBAction func addClicked(_ sender: Any){
        performSegue(withIdentifier: "AddCourseFromSchedule", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "AddCourseFromSchedule"){
            let addCourseController = segue.destination as! AddCourseController
            addCourseController.delegate = self
        }
    }
    
    func onCourseAdded(course: CourseModel){
        courses.append(course)
        tableView.reloadData()
    }
}

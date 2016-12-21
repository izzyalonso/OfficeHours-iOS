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
        courses.append(CourseModel(code: "COMP 1900", name: "Intro to CS", meetingTime: "MW 7", lastMeetingDate: "12/14", instructorName: "Someboody"))
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
        if SharedData.getUser()!.isStudent(){
            performSegue(withIdentifier: "AddCourseFromSchedule", sender: self)
        }
        else{
            performSegue(withIdentifier: "CourseEditorFromSchedule", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddCourseFromSchedule"{
            let addCourseController = segue.destination as! AddCourseController
            addCourseController.delegate = self
        }
        else if segue.identifier == "CourseFromSchedule"{
            let courseController = segue.destination as! CourseController
            let indexPath = tableView.indexPath(for: sender as! CourseCell)
            courseController.course = courses[indexPath!.row]
        }
    }
    
    func onCourseAdded(course: CourseModel){
        courses.append(course)
        tableView.reloadData()
    }
}

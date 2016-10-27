//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Ryan Chee on 10/26/16.
//  Copyright © 2016 Chihiro Saito. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    var messages: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTableView.dataSource = self
        self.messageTableView.estimatedRowHeight = 100
        self.messageTableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        sendMessage()
    }
    
    func onTimer() {
        // Add code to be run periodically
        queryMessages()
    }
    
    func queryMessages() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects as NSArray
                }
                self.messageTableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
        }

    }
    
    func sendMessage() {
        let message = PFObject(className: "Message")
        message["text"] = messageTextField.text!
        message.saveInBackground {
        (success: Bool, error: Error?) -> Void in
            if (success) {
                // The object has been saved.
                NSLog("saved message: " + self.messageTextField.text!)
            } else {
                // There was a problem, check error.description
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        let messageObj = self.messages[indexPath.row] as! PFObject
        if let text = messageObj["text"] {
            cell.messageLabel.text = text as! String
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}

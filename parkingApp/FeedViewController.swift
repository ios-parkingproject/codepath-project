//
//  FeedViewController.swift
//  parkingApp
//
//  Created by Huanjia Liang on 3/9/19.
//  Copyright © 2019 Huanjia Liang. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("here \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let index=post["parkingIndex"] as! String
        cell.parkingField.text="Parking Space Number \(index)"
        let avail=post["availability"] as! Bool
        cell.setReserved(!avail)
        cell.selectedPost=post
        return cell
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query=PFQuery(className: "parkingSpot")
        query.limit = 10
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            else{
                print("did not find it")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
        }

        // Do any additional setup after loading the view.
}




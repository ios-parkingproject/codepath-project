//
//  PostCell.swift
//  parkingApp
//
//  Created by Huanjia Liang on 3/9/19.
//  Copyright © 2019 Huanjia Liang. All rights reserved.
//

import UIKit
import Parse
class PostCell: UITableViewCell {
    var reserverd:Bool=false
    var selectedPost: PFObject!
    @IBOutlet weak var releaseButton: UIButton!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var parkingField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setReserved(_ isReserved:Bool){
        reserverd=isReserved
        if(reserverd){
            reserveButton.backgroundColor=UIColor.gray
            releaseButton.backgroundColor=UIColor(red:0.45, green:0.63, blue:0.99, alpha:1.0)
            
            
        }
        else{
            reserveButton.backgroundColor=UIColor(red:0.45, green:0.63, blue:0.99, alpha:1.0)
            releaseButton.backgroundColor=UIColor.gray
            
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRelease(_ sender: Any) {
        if(reserverd){
            selectedPost["availability"]=true
            selectedPost.saveInBackground { (success, error) in
                if (success) {
                    self.setReserved(false)
                } else {
                    print("release failed")
                }
            }
        }
        
    }
    
    @IBAction func onReserve(_ sender: Any) {
        if(!reserverd){
            selectedPost["availability"]=false
            selectedPost.saveInBackground { (success, error) in
                if (success) {
                    self.setReserved(true)
                } else {
                    print("reserve failed")
                }
            }
            
        }
    }
}

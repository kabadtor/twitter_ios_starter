//
//  TweetCell.swift
//  Twitter
//
//  Created by Karla on 2/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var favorited:Bool = false
    var tweetID:Int = -1
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("favorite did not succeed")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("unfavorite did not succeed")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: {(error) in
            print("Error in retweeting \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PhotosViewController.swift
//  Mytumblr
//
//  Created by Minjing Shi on 2/15/19.
//  Copyright © 2019 Minjing Shi. All rights reserved.
//

import UIKit
import Alamofire
class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var posts: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                // TODO: Reload the table view
                
            }
        }
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
  
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = "This is row \(indexPath.row)"
        let post = posts[indexPath.row]
        // 1.            // 2.          // 3.
        if let photos = post["photos"] as? [[String: Any]] {
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            cell.photoImageView.af_setImage(withURL: url!)
            self.tableView.reloadData()
        }
        return cell
        
    }
    
//    func tableView(tableView: UITableView, cellForRowAtindexPath: indexPath: indexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//
//        // Configure YourCustomCell using the outlets that you've defined.
//
//        return cell
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

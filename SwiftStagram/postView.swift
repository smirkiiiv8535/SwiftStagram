//
//  postView.swift
//  SwiftStagram
//
//  Created by 林祐辰 on 2020/8/17.
//

import UIKit


class postView: UITableViewController {

    var index : IndexPath!
    var data : FetchInstagramData!
    var posts = [FetchInstagramData.Graphql.UserData.Edge_owner_to_timeline_media.Edges]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for:indexPath)as! postCell
        
        
        let postData = posts[indexPath.row]

        
        cell.userName.text = data.graphql.user.username
        cell.likeText.text = "\(postData.node.edge_liked_by!.count) Likes"
        

        // Post timestamp
        let timestamp = postData.node.taken_at_timestamp
        let postTime = Date(timeIntervalSince1970: timestamp!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = dateFormatter.string(from: postTime)
        
       
        cell.postDateText.text = " \(dateString)"
        cell.paragraphText.text = postData.node.edge_media_to_caption?.edges[0].node.text
        
        let profilePic = data.graphql.user.profile_pic_url
            
            URLSession.shared.dataTask(with: profilePic){ data, response, error in
              
              if let data = data , let image = UIImage(data:data){
                  DispatchQueue.main.async {
                      cell.userImage.image = image
                  }
              }
            }.resume()
        
      
        
        
        if let pictureUrl = postData.node.thumbnail_src{
            
          URLSession.shared.dataTask(with: pictureUrl){ data, response, error in
            
            if let data = data , let image = UIImage(data:data){
                DispatchQueue.main.async {
                    cell.postPhoto.image = image
                }
            }
        
          
          }.resume()
            
            
        }
    
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

}


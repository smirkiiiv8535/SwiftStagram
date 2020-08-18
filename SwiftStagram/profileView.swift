//
//  profileView.swift
//  SwiftStagram
//
//  Created by 林祐辰 on 2020/8/16.
//

import UIKit


class profileView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    var data : FetchInstagramData!
    var posts = [FetchInstagramData.Graphql.UserData.Edge_owner_to_timeline_media.Edges]()

    @IBOutlet weak var profileCollectionTable: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHomePhoto()
        resizeCollectionViewLayout()
        self.navigationController?.isNavigationBarHidden = true
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func updateHomePhoto(){
            let urlLink = "https://www.instagram.com/nb_ootd/?__a=1"
            
            if let url = URL(string:urlLink){
                URLSession.shared.dataTask(with:url){(data,response,error) in
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
            
            
                if let data = data , let renderData = try? decoder.decode(FetchInstagramData.self,from: data){
                    self.data = renderData
                        self.posts = renderData.graphql.user.edge_owner_to_timeline_media.edges
                        DispatchQueue.main.async {
                            self.profileCollectionTable.reloadData()
                        }
                    }
                }.resume()
        }
        }
        

        
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

           let reuseCollectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "profileCell", for: indexPath) as! IGHeader
            
            let urlLink = "https://www.instagram.com/nb_ootd/?__a=1"
            
            if let url = URL(string:urlLink){
                URLSession.shared.dataTask(with:url){(data,response,error) in
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
            
    if let inputData = data , let renderData = try?decoder.decode(FetchInstagramData.self,from: inputData){
                         let profileData = renderData.graphql.user
                    DispatchQueue.main.async { [self] in
                        reuseCollectionHeader.FollwersNum.text = preventNumberBug(profileData.edge_followed_by.count)
                        reuseCollectionHeader.FollwingNum.text = preventNumberBug(profileData.edge_follow.count)
                        reuseCollectionHeader.postNum.text = preventNumberBug(profileData.edge_owner_to_timeline_media.count)
                        reuseCollectionHeader.userName.text = profileData.username
                        reuseCollectionHeader.profileName.text = profileData.full_name
                        transformURLtoPic(url:profileData.profile_pic_url,imageView: reuseCollectionHeader.profileImage)
                        
                        }
                    }
                }.resume()
        }
            return reuseCollectionHeader
    }

        func transformURLtoPic(url:URL,imageView:UIImageView){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }.resume()
        }
        
        func preventNumberBug(_ num: Int) -> String{
            if num > 1000000 {
                return "\(num / 1000000) M"
            } else if num > 1000 {
                return "\(num / 1000) K"
            } else {
                return String(num)
            }
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return posts.count
        }
        
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"articleAddCell",for:indexPath) as! articlePicCell
        
        if let imageData = posts[indexPath.row].node.thumbnail_src{
            URLSession.shared.dataTask(with: imageData){(data,response,error) in
        
                if let data = data{
                    DispatchQueue.main.async {
                        cell.articlePic?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        return cell
       }

    
        
        func resizeCollectionViewLayout() {

            let flowLayout = UICollectionViewFlowLayout()
            
            flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: 220)
            
       flowLayout.itemSize = CGSize(width: view.frame.width/3-5, height: view.frame.width/3+5)
            
            flowLayout.estimatedItemSize = .zero
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            profileCollectionTable.collectionViewLayout = flowLayout
        
        }

        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemPath = profileCollectionTable.indexPathsForSelectedItems?.first
        let destinationView = segue.destination as! postView
        destinationView.index = itemPath
        destinationView.data = self.data
        destinationView.posts = self.posts
    }
    
    
    
    
    
}



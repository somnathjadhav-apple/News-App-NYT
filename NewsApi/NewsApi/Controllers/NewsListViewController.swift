//
//  NewsListViewController.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import UIKit

class NewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
   private var articlesListVM : ArticleListViewModel!
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    //for collectioView
    var articleListVCM = [Multimedia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        setup()
        
        createSearchBar()
    }
    
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }

    public func setup() {
        let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=0zIBMjkIwUOfsb04iNSHKKg4NVeWotSn")!
        let searchUrlString = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=0zIBMjkIwUOfsb04iNSHKKg4NVeWotSn&q="
        Webservices().getNewsAppData(url: url) { articles in
            if let articles = articles {
                self.articlesListVM = ArticleListViewModel(articles: articles)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.articlesListVM == nil ? 0 : self.articlesListVM.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesListVM.numberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArticleTVC else {
            fatalError("Cell Not Found")
        }
        let articleVM = self.articlesListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        
        let imgURL = URL.init(string: articleVM.url)
        let imageData = try? Data.init(contentsOf: imgURL!)
        cell.articleImage.image = UIImage.init(data: imageData!)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    // MARK: Search bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        print(text)
    }
    
    // MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCVC", for: indexPath) as! StoriesCVC
        
        let articleVM = self.articleListVCM[indexPath.row]//articleListVCM[indexPath.row]
        
        let imgURL = URL.init(string: articleVM.url)
        let imageData = try? Data.init(contentsOf: imgURL!)
        cell1.topStoriesImage.image = UIImage.init(data: imageData!)
        
        
        return cell1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleListVCM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

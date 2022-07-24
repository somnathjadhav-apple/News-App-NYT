//
//  NewsListViewController.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import UIKit

class NewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var pageView: UIPageControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var articlesListVM : ArticleListViewModel!
    
    private let cellReuseIdentifier = "collectionCell"
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    let searchUrlString = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=0zIBMjkIwUOfsb04iNSHKKg4NVeWotSn&q="
    
    //for collectioView
    var articleListVCM = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        collectionView.register(StoriesCVC.self , forCellWithReuseIdentifier: StoriesCVC.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        
        setup()
        setupCollection()
        collectiionViewUI1()
        createSearchBar()
    }
     var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    var layout : UICollectionViewLayout = UICollectionViewLayout()
    var articelImg = UIImageView()
    
    func collectiionViewUI1(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 195).isActive = true
        
        
    }

    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }

    public func setup() {
        let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=0zIBMjkIwUOfsb04iNSHKKg4NVeWotSn")!
        
        Webservices().getNewsAppData(url: url) { articles in
            if let articles = articles {
                self.articlesListVM = ArticleListViewModel(articles: articles)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    public func setupCollection() {
        let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=0zIBMjkIwUOfsb04iNSHKKg4NVeWotSn")!
        Webservices().getNewsAppData(url: url) { articles in
            if let userArticles = articles {
                self.articlesListVM = ArticleListViewModel(articles: userArticles)
                print(userArticles)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    
    // MARK: Search bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        let query = searchUrlString.appending(text)
        
        print("Search Tab Query: \(query)")
        
        Webservices().getNewsAppData(url: URL(string: query)!) { articles in
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
    
    
    
    // MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! StoriesCVC
        
        let articleVM = self.articlesListVM.articleAtIndex(indexPath.row)
        
        let imgURL = URL.init(string: articleVM.url)
        let imageData = try? Data.init(contentsOf: imgURL!)
        cell1.articelImg.image = UIImage.init(data: imageData!)
        
        
        return cell1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleListVCM.count
    }
    
}

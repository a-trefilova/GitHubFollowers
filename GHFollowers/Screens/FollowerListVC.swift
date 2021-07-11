//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Alyona Sabitskaya  on 11.06.2021.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { case main }

    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page: Int = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDiffableDatasource()
        getFollowers(username: username, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        collectionView.delegate = self
    }
    
    private func configureDiffableDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error",
                                                message: error.rawValue,
                                                buttonTitle: "Ok")
            }
        }
    }
    
}

extension FollowerListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

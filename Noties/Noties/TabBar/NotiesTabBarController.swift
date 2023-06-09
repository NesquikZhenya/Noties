//
//  NotiesTabBarController.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

final class NotiesTabBarController: UITabBarController {

    private var customTabBarView = UIView(frame: .zero)
                
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarUI()
        self.addCustomTabBarView()
        tabBar.tintColor = .white
        tabBar.barTintColor = .gray
        setupViewControllers()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "log out",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(logOutButtonDidTap))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCustomTabBarFrame()
    }
        
    private func setupCustomTabBarFrame() {
        let height = self.view.safeAreaInsets.bottom + 64
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - 80
        self.tabBar.frame = tabFrame
        customTabBarView.frame = tabBar.frame
    }
    
    private func setupTabBarUI() {
        self.tabBar.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        self.tabBar.layer.cornerRadius = 40
    }
    
    private func addCustomTabBarView() {
        self.customTabBarView.frame = tabBar.frame
        self.customTabBarView.layer.cornerRadius = 40
        self.view.addSubview(customTabBarView)
        self.view.bringSubviewToFront(self.tabBar)
    }
    
    private func createNavigationController(for rootViewController: UIViewController,title: String, image: UIImage?) -> UIViewController {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.tabBarItem.title = title
            navigationController.tabBarItem.image = image
            navigationController.navigationBar.prefersLargeTitles = true
            return navigationController
        }
    
    private func configureViewController(for viewController: UIViewController,title: String, image: UIImage?) -> UIViewController {
            viewController.tabBarItem.title = title
            viewController.tabBarItem.image = image
            return viewController
        }
    
    private func setupViewControllers() {
        let notesScreenViewController = NotesScreenViewController()
        let mapsScreenViewController = MapsScreenViewController()
        notesScreenViewController.delegate = mapsScreenViewController
          viewControllers = [
            configureViewController(for: notesScreenViewController, title: "Notes", image: UIImage(named: "notes")),
            configureViewController(for: mapsScreenViewController, title: "Map", image: UIImage(named: "map"))
          ]
      }
    
    func forUsername(username: String) -> NotiesTabBarController {
        UserDefaults.standard.set(username, forKey: "currentUser")
        return self
    }
    
    @objc private func logOutButtonDidTap() {
        UserDefaults.standard.removeObject(forKey: "savedUser")
        self.navigationController?.popViewController(animated: true)
    }

}

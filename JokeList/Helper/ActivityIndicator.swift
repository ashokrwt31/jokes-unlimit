//
//  ActivityIndicator.swift
//  JokeList
//
//  Created by Ashok Rawat on 09/06/23.
//

import UIKit

class ActivityIndicator {
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    func startIndicatorView( uiView: UIView,  style: UIActivityIndicatorView.Style = .large,  indicatorBgColor: UIColor = .lightGray,  loadingBgColor: UIColor = .white ) {
        
        loadingView.frame = CGRect(x: uiView.bounds.width / 2 - 20, y: uiView.bounds.height / 2 - 20, width: 40, height: 40)
        loadingView.backgroundColor = loadingBgColor
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = style
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        activityIndicator.color = indicatorBgColor
        
        loadingView.addSubview(activityIndicator)
        uiView.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    func hideIndicatorView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.loadingView.removeFromSuperview()
            self.container.removeFromSuperview()
        }
    }
}

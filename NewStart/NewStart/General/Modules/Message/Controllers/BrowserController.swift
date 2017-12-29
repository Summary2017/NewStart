//
//  BrowserController.swift
//  BBDTekManager
//
//  Created by  ZhuHong on 2017/9/28.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

import UIKit
import WebKit

class BrowserController: BaseController {
    /// 一个默认的
    var urlSTR:String = "https://www.jianshu.com/p/c0e611fc0548"

    // 网页
    lazy var browserView: WKWebView! = {
        let wkView = WKWebView(frame: self.view.bounds)
        wkView.navigationDelegate = self
        wkView.allowsBackForwardNavigationGestures = true
        
        wkView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return wkView
    }()
    
    // 进度条
    lazy var loadProgressView: UIProgressView! = {
        let iPhoneX = Public.isIPhoneX()
        var y = 64
        if iPhoneX {
            y = 88
        }
        
        let lazyProgress = UIProgressView(frame: CGRect(x: 0, y: y, width: Int(self.view.frame.width), height: 1))
        lazyProgress.progressTintColor = UIColor.purple
        lazyProgress.trackTintColor = UIColor.white
        lazyProgress.isHidden = true
        
        return lazyProgress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let t = title {
            print(t)
        } else {
            title = "网页加载中..."
        }
        
        view.addSubview(browserView)
        let url = NSURL(string: urlSTR)
        let request = NSURLRequest(url: url! as URL) as URLRequest
        browserView.load(request)
        
        view.addSubview(loadProgressView)
    }
    
    /// 监听到网页进度变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            self.loadProgressView.progress = Float(self.browserView.estimatedProgress)
        }
    }
    
    deinit {
        self.browserView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

// MARK: - WKNavigationDelegate
extension BrowserController: WKNavigationDelegate {
    
    /// 准备加载网页
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // loadProgress()
        self.loadProgressView.isHidden = false
        
    }
    
    /// 开始加载网页
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

    }
    
    /// 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        
        self.loadProgressView.isHidden = true
        self.loadProgressView.progress = 0
    }
    
    /// 加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        title = "网页加载失败..."
        self.loadProgressView.isHidden = true
        self.loadProgressView.progress = 0
    }
}

//
//  WebViewViewController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/11/10.
//  Copyright © 2018年 田辺信之. All rights reserved.
//
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    var urlString: String?
    private var _observers = [NSKeyValueObservation]()
    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progressTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        // UIProgressViewの実装
        _observers.append(webView.observe(\.estimatedProgress, options: .new) {_, _ in
            self.progressView.progress = Float(self.webView.estimatedProgress)
        })
        [progressView].forEach { self.view.addSubview($0) }
        progressView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        progressView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        guard let string = urlString else {
            return
        }
        let myURL = URL(string: string)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // Scrollに必要なproperty
    var beginingPoint: CGPoint!
    var isViewShowed: Bool!
    @IBOutlet weak var headerHeightContstraint: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        do {
            // scrollViewに関する初期化のためのスコープ
            isViewShowed = false
            beginingPoint = CGPoint(x: 0, y: 0)
            webView.scrollView.delegate = self
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        isViewShowed = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        titleLabel.text = webView.title
        self.hideProgressView()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgressView()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideProgressView()
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @IBAction func tapShareButton(_ sender: Any) {
        guard let urlString = urlString else { return }
        let shareWebsite = NSURL(string: urlString)!
        let shareText = webView.title!
        let activityItems = [shareText, shareWebsite] as [Any]
        let activity = UIActivityViewController(activityItems: activityItems, applicationActivities: [ShareEntryActivity()])
        self.present(activity, animated: true, completion: nil)
    }

}

extension WebViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginingPoint = scrollView.contentOffset
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPoint = scrollView.contentOffset
        let contentSize = scrollView.contentSize
        let frameSize = scrollView.frame
        let maxOffSet = contentSize.height - frameSize.height

        if currentPoint.y >= maxOffSet {
            // print("hit the bottom")
        } else if beginingPoint.y < currentPoint.y {
            // print("Scrolled down")
            self.headerHeightContstraint.constant = 0.0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            // print("Scrolled up")
            self.headerHeightContstraint.constant = 44.4
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension WebViewController {

    func showProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }

    func hideProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0
        }, completion: nil)
    }
}

//
//  PhotoViewController.swift
//  PhotoViewer
//
//  Created by Tuhin Kumar on 11/10/14.
//  Copyright (c) 2014 Eunoia. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var photoActions: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
        var alpha = 1 - abs(scrollView.contentOffset.y) / 100
        self.view.backgroundColor = UIColor(white: 0, alpha: alpha)
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        doneButton.alpha = 0
        photoActions.alpha = 0
        
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            
            if abs(scrollView.contentOffset.y) > 100 {
                dismissViewControllerAnimated(true, completion: nil)
            }

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
        doneButton.alpha = 1
        photoActions.alpha = 1
        self.view.backgroundColor = UIColor(white: 0, alpha: 1)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

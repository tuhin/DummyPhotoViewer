//
//  FeedViewController.swift
//  PhotoViewer
//
//  Created by Tuhin Kumar on 11/10/14.
//  Copyright (c) 2014 Eunoia. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    var selectedImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = feedImageView.image!.size
        scrollView.contentInset.bottom = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {
        
        var tappedImage = sender.view as UIImageView
        selectedImage = tappedImage
        
        performSegueWithIdentifier("photoModal", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        var destinationViewController = segue.destinationViewController as PhotoViewController
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
        destinationViewController.image = selectedImage.image
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")

        
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            
            var animatingImage = UIImageView(frame: self.selectedImage.frame)
            animatingImage.contentMode = self.selectedImage.contentMode
            animatingImage.clipsToBounds = self.selectedImage.clipsToBounds
            animatingImage.image = self.selectedImage.image
            
            selectedImage.hidden = true
            
            var window = UIApplication.sharedApplication().keyWindow
            window?.addSubview(animatingImage)
            
            var photoDetailViewController = toViewController as PhotoViewController
            containerView.addSubview(toViewController.view)
            
            toViewController.view.alpha = 0
            toViewController.view.backgroundColor = UIColor(white: 0, alpha: 1)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                photoDetailViewController.imageView.hidden = true
                animatingImage.frame = photoDetailViewController.imageView.frame
                animatingImage.contentMode = photoDetailViewController.imageView.contentMode
                
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    photoDetailViewController.imageView.hidden = false
                    animatingImage.hidden = true
                    animatingImage.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        } else {
            var photoDetailViewController = fromViewController as PhotoViewController
            var animatingImage = UIImageView(frame: photoDetailViewController.imageView.frame)
            
            selectedImage.hidden = true
            
            var window = UIApplication.sharedApplication().keyWindow
            window?.addSubview(animatingImage)
            
            
            animatingImage.frame = photoDetailViewController.imageView.frame
            animatingImage.contentMode = photoDetailViewController.imageView.contentMode
            animatingImage.image = photoDetailViewController.imageView.image
            
            animatingImage.hidden = false
            photoDetailViewController.imageView.hidden = true
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.backgroundColor = UIColor(white: 0, alpha: 1)
                fromViewController.view.alpha = 0
                animatingImage.frame = self.selectedImage.frame
                animatingImage.contentMode = self.selectedImage.contentMode
                
                }) { (finished: Bool) -> Void in
                    self.selectedImage.hidden = false
                    animatingImage.hidden = true
                    animatingImage.removeFromSuperview()
                    fromViewController.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        }
    }

}

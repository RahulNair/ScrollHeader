//
//  ViewController.swift
//  testScroll
//
//  Created by Prasanna Pegu on 11/04/16.
//  Copyright © 2016 Prasanna Pegu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout
, UICollectionViewDelegate,UICollectionViewDataSource {

	
	@IBOutlet weak var headerCollection: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
	
    
    var headerSelectedIndex:NSIndexPath!
    var willDisplayCellIndex: NSIndexPath!
    var movedByTapAction:Bool!
	let movieList = ["Hobbit","Dracula","X-Men","Iron Man","DeadPool","Batman vs SuperMan", "Fast & Furious 7" ]
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        movedByTapAction = false
        headerSelectedIndex = NSIndexPath(forRow: 0, inSection: 0)

		headerCollection.registerNib(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myHeaderID")
        bottomCollectionView.registerNib(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myBottomCellID")
        
        self.bottomCollectionView.pagingEnabled = true


		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
 // MARK: UICollectionViewDelegateFlowLayout
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(collectionView == headerCollection){
            return CGSizeMake(collectionView.frame.width/2.5, collectionView.frame.height);
        }else{
            return CGSizeMake(collectionView.frame.width, collectionView.frame.height);
        }
       
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 0;
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 1;
	}

	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movieList.count
	}
    
    // MARK: - CollectionView
    

    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
          if(collectionView == self.bottomCollectionView && movedByTapAction == false){
            
               // print("=====**********|forItemAtIndexPath|*******\(indexPath.row)*********|headerSelectedIndex|***\(headerSelectedIndex.row)********* new cell   ********************|willDisplayrow|******** \(willDisplayCellIndex.row) ")
            
                    if( headerCollection.cellForItemAtIndexPath(willDisplayCellIndex) != nil){

                     let headerCell : HeaderCollectionViewCell =   headerCollection.cellForItemAtIndexPath(willDisplayCellIndex) as! HeaderCollectionViewCell
                        headerCell.bottomBar.hidden = false
                    }
            
                    if( headerCollection.cellForItemAtIndexPath(indexPath) != nil){
                    
                        let headerPreviousCell : HeaderCollectionViewCell =   headerCollection.cellForItemAtIndexPath(indexPath) as! HeaderCollectionViewCell
                    
                        headerPreviousCell.bottomBar.hidden = true
                    }
                
            
                    self.headerCollection.scrollToItemAtIndexPath(willDisplayCellIndex, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
                
                
                
                    headerSelectedIndex = willDisplayCellIndex

            
          }else if (movedByTapAction == true){
            
           //  print("======movedByTapAction set true****|forItemAtIndexPath|*******\(indexPath.row)*******|headerSelectedIndex|******** \(headerSelectedIndex.row) ")
           
            if(willDisplayCellIndex.row == headerSelectedIndex.row){
                movedByTapAction = false

            }
            
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
       
        willDisplayCellIndex = indexPath
        
        
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(collectionView == self.headerCollection){
        
            
            movedByTapAction = true
            
            
            let headerSelectedCell : HeaderCollectionViewCell =   headerCollection.cellForItemAtIndexPath(indexPath) as! HeaderCollectionViewCell
            headerSelectedCell.bottomBar.hidden = false
            
          
            
    
            if( headerCollection.cellForItemAtIndexPath(headerSelectedIndex) != nil){
                let headerPreviousCell : HeaderCollectionViewCell =   headerCollection.cellForItemAtIndexPath(headerSelectedIndex) as! HeaderCollectionViewCell
                headerPreviousCell.bottomBar.hidden = true
            }
           
            
            
            self.bottomCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            
            
            headerSelectedIndex = indexPath


        }
    }
    
    
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.headerCollection {
            let headerCell : HeaderCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("myHeaderID", forIndexPath: indexPath) as! HeaderCollectionViewCell
            
            if(headerSelectedIndex.row != indexPath.row){
                headerCell.bottomBar.hidden = true
            }else{
                headerCell.bottomBar.hidden = false
            }
            
            
            headerCell.headerTitle.text = movieList[indexPath.row] as String  //"\(indexPath.row)"

            return headerCell
        }
            
        else {
            let bottomContentCell: BottomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("myBottomCellID", forIndexPath: indexPath) as! BottomCollectionViewCell
            
            
            
            bottomContentCell.movieImageView.image = UIImage(named: "h\(indexPath.row)")
            
            return bottomContentCell
        }
	}
    
    

}


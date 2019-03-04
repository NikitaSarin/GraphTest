//
//  GraphTableViewCell.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

class GraphTableViewCell: UITableViewCell {

    @IBOutlet private var graphView: GraphView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet var lineTypeControl: UISegmentedControl!
    
    private let maximumZoomScale: CGFloat = 5.0
    var viewmodel: GraphCellViewModel?{
        didSet{
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    func updateUI(){
        guard let viewmodel = viewmodel else {
            return
        }
        graphView.lineType = viewmodel.defultLineType
        graphView.points = viewmodel.normalizedPoints
        scrollView.maximumZoomScale = maximumZoomScale
        
        lineTypeControl.removeAllSegments()
        for i in 0..<viewmodel.lineTypes.count {
            lineTypeControl.insertSegment(withTitle: viewmodel.lineTypes[i].name, at: i, animated: false)
            if viewmodel.lineTypes[i] == viewmodel.defultLineType{
                lineTypeControl.selectedSegmentIndex = i
            }
        }
    }
    
    @IBAction func lineTypeControlDidChageValue(_ sender: Any) {
        guard let viewmodel = viewmodel else {
            return
        }
        graphView.lineType = viewmodel.lineTypes[lineTypeControl.selectedSegmentIndex]
    }
    
}

extension GraphTableViewCell: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return graphView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        graphView.zoom(to: scrollView.zoomScale)
    }
}

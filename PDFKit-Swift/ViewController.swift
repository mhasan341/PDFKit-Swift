//
//  ViewController.swift
//  PDFKit-Swift
//
//  Created by Mahmudul Hasan on 2023-08-24.
//

import UIKit
import PDFKit

class ViewController: UIViewController {


    let pdfView = PDFView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(pdfView)
        pdfView.frame = view.bounds

        loadPDF()
    }

    // in an actual scenario we could fetch from device/network whatever
    func loadPDF(){
        guard let path = Bundle.main.path(forResource: "MM_Latest", ofType: "pdf") else {return}

        let url:URL

        if #available(iOS 16.0, *) {
            url = URL(filePath: path)
        } else {
            // Fallback on earlier versions
            url = URL(fileURLWithPath: path)
        }

        guard let pdfDocument = PDFDocument(url: url) else {return}
        pdfView.document = pdfDocument
        pdfView.autoScales = true
    }
}


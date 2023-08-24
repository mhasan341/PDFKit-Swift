//
//  ViewController.swift
//  PDFKit-Swift
//
//  Created by Mahmudul Hasan on 2023-08-24.
//

import UIKit
import PDFKit
import UniformTypeIdentifiers

class ViewController: UIViewController, UIDocumentPickerDelegate, UINavigationControllerDelegate{


    let pdfView = PDFView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        let picker = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(openDocumentPicker))
        navigationItem.rightBarButtonItem = picker

        title = "PDFKit"

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

    @objc func openDocumentPicker(){
        let docPicker: UIDocumentPickerViewController
        let pdfType = "com.adobe.pdf"

        if #available(iOS 14.0, *){
            let docTypes = UTType.types(tag: "pdf", tagClass: UTTagClass.filenameExtension, conformingTo: nil)
            docPicker = UIDocumentPickerViewController(forOpeningContentTypes: docTypes)
        } else {
            docPicker = UIDocumentPickerViewController(documentTypes: [pdfType], in: .import)
        }

        docPicker.delegate = self
        present(docPicker, animated: true)

    }
}


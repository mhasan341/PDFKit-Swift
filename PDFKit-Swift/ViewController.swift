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
        // Do any additional setup after loading the view

        let picker = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(openDocumentPicker))
        navigationItem.rightBarButtonItem = picker

        title = "PDFKit"

        view.addSubview(pdfView)
        pdfView.frame = view.bounds

    }

    // load the pdf from url
    func loadPDF(_ url: URL){
        let pdfDocument = PDFDocument(url: url)
        pdfView.document = pdfDocument
        pdfView.autoScales = true
    }

    @objc func openDocumentPicker(){
        let docPicker: UIDocumentPickerViewController
        let pdfType = "com.adobe.pdf"

        if #available(iOS 14.0, *){
            let docTypes = UTType.types(tag: "pdf", tagClass: UTTagClass.filenameExtension, conformingTo: nil)
            docPicker = UIDocumentPickerViewController(forOpeningContentTypes: docTypes, asCopy: true)
        } else {
            docPicker = UIDocumentPickerViewController(documentTypes: [pdfType], in: .import)
        }

        docPicker.delegate = self
        present(docPicker, animated: true)

    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {return}
        loadPDF(url)
    }
}


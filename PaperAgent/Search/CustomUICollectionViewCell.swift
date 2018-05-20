import UIKit

class CustomUICollectionViewCell : UICollectionViewCell{
    
    var titleLabel : UILabel?;
    var detailLabel : UILabel?;
    var row : Int = -1;
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setTitle(title : String){
        titleLabel?.text = title;
        
    }
    
    func setDetail(detail : NSAttributedString){
        detailLabel?.attributedText = detail;
        detailLabel?.numberOfLines = 0;
        detailLabel?.sizeToFit();
    }
    
    func setRow(row_ : Int){
        row = row_;
    }
    
    func resize(){
//        let size = detailLabel?.sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude));
//        self.frame = CGRect(x:4, y:4, width:self.frame.width - 4, height:(60 + (size?.height)!))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UILabelを生成.
        titleLabel = UILabel(frame: CGRect(x:4, y:4, width:frame.width - 4, height:40))
        titleLabel?.text = "nil"
        titleLabel?.backgroundColor = UIColor.white
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel?.numberOfLines = 3
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        detailLabel = UILabel(frame: CGRect(x:6, y:50, width:frame.width - 10, height:80))
        detailLabel?.text = "nil"
        detailLabel?.backgroundColor = UIColor.white
        detailLabel?.textAlignment = NSTextAlignment.left
        detailLabel?.font = UIFont.systemFont(ofSize: 10.0)
        detailLabel?.numberOfLines = 0
        detailLabel?.lineBreakMode = NSLineBreakMode.byCharWrapping
//        detailLabel?.backgroundColor = UIColor.black

        
        titleLabel?.isOpaque = false;
        detailLabel?.isOpaque = false;
        titleLabel?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0);
        detailLabel?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0);
        // Cellに追加.
        self.contentView.addSubview(titleLabel!)
        self.contentView.addSubview(detailLabel!)
    }
    
    func setDarker(){
        self.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 247 / 255, alpha: 1)
//        titleLabel?.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 247 / 255, alpha: 1)
//        detailLabel?.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 247 / 255, alpha: 1)
    }
    
    func setLighter(){
        self.backgroundColor = UIColor.white
//        titleLabel?.backgroundColor = UIColor.white
//        detailLabel?.backgroundColor = UIColor.white
    }
    
}

extension String {
    func htmlToAttributedString(family: String?, size: CGFloat) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

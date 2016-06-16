import UIKit

let kHorizontalActionSeparator = "horizontal"
let kVerticalActionSeparator = "vertical"

final class ActionsCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var visualStyle: VisualStyle?

    override class func layoutAttributesClass() -> AnyClass {
        return ActionsCollectionViewLayoutAttributes.self
    }

    override init() {
        super.init()
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElementsInRect(rect) else { return nil }

        var mutableAttributes = attributes

        for attribute in attributes {
            if let horizontalAttributes = layoutAttributesForDecorationViewOfKind(kHorizontalActionSeparator,
                atIndexPath: attribute.indexPath)
            {
                mutableAttributes.append(horizontalAttributes)
            }

            if self.scrollDirection == .Horizontal && attribute.indexPath.item > 0,
                let verticalAttributes = layoutAttributesForDecorationViewOfKind(kVerticalActionSeparator,
                atIndexPath: attribute.indexPath)
            {
                mutableAttributes.append(verticalAttributes)
            }
        }

        return mutableAttributes
    }

    override func layoutAttributesForDecorationViewOfKind(elementKind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?
    {
        let attributes = ActionsCollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind,
            withIndexPath: indexPath)
        guard let itemAttributes = layoutAttributesForItemAtIndexPath(indexPath) else { return nil }

        attributes.zIndex = itemAttributes.zIndex + 1
        attributes.backgroundColor = self.visualStyle?.actionViewSeparatorColor

        var decorationViewFrame = itemAttributes.frame
        if elementKind == kHorizontalActionSeparator {
            decorationViewFrame.size.height = self.visualStyle?.actionViewSeparatorThickness ?? 0.5
        } else {
            decorationViewFrame.size.width = self.visualStyle?.actionViewSeparatorThickness ?? 0.5
        }

        attributes.frame = decorationViewFrame
        return attributes
    }
}

class ActionsCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var backgroundColor: UIColor?
}

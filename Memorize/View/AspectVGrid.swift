//
//  LazyAspectVGrid.swift
//  Memorize
//
//  Created by Kirill Pukhov on 24.06.21.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let width = calcMinWidth(itemsCount: items.count, aspectRatio: aspectRatio, size: geometry.size)
            
            LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func calcMinWidth(itemsCount: Int, aspectRatio: CGFloat, size: CGSize) -> CGFloat {
        var collumnsCount = 1
        var rowCount = itemsCount
        repeat {
            let itemWidth: CGFloat = size.width / CGFloat(collumnsCount)
            let itemHeight: CGFloat = itemWidth / aspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            collumnsCount += 1
            rowCount = (itemsCount + (collumnsCount - 1)) / collumnsCount
        } while collumnsCount < itemsCount
        if collumnsCount == itemsCount {
            collumnsCount = itemsCount
        }
        return floor(size.width / CGFloat(collumnsCount))
    }
    
    init(items: [Item], aspectRatio: CGFloat = 1.0, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
}

//struct LazyAspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        LazyAspectVGrid()
//    }
//}

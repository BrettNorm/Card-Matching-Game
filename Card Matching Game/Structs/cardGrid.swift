//
//  AspectVGrid.swift
//  Card Matching Game
//
//  Created by Brett Bax on 11/6/21.
//

import SwiftUI

struct cardGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var grid: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder grid: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.grid = grid
    }
    
    
    
    private func widthThatFits(numItems: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columns = 1
        var rows = numItems
        repeat {
            let width = size.width / CGFloat(columns)
            let height = width / itemAspectRatio
            if CGFloat(rows) * height < size.height {
                break
            }
            columns += 1
            rows = (numItems + (columns - 1 )) / columns
        } while numItems > columns
        if columns > numItems {
            columns = numItems
        }
        return floor(size.width / CGFloat(columns))
    }
    
    
    
    private func adaptingItems(width: CGFloat) -> GridItem {
        var item = GridItem(.adaptive(minimum: width))
        item.spacing = 0
        return item
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                let width: CGFloat =  widthThatFits(numItems: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptingItems(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        grid(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer( minLength: 0 )
            }
        }
    }
    
    
}

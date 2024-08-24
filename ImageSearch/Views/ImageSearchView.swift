//
//  Created by Chen on 8/24/24.
//

import SwiftUI

struct ImageSearchView: View {
    @State private var searchText = ""

    private let gridItems = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            Text("Here are the recent uploads taged \(searchText)")
                .navigationTitle("Images Search")
            LazyVGrid(columns: gridItems) {
                ForEach(["A", "B", "C"], id: \.self) { _ in
                    AsyncImage(url: URL(string: "https://live.staticflickr.com/65535/53944142466_90ea132ed5_m.jpg")) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding()
            }
        }
        .searchable(text: $searchText)
    }
}

struct ImageSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSearchView()
    }
}

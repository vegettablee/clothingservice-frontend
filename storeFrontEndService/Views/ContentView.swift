import SwiftUI

// New component for horizontal scrolling section with placeholder items

struct StoreInfoTemplateView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                // Section 1: Placeholder for store information header
                Text("Pick one or more categories...")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                
                // add category section
                CategoryButtonsView()
                    .frame(maxWidth: .infinity)
                    

                // Section 2: Horizontal scrolling placeholder component
                Text("Nearby Stores")

                
                HorizontalPlaceholderSection()

                // Section 3: Another horizontal scrolling placeholder component
                Text("Top Rated Stores")
                HorizontalPlaceholderSection()
                
                Spacer()
                
               /* HorizontalItemsView()
                    .frame(width: UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.04)
                    .padding(.vertical, 12)
                    .background(Color(.systemBackground).shadow(radius: 2))
                    .ignoresSafeArea(edges: .bottom) */
                
                          
            }
            .padding()
            HorizontalItemsView()

            
            

            // Bottom Navigation Bar, flush to screen bottom
    
            //    .clipped()
            
            
        }
        
    }
}

struct StoreInfoTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        StoreInfoTemplateView()
    }
}

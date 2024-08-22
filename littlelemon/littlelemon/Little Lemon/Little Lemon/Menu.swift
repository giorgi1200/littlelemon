import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var menuItems: [MenuItem] = []
    @State private var searchText: String = "" // Add search text state

    var filteredMenuItems: [MenuItem] {
        if searchText.isEmpty {
            return menuItems
        } else {
            return menuItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            Text("Little Lemon")
                .font(.largeTitle)
                .padding()
            
            Text("Chicago")
                .font(.title2)
                .padding(.bottom)
            
            Text("Delicious food made with love")
                .font(.body)
                .padding(.bottom)
            
            // Add the search field here
            TextField("Search menu", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            List(filteredMenuItems, id: \.id) { item in
                HStack {
                    if let imageUrl = URL(string: item.image ?? "") {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100) // Adjust size as needed
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                    } else {
                        Text("No Image")
                            .frame(width: 100, height: 100)
                    }

                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.description)
                            .font(.subheadline)
                        Text("Price: \(item.price)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    private func getMenuData() {
        // Clear the existing data
        PersistenceController.shared.clear()
        
        // Define the server URL
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                // Decode the data to MenuResponse
                if let decodedResponse = try? decoder.decode(MenuResponse.self, from: data) {
                    // Access the menu items
                    let menuItems = decodedResponse.menu
                    
                    // Convert and save the menu items
                    for item in menuItems {
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.image = item.image
                        dish.price = item.price
                        
                        // Save the context
                        do {
                            try viewContext.save()
                        } catch {
                            // Handle the error
                            print("Failed to save dish: \(error)")
                        }
                    }
                    
                    // Update the state variable
                    DispatchQueue.main.async {
                        self.menuItems = menuItems.sorted(by: { $0.title < $1.title }) // Sort items by title
                    }
                }
            }
        }
        task.resume()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true)]
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

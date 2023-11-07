//
//  VocBoxWidgets.swift
//  VocBoxWidgets
//
//  Created by Jessie Pastan on 11/1/23.
//

import WidgetKit
import SwiftUI
import CoreData


struct Provider: TimelineProvider {
   
    
    var randomVocab: Vocab {
        let vocab = self.fetchDataFromCoreData()
            return vocab
        }
    
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(), vocab: randomVocab)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), vocab: randomVocab)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, vocab: randomVocab)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    // Function to fetch data from Core Data
        private func fetchDataFromCoreData() -> Vocab {
            var items: [Vocab] = []
            
            let managedObjectContext = CoreDataController.shared.container.viewContext
            let fetchRequest: NSFetchRequest<Vocab> = Vocab.fetchRequest()
            do{
                items = try managedObjectContext.fetch(fetchRequest)
            }catch {
                print("Debug: \(error.localizedDescription)")
            }
            
            return items.randomElement() ?? Vocab(context: managedObjectContext)
        }
        
    
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let vocab: Vocab
}

struct VocBoxWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        ZStack{
            ContainerRelativeShape()
                .fill(Color("WidgetBackground"))
            VStack {
                VStack{
                    Text(entry.vocab.vocab ?? "Vocab")
                    Text("(\(entry.vocab.type ?? "type"))")
                }
               
                .font(.custom("PlayfairDisplayRoman-SemiBold", size: 18))
                
                Text(entry.vocab.definition ?? "Widget definition" )
            }
            .foregroundColor(.black)
           
            
        }
        
        
    }
}

struct VocBoxWidgets: Widget {
    let kind: String = "VocBoxWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
         
            if #available(iOS 17.0, *) {
                VocBoxWidgetsEntryView(entry: entry)
                    .containerBackground(Color("WidgetBackground"), for: .widget)
            } else {
                VocBoxWidgetsEntryView(entry: entry)
                    .background()
            }
            
            
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

/*
#Preview(as: .systemSmall) {
    VocBoxWidgets()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩" )
}
*/

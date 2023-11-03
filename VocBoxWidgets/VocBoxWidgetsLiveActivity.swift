//
//  VocBoxWidgetsLiveActivity.swift
//  VocBoxWidgets
//
//  Created by Jessie Pastan on 11/1/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct VocBoxWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct VocBoxWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: VocBoxWidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension VocBoxWidgetsAttributes {
    fileprivate static var preview: VocBoxWidgetsAttributes {
        VocBoxWidgetsAttributes(name: "World")
    }
}

extension VocBoxWidgetsAttributes.ContentState {
    fileprivate static var smiley: VocBoxWidgetsAttributes.ContentState {
        VocBoxWidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: VocBoxWidgetsAttributes.ContentState {
         VocBoxWidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: VocBoxWidgetsAttributes.preview) {
   VocBoxWidgetsLiveActivity()
} contentStates: {
    VocBoxWidgetsAttributes.ContentState.smiley
    VocBoxWidgetsAttributes.ContentState.starEyes
}

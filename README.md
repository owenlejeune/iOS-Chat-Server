# iOS Chat Server
A simple chat server using the websocket library [Starscream](https://github.com/daltoniam/Starscream)

### Developer Information
* Owen LeJeune
* 101034825

### Usage and Tesing
1. Start the node server from the Chat Server Nodejs with Websockets directory
2. Navigate to http://localhost:3000 in the browser to launch the web client
3. Open the ChatServer.xcworkspace file from the ChatServer directory
    * ensure it is the .xcworkspace file and NOT the .xcodeproj; using the .xcworkspace file will make sure the project has access to the Pods dependencies at build time
4. Start the app on a simulator device
5. To connect to the server, toggle the Segmented Control to Connect
    * the server URL is hardcoded so it could connect automatically
    * once connected, an incoming message will inform you
6. Send messages from the bowser or iOS client and watch as they appear on the other

### Enhancements
1. Clear button to empty current contents of message history
2. Text input area and send button will shift up and down the screen when the on-screen keyboard activates and deactivates

### Resources
https://github.com/daltoniam/Starscream
https://www.raywenderlich.com/143874/websockets-ios-starscream
https://guides.cocoapods.org/using/using-cocoapods.html

# Tracker #

Please open the project using Tracker.xcworkspace.

### What is this repository for? ###

* The J&J software engineering garage is looking for a way to keep track of testing devices. The goal of this challenge is to create an app that connects to a **mock** web server and performs GET and POST requests. The app must also be able to function offline and sync any offline data when it comes back online.

* This is by no means a complete solution, rather a rushed solution! But it reflects the patterns that I adopt and should provide an idea regarding my approach and my decision making.

### Functionality ###
** Screen 1: Home Page: ** This page will show a list of all the devices. Clicking on a device will bring the user to Screen 2 which shows the device details. Clicking on "Add Device" will bring the user to Screen 3 which allows them to add a new device. A user must be able to delete any device by swiping on it and tapping the delete button. You must provide a confirmation alert that the user would like to delete the device.

** Screen 2: Device Detail Page: ** This page will show the details of a specific device. If the device is currently checked out, the button should allow a user to check it back in using the "Check In" button. If the device is currenly checked in, the button should instead be labeled "Check Out" and allow the user to check out the device. After pressing "Check Out", there should be an alert popup asking the user to enter their name. After completing check in or check out, the page should refresh to reflect the new state of the device.

** Screen 3: Add Device Page: **
This page will allow the user to add a new device. All fields on this page are required. If the user presses "Cancel" with some information filled in, please confirm they wish to lose all entered data. Pressing "Save" should verify there is information for all 3 fields, add the device, and return the user to the home page.

### Endpoints ###

Base URL: http://private-1cc0f-devicecheckout.apiary-mock.com
*NOTE: This is a mock API. That means any requests to add or modify devices will not be reflected in later responses.*

**GET /devices:** Gets a list of all devices.

**POST /devices:** Adds a new device

**POST /devices/{device_id}:** Updates an existing device. Replace {device_id} with the id of the device.

**DELETE /devices/{device_id}:** Deletes a device. Replace {device_id} with the id of the device you wish to delete.


### Offline Requirements ###

The app must remain functional when the user does not have an internet connection. In order to accomplish this, you will need to implement a data storage mechanism. You are free to choose whatever data storage you feel would best suit this project. Upon reconnection to a network, the app must upload any devices created or modified while offline and fetch the latest set of devices from the backend.



### Architecture ###


** NETWORKING **
Networking uses Alamofire. There are 3 layers that distribute the networking workload:

1. **DeviceEndpoint:** enum with a separate case for each device backend call
2. **DeviceRouter:** adopts the URLRequestConvertible protocol. This is in charge of building the URLRequest for the device API calls from the individual components. It holds a reference to the device endpoint enum
3. **DeviceManager:** will make the actual Alamofire network calls and will handle the response
4. **Device model:** represents a Device object. Implements NSCoding protocol to allow for persistence using NSArchiving. Also implements ResponseObjectSerializable and ResponseCollectionSerializable protocols.
5. **Generic Response serialisers:** ResponseObjectSerializable and ResponseCollectionSerializable. When adopted, these protocols provide automatic, type-safe response object serialization into corresponding objects and array of objects respectively.



** PERSISTENCE **
Storage was implemented using NSArchiving.
Device model adopts the NSCoding protocol. This capability provides the basis for archiving.

Persistence is handled by the **StorageManager** object

Stored devices are stored in a "devices" file within the app's Documents directory in the app sandbox.

Deleted devices are stored in a "deleted" file within the app's Documents directory in the app sandbox.


** SYNC **

Synchronisation is triggered by the reachability manager, in the app delegate, detecting that the host is now reachable.

When an object is created or edited, the syncStatus field is changed to reflect the need to have it synchronised.

On the next sync cycle, all stored objects are inspected.
SyncEngine will go through the list of devices stored on disk, check for the objects flagged either as created or updated, and then will attempt issue create/update requests to the backend. 

If api call is successful, the sync flag is cleared, and the object is persisted in its new state.

Deletion is handled differently where deleted objects are stored in a separate file. But the SyncEngine will deal with these objects the same way, calling the backend, and when successful removing the objects from the data store.


### Setup ###

* Developed using XCode 8.1 

* Written in Swift 3 

* Tested on iPhone 6 running iOS 9.3.5 and iPhone 5S running iOS 10.1.1 

* Runs on iOS 8.0 and higher 

* Uses size classes and auto layout to support all iPhone screen sizes



### Dependencies ###

1. Alamofire 4.2

2. Commons (https://github.com/mdermejian/Commons.git

3. SwiftCommons (https://github.com/mdermejian/SwiftCommons.git)
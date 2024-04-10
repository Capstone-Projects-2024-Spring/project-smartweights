# CloudKit

## Introduction

This provides documentation for CloudKit Database

## Class CloudKitManager

### Class Description

The `CloudKitManager` class provides methods for connecting to CloudKit and CRUD functions.

#### Data Fields

- `shared`
    - **Type:** CloudKitManager
    - **Purpose:** Singleton instance of the CloudKitManager class.

- `container`
    - **Type:** CKContainer
    - **Purpose:** Instance of CKContainer used for CloudKit operations.

- `publicDatabase`
    - **Type:** CKDatabase
    - **Purpose:** Instance of CKDatabase representing the public CloudKit database.

- `privateDatabase`
    - **Type:** CKDatabase
    - **Purpose:** Instance of CKDatabase representing the private CloudKit database.

- `isSignedInToiCloud`
    - **Type:** Bool
    - **Purpose:** Indicates whether the user is signed in to iCloud.

- `error`
    - **Type:** String
    - **Purpose:** Holds error messages related to iCloud account status.


#### Methods
Saving with CloudKit operates as both the *Create* and *Update* functions.

- `init()`
    - **Purpose:** Initializes the CloudKitManager singleton instance.
    - **Pre-conditions:** None
    - **Post-conditions:** CloudKitManager instance is initialized with default container and databases.
    - **Parameters:** None
    - **Return Value:** Void
    - **Exceptions Thrown:** None

- `saveItem(record: CKRecord)`
    - **Purpose:** Saves a record to the public CloudKit database.
    - **Pre-conditions:** CloudKitManager is initialized.
    - **Post-conditions:** Record is saved to the public CloudKit database.
    - **Parameters:** 
        - `record`: CKRecord - The record to be saved.
    - **Return Value:** Void
    - **Exceptions Thrown:** None

- `savePrivateItem(record: CKRecord)`
    - **Purpose:** Saves a record to the private CloudKit database.
    - **Pre-conditions:** CloudKitManager is initialized.
    - **Post-conditions:** Record is saved to the private CloudKit database.
    - **Parameters:** 
        - `record`: CKRecord - The record to be saved.
    - **Return Value:** Void
    - **Exceptions Thrown:** None

- `fetchRecord(recordType: String, user: CKRecord.Reference, completion: @escaping ([CKRecord]?, Error?) -> Void)`
    - **Purpose:** Fetches records from the private CloudKit database based on a user reference.
    - **Pre-conditions:** CloudKitManager is initialized.
    - **Post-conditions:** Records are fetched from the private CloudKit database.
    - **Parameters:** 
        - `recordType`: String - The type of record to fetch.
        - `user`: CKRecord.Reference - The user reference used for querying.
        - `completion`: ([CKRecord]?, Error?) -> Void - A closure to be executed upon completion of the fetch operation.
    - **Return Value:** Void
    - **Exceptions Thrown:** None

- `fetchPrivateItem(recordType: String, user: CKRecord.Reference, completion: @escaping (CKRecord?, Error?) -> Void)`
    - **Purpose:** Fetches a single record from the private CloudKit database based on a user reference.
    - **Pre-conditions:** CloudKitManager is initialized.
    - **Post-conditions:** Record is fetched from the private CloudKit database.
    - **Parameters:** 
        - `recordType`: String - The type of record to fetch.
        - `user`: CKRecord.Reference - The user reference used for querying.
        - `completion`: (CKRecord?, Error?) -> Void - A closure to be executed upon completion of the fetch operation.
    - **Return Value:** Void
    - **Exceptions Thrown:** None

- `deleteItem(record: CKRecord)`
    - **Purpose:** Deletes a record from the public CloudKit database.
    - **Pre-conditions:** CloudKitManager is initialized.
    - **Post-conditions:** Record is deleted from the public CloudKit database.
    - **Parameters:** 
        - `record`: CKRecord - The record to be deleted.
    - **Return Value:** Void
    - **Exceptions Thrown:** None

- `deletePrivateItem(record: CKRecord)`
    - **Purpose:** Deletes a record from the private CloudKit database.
    - **Pre-conditions:** CloudKitManager is initialized.
    - **Post-conditions:** Record is deleted from the private CloudKit database.
    - **Parameters:** 
        - `record`: CKRecord - The record to be deleted.
    - **Return Value:** Void
    - **Exceptions Thrown:** None





# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries
This connector does not contain any queries.
## Mutations

### CreateUser
#### Required Arguments
```dart
String username = ...;
String email = ...;
String phone = ...;
String role = ...;
String passwordHash = ...;
ExampleConnector.instance.createUser(
  username: username,
  email: email,
  phone: phone,
  role: role,
  passwordHash: passwordHash,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createUser(
  username: username,
  email: email,
  phone: phone,
  role: role,
  passwordHash: passwordHash,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String username = ...;
String email = ...;
String phone = ...;
String role = ...;
String passwordHash = ...;

final ref = ExampleConnector.instance.createUser(
  username: username,
  email: email,
  phone: phone,
  role: role,
  passwordHash: passwordHash,
).ref();
ref.execute();
```


### RegisterFarmer
#### Required Arguments
```dart
String userId = ...;
String firstName = ...;
String lastName = ...;
ExampleConnector.instance.registerFarmer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
).execute();
```

#### Optional Arguments
We return a builder for each query. For RegisterFarmer, we created `RegisterFarmerBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class RegisterFarmerVariablesBuilder {
  ...
   RegisterFarmerVariablesBuilder farmSize(double? t) {
   _farmSize.value = t;
   return this;
  }
  RegisterFarmerVariablesBuilder utilityBillPath(String? t) {
   _utilityBillPath.value = t;
   return this;
  }
  RegisterFarmerVariablesBuilder validIdPath(String? t) {
   _validIdPath.value = t;
   return this;
  }
  RegisterFarmerVariablesBuilder ownersAddressDocPath(String? t) {
   _ownersAddressDocPath.value = t;
   return this;
  }
  RegisterFarmerVariablesBuilder ownershipDocsPath(String? t) {
   _ownershipDocsPath.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.registerFarmer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
)
.farmSize(farmSize)
.utilityBillPath(utilityBillPath)
.validIdPath(validIdPath)
.ownersAddressDocPath(ownersAddressDocPath)
.ownershipDocsPath(ownershipDocsPath)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<RegisterFarmerData, RegisterFarmerVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.registerFarmer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
);
RegisterFarmerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
String firstName = ...;
String lastName = ...;

final ref = ExampleConnector.instance.registerFarmer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
).ref();
ref.execute();
```


### RegisterLogistics
#### Required Arguments
```dart
String userId = ...;
bool isCompany = ...;
ExampleConnector.instance.registerLogistics(
  userId: userId,
  isCompany: isCompany,
).execute();
```

#### Optional Arguments
We return a builder for each query. For RegisterLogistics, we created `RegisterLogisticsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class RegisterLogisticsVariablesBuilder {
  ...
   RegisterLogisticsVariablesBuilder firstName(String? t) {
   _firstName.value = t;
   return this;
  }
  RegisterLogisticsVariablesBuilder lastName(String? t) {
   _lastName.value = t;
   return this;
  }
  RegisterLogisticsVariablesBuilder vehicleType(String? t) {
   _vehicleType.value = t;
   return this;
  }
  RegisterLogisticsVariablesBuilder plateNumber(String? t) {
   _plateNumber.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.registerLogistics(
  userId: userId,
  isCompany: isCompany,
)
.firstName(firstName)
.lastName(lastName)
.vehicleType(vehicleType)
.plateNumber(plateNumber)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<RegisterLogisticsData, RegisterLogisticsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.registerLogistics(
  userId: userId,
  isCompany: isCompany,
);
RegisterLogisticsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
bool isCompany = ...;

final ref = ExampleConnector.instance.registerLogistics(
  userId: userId,
  isCompany: isCompany,
).ref();
ref.execute();
```


### RegisterBulkBuyer
#### Required Arguments
```dart
String userId = ...;
String firstName = ...;
String lastName = ...;
ExampleConnector.instance.registerBulkBuyer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
).execute();
```

#### Optional Arguments
We return a builder for each query. For RegisterBulkBuyer, we created `RegisterBulkBuyerBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class RegisterBulkBuyerVariablesBuilder {
  ...
   RegisterBulkBuyerVariablesBuilder businessName(String? t) {
   _businessName.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.registerBulkBuyer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
)
.businessName(businessName)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<RegisterBulkBuyerData, RegisterBulkBuyerVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.registerBulkBuyer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
);
RegisterBulkBuyerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
String firstName = ...;
String lastName = ...;

final ref = ExampleConnector.instance.registerBulkBuyer(
  userId: userId,
  firstName: firstName,
  lastName: lastName,
).ref();
ref.execute();
```


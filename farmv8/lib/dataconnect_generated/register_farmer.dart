part of 'generated.dart';

class RegisterFarmerVariablesBuilder {
  String userId;
  String firstName;
  String lastName;
  Optional<double> _farmSize = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _utilityBillPath = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _validIdPath = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _ownersAddressDocPath = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _ownershipDocsPath = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  RegisterFarmerVariablesBuilder farmSize(double? t) {
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

  RegisterFarmerVariablesBuilder(this._dataConnect, {required  this.userId,required  this.firstName,required  this.lastName,});
  Deserializer<RegisterFarmerData> dataDeserializer = (dynamic json)  => RegisterFarmerData.fromJson(jsonDecode(json));
  Serializer<RegisterFarmerVariables> varsSerializer = (RegisterFarmerVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RegisterFarmerData, RegisterFarmerVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RegisterFarmerData, RegisterFarmerVariables> ref() {
    RegisterFarmerVariables vars= RegisterFarmerVariables(userId: userId,firstName: firstName,lastName: lastName,farmSize: _farmSize,utilityBillPath: _utilityBillPath,validIdPath: _validIdPath,ownersAddressDocPath: _ownersAddressDocPath,ownershipDocsPath: _ownershipDocsPath,);
    return _dataConnect.mutation("RegisterFarmer", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RegisterFarmerFarmerProfileInsert {
  final String id;
  RegisterFarmerFarmerProfileInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterFarmerFarmerProfileInsert otherTyped = other as RegisterFarmerFarmerProfileInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RegisterFarmerFarmerProfileInsert({
    required this.id,
  });
}

@immutable
class RegisterFarmerData {
  final RegisterFarmerFarmerProfileInsert farmerProfile_insert;
  RegisterFarmerData.fromJson(dynamic json):
  
  farmerProfile_insert = RegisterFarmerFarmerProfileInsert.fromJson(json['farmerProfile_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterFarmerData otherTyped = other as RegisterFarmerData;
    return farmerProfile_insert == otherTyped.farmerProfile_insert;
    
  }
  @override
  int get hashCode => farmerProfile_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['farmerProfile_insert'] = farmerProfile_insert.toJson();
    return json;
  }

  RegisterFarmerData({
    required this.farmerProfile_insert,
  });
}

@immutable
class RegisterFarmerVariables {
  final String userId;
  final String firstName;
  final String lastName;
  late final Optional<double>farmSize;
  late final Optional<String>utilityBillPath;
  late final Optional<String>validIdPath;
  late final Optional<String>ownersAddressDocPath;
  late final Optional<String>ownershipDocsPath;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RegisterFarmerVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']) {
  
  
  
  
  
    farmSize = Optional.optional(nativeFromJson, nativeToJson);
    farmSize.value = json['farmSize'] == null ? null : nativeFromJson<double>(json['farmSize']);
  
  
    utilityBillPath = Optional.optional(nativeFromJson, nativeToJson);
    utilityBillPath.value = json['utilityBillPath'] == null ? null : nativeFromJson<String>(json['utilityBillPath']);
  
  
    validIdPath = Optional.optional(nativeFromJson, nativeToJson);
    validIdPath.value = json['validIdPath'] == null ? null : nativeFromJson<String>(json['validIdPath']);
  
  
    ownersAddressDocPath = Optional.optional(nativeFromJson, nativeToJson);
    ownersAddressDocPath.value = json['ownersAddressDocPath'] == null ? null : nativeFromJson<String>(json['ownersAddressDocPath']);
  
  
    ownershipDocsPath = Optional.optional(nativeFromJson, nativeToJson);
    ownershipDocsPath.value = json['ownershipDocsPath'] == null ? null : nativeFromJson<String>(json['ownershipDocsPath']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterFarmerVariables otherTyped = other as RegisterFarmerVariables;
    return userId == otherTyped.userId && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    farmSize == otherTyped.farmSize && 
    utilityBillPath == otherTyped.utilityBillPath && 
    validIdPath == otherTyped.validIdPath && 
    ownersAddressDocPath == otherTyped.ownersAddressDocPath && 
    ownershipDocsPath == otherTyped.ownershipDocsPath;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, firstName.hashCode, lastName.hashCode, farmSize.hashCode, utilityBillPath.hashCode, validIdPath.hashCode, ownersAddressDocPath.hashCode, ownershipDocsPath.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if(farmSize.state == OptionalState.set) {
      json['farmSize'] = farmSize.toJson();
    }
    if(utilityBillPath.state == OptionalState.set) {
      json['utilityBillPath'] = utilityBillPath.toJson();
    }
    if(validIdPath.state == OptionalState.set) {
      json['validIdPath'] = validIdPath.toJson();
    }
    if(ownersAddressDocPath.state == OptionalState.set) {
      json['ownersAddressDocPath'] = ownersAddressDocPath.toJson();
    }
    if(ownershipDocsPath.state == OptionalState.set) {
      json['ownershipDocsPath'] = ownershipDocsPath.toJson();
    }
    return json;
  }

  RegisterFarmerVariables({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.farmSize,
    required this.utilityBillPath,
    required this.validIdPath,
    required this.ownersAddressDocPath,
    required this.ownershipDocsPath,
  });
}


part of 'generated.dart';

class RegisterBulkBuyerVariablesBuilder {
  String userId;
  String firstName;
  String lastName;
  Optional<String> _businessName = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  RegisterBulkBuyerVariablesBuilder businessName(String? t) {
   _businessName.value = t;
   return this;
  }

  RegisterBulkBuyerVariablesBuilder(this._dataConnect, {required  this.userId,required  this.firstName,required  this.lastName,});
  Deserializer<RegisterBulkBuyerData> dataDeserializer = (dynamic json)  => RegisterBulkBuyerData.fromJson(jsonDecode(json));
  Serializer<RegisterBulkBuyerVariables> varsSerializer = (RegisterBulkBuyerVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RegisterBulkBuyerData, RegisterBulkBuyerVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RegisterBulkBuyerData, RegisterBulkBuyerVariables> ref() {
    RegisterBulkBuyerVariables vars= RegisterBulkBuyerVariables(userId: userId,firstName: firstName,lastName: lastName,businessName: _businessName,);
    return _dataConnect.mutation("RegisterBulkBuyer", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RegisterBulkBuyerBulkBuyerProfileInsert {
  final String id;
  RegisterBulkBuyerBulkBuyerProfileInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterBulkBuyerBulkBuyerProfileInsert otherTyped = other as RegisterBulkBuyerBulkBuyerProfileInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RegisterBulkBuyerBulkBuyerProfileInsert({
    required this.id,
  });
}

@immutable
class RegisterBulkBuyerData {
  final RegisterBulkBuyerBulkBuyerProfileInsert bulkBuyerProfile_insert;
  RegisterBulkBuyerData.fromJson(dynamic json):
  
  bulkBuyerProfile_insert = RegisterBulkBuyerBulkBuyerProfileInsert.fromJson(json['bulkBuyerProfile_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterBulkBuyerData otherTyped = other as RegisterBulkBuyerData;
    return bulkBuyerProfile_insert == otherTyped.bulkBuyerProfile_insert;
    
  }
  @override
  int get hashCode => bulkBuyerProfile_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['bulkBuyerProfile_insert'] = bulkBuyerProfile_insert.toJson();
    return json;
  }

  RegisterBulkBuyerData({
    required this.bulkBuyerProfile_insert,
  });
}

@immutable
class RegisterBulkBuyerVariables {
  final String userId;
  final String firstName;
  final String lastName;
  late final Optional<String>businessName;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RegisterBulkBuyerVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']) {
  
  
  
  
  
    businessName = Optional.optional(nativeFromJson, nativeToJson);
    businessName.value = json['businessName'] == null ? null : nativeFromJson<String>(json['businessName']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterBulkBuyerVariables otherTyped = other as RegisterBulkBuyerVariables;
    return userId == otherTyped.userId && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    businessName == otherTyped.businessName;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, firstName.hashCode, lastName.hashCode, businessName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if(businessName.state == OptionalState.set) {
      json['businessName'] = businessName.toJson();
    }
    return json;
  }

  RegisterBulkBuyerVariables({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.businessName,
  });
}


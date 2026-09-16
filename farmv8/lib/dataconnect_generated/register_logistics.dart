part of 'generated.dart';

class RegisterLogisticsVariablesBuilder {
  String userId;
  bool isCompany;
  Optional<String> _firstName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _lastName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _vehicleType = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _plateNumber = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  RegisterLogisticsVariablesBuilder firstName(String? t) {
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

  RegisterLogisticsVariablesBuilder(this._dataConnect, {required  this.userId,required  this.isCompany,});
  Deserializer<RegisterLogisticsData> dataDeserializer = (dynamic json)  => RegisterLogisticsData.fromJson(jsonDecode(json));
  Serializer<RegisterLogisticsVariables> varsSerializer = (RegisterLogisticsVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RegisterLogisticsData, RegisterLogisticsVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RegisterLogisticsData, RegisterLogisticsVariables> ref() {
    RegisterLogisticsVariables vars= RegisterLogisticsVariables(userId: userId,isCompany: isCompany,firstName: _firstName,lastName: _lastName,vehicleType: _vehicleType,plateNumber: _plateNumber,);
    return _dataConnect.mutation("RegisterLogistics", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RegisterLogisticsLogisticsProfileInsert {
  final String id;
  RegisterLogisticsLogisticsProfileInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterLogisticsLogisticsProfileInsert otherTyped = other as RegisterLogisticsLogisticsProfileInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RegisterLogisticsLogisticsProfileInsert({
    required this.id,
  });
}

@immutable
class RegisterLogisticsData {
  final RegisterLogisticsLogisticsProfileInsert logisticsProfile_insert;
  RegisterLogisticsData.fromJson(dynamic json):
  
  logisticsProfile_insert = RegisterLogisticsLogisticsProfileInsert.fromJson(json['logisticsProfile_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterLogisticsData otherTyped = other as RegisterLogisticsData;
    return logisticsProfile_insert == otherTyped.logisticsProfile_insert;
    
  }
  @override
  int get hashCode => logisticsProfile_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['logisticsProfile_insert'] = logisticsProfile_insert.toJson();
    return json;
  }

  RegisterLogisticsData({
    required this.logisticsProfile_insert,
  });
}

@immutable
class RegisterLogisticsVariables {
  final String userId;
  final bool isCompany;
  late final Optional<String>firstName;
  late final Optional<String>lastName;
  late final Optional<String>vehicleType;
  late final Optional<String>plateNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RegisterLogisticsVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  isCompany = nativeFromJson<bool>(json['isCompany']) {
  
  
  
  
    firstName = Optional.optional(nativeFromJson, nativeToJson);
    firstName.value = json['firstName'] == null ? null : nativeFromJson<String>(json['firstName']);
  
  
    lastName = Optional.optional(nativeFromJson, nativeToJson);
    lastName.value = json['lastName'] == null ? null : nativeFromJson<String>(json['lastName']);
  
  
    vehicleType = Optional.optional(nativeFromJson, nativeToJson);
    vehicleType.value = json['vehicleType'] == null ? null : nativeFromJson<String>(json['vehicleType']);
  
  
    plateNumber = Optional.optional(nativeFromJson, nativeToJson);
    plateNumber.value = json['plateNumber'] == null ? null : nativeFromJson<String>(json['plateNumber']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterLogisticsVariables otherTyped = other as RegisterLogisticsVariables;
    return userId == otherTyped.userId && 
    isCompany == otherTyped.isCompany && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    vehicleType == otherTyped.vehicleType && 
    plateNumber == otherTyped.plateNumber;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, isCompany.hashCode, firstName.hashCode, lastName.hashCode, vehicleType.hashCode, plateNumber.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['isCompany'] = nativeToJson<bool>(isCompany);
    if(firstName.state == OptionalState.set) {
      json['firstName'] = firstName.toJson();
    }
    if(lastName.state == OptionalState.set) {
      json['lastName'] = lastName.toJson();
    }
    if(vehicleType.state == OptionalState.set) {
      json['vehicleType'] = vehicleType.toJson();
    }
    if(plateNumber.state == OptionalState.set) {
      json['plateNumber'] = plateNumber.toJson();
    }
    return json;
  }

  RegisterLogisticsVariables({
    required this.userId,
    required this.isCompany,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.plateNumber,
  });
}


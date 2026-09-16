library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_user.dart';

part 'register_farmer.dart';

part 'register_logistics.dart';

part 'register_bulk_buyer.dart';







class ExampleConnector {
  
  
  CreateUserVariablesBuilder createUser ({required String username, required String email, required String phone, required String role, required String passwordHash, }) {
    return CreateUserVariablesBuilder(dataConnect, username: username,email: email,phone: phone,role: role,passwordHash: passwordHash,);
  }
  
  
  RegisterFarmerVariablesBuilder registerFarmer ({required String userId, required String firstName, required String lastName, }) {
    return RegisterFarmerVariablesBuilder(dataConnect, userId: userId,firstName: firstName,lastName: lastName,);
  }
  
  
  RegisterLogisticsVariablesBuilder registerLogistics ({required String userId, required bool isCompany, }) {
    return RegisterLogisticsVariablesBuilder(dataConnect, userId: userId,isCompany: isCompany,);
  }
  
  
  RegisterBulkBuyerVariablesBuilder registerBulkBuyer ({required String userId, required String firstName, required String lastName, }) {
    return RegisterBulkBuyerVariablesBuilder(dataConnect, userId: userId,firstName: firstName,lastName: lastName,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'example',
    'agri-grow-eb3da-service',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

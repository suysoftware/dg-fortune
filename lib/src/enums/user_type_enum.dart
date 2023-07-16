

enum UserType{
  anon,standart,premium
}


UserType userTypeEnumFromString(String value){
  return UserType.values.firstWhere((e)=>
      e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}


enum ThemeType{
 day,night
}


ThemeType themeTypeEnumFromString(String value){
  return ThemeType.values.firstWhere((e)=>
      e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}
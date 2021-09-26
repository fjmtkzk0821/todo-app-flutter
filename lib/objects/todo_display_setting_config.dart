class TodoDisplaySettingConfig {
  int displayByDays; //default current week = false
  SortType sortType;

  //...
  TodoDisplaySettingConfig() {
    displayByDays = 7;//-1:all, 7:week, 30:month, 365:year
    sortType = SortType.IMPORTANT;
  }
}

enum SortType {
  DATE_ASC,
  DATE_DESC,
  IMPORTANT
}
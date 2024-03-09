
abstract class TableEvent {

}
class TableShow extends TableEvent{

}
class TableAdd extends TableEvent{
  // Food food;
  // FoodAdd(this.player);
}
class SearchChanged extends TableEvent{
  String txt;
  SearchChanged(this.txt);
}
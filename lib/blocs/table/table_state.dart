
import 'package:bloc_api_1/models/food.dart';

import '../../models/table.dart';
abstract class TableState{

}

class TableInit extends TableState{
  List<Table> tables = [];

}

class TableLoading extends TableState{

}
class TableSuccess extends TableState{
  List<Table> tables = [];
  TableSuccess(this.tables);
}

class TableFail extends TableState{

}

// class SearchHasData extends TableState{
//   List<Food> foods = [];
//   SearchHasData(this.foods);
// }



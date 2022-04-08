// ignore: file_names
enum Operation {
  plus,
  minus,
  division,
  multplication,
}

class GameQuestion1 {
  int base;
  int numberToLookFor;
  int numberInCenter;

  GameQuestion1(this.base, this.numberToLookFor, this.numberInCenter);
  static List<Map<String, int>> getLevel1Questions() {
    return [
      {'id': 1, 'look For': 18, 'apply with': 3, 'start with': 16},
      {'id': 2, 'look For': -5, 'apply with': 20, 'start with': 14},
      {'id': 3, 'look For': 57, 'apply with': 33, 'start with': 25},
      {'id': 4, 'look For': 74, 'apply with': 46, 'start with': 29},
      {'id': 5, 'look For': -40, 'apply with': 70, 'start with': 29},
      {'id': 6, 'look For': -36, 'apply with': 80, 'start with': 43},
      {'id': 7, 'look For': 141, 'apply with': 95, 'start with': 47},
      {'id': 8, 'look For': 157, 'apply with': 106, 'start with': 52},
      {'id': 9, 'look For': -70, 'apply with': 130, 'start with': 59},
      {'id': 10, 'look For': -88, 'apply with': 147, 'start with': 58},
      {'id': 11, 'look For': -101, 'apply with': 158, 'start with': 56},
      {'id': 12, 'look For': 238, 'apply with': 168, 'start with': 71},
      {'id': 13, 'look For': -124, 'apply with': 194, 'start with': 69},
      {'id': 14, 'look For': -127, 'apply with': 204, 'start with': 76},
      {'id': 15, 'look For': 305, 'apply with': 223, 'start with': 83},
      {'id': 16, 'look For': -153, 'apply with': 237, 'start with': 83},
      {'id': 17, 'look For': 338, 'apply with': 253, 'start with': 86},
      {'id': 18, 'look For': -168, 'apply with': 264, 'start with': 95},
      {'id': 19, 'look For': 372, 'apply with': 276, 'start with': 97},
      {'id': 20, 'look For': -181, 'apply with': 292, 'start with': 110},
    ];
  }
}

class GameQuestion2 {
  int numberInCenter;
  int plusMinusBase;
  int multpDivBase;
  int numberToLookFor;

  GameQuestion2(this.plusMinusBase, this.multpDivBase, this.numberInCenter,
      this.numberToLookFor);
  static List<Map<String, int>> getLevel1Questions() {
    return [
      {
        'id': 21,
        'lookFor': -6,
        'plusOrMinus': 10,
        'multOrDev': 5,
        'startWith': 2
      },
      {
        'id': 22,
        'lookFor': 468,
        'plusOrMinus': 18,
        'multOrDev': 26,
        'startWith': 18
      },
      {
        'id': 23,
        'lookFor': 1260,
        'plusOrMinus': 43,
        'multOrDev': 30,
        'startWith': 13
      },
      {
        'id': 24,
        'lookFor': -2622,
        'plusOrMinus': 59,
        'multOrDev': 46,
        'startWith': 33
      },
      {
        'id': 25,
        'lookFor': 143,
        'plusOrMinus': 14,
        'multOrDev': 11,
        'startWith': 3
      },
      {
        'id': 26,
        'lookFor': -576,
        'plusOrMinus': 26,
        'multOrDev': 24,
        'startWith': 22
      },
      {
        'id': 27,
        'lookFor': -1287,
        'plusOrMinus': 41,
        'multOrDev': 33,
        'startWith': 25
      },
      {
        'id': 28,
        'lookFor': 320,
        'plusOrMinus': 21,
        'multOrDev': 16,
        'startWith': 5
      },
      {
        'id': 29,
        'lookFor': 110,
        'plusOrMinus': 10,
        'multOrDev': 12,
        'startWith': 0
      },
      {
        'id': 30,
        'lookFor': -345,
        'plusOrMinus': 16,
        'multOrDev': 23,
        'startWith': 7
      },
      {
        'id': 31,
        'lookFor': 1376,
        'plusOrMinus': 44,
        'multOrDev': 32,
        'startWith': 12
      },
      {
        'id': 32,
        'lookFor': -2565,
        'plusOrMinus': 59,
        'multOrDev': 45,
        'startWith': 31
      },
      {
        'id': 33,
        'lookFor': 84,
        'plusOrMinus': 6,
        'multOrDev': 14,
        'startWith': 6
      },
      {
        'id': 34,
        'lookFor': 507,
        'plusOrMinus': 22,
        'multOrDev': 23,
        'startWith': 23
      },
      {
        'id': 35,
        'lookFor': -1344,
        'plusOrMinus': 44,
        'multOrDev': 32,
        'startWith': 20
      },
      {
        'id': 36,
        'lookFor': -2475,
        'plusOrMinus': 57,
        'multOrDev': 45,
        'startWith': 33
      },
      {
        'id': 37,
        'lookFor': -4,
        'plusOrMinus': 9,
        'multOrDev': 3,
        'startWith': 2
      },
      {
        'id': 38,
        'lookFor': 421,
        'plusOrMinus': 27,
        'multOrDev': 16,
        'startWith': 16
      },
      {
        'id': 39,
        'lookFor': -1428,
        'plusOrMinus': 44,
        'multOrDev': 34,
        'startWith': 24
      },
      {
        'id': 40,
        'lookFor': -2430,
        'plusOrMinus': 56,
        'multOrDev': 45,
        'startWith': 34
      },
    ];
  }
}

class GameQuestion3 {
  int numberInCenter;
  int plusBase;
  int minusBase;
  int multBase;
  int divBase;
  int numberToLookFor;

  GameQuestion3(this.plusBase, this.minusBase, this.multBase, this.divBase,
      this.numberInCenter, this.numberToLookFor);
  static List<Map<String, int>> getLevel1Questions() {
    return [
      {
        'id': 41,
        'lookFor': 21,
        'plus': 14,
        'minus': 2,
        'multp': 7,
        'div': 3,
        'startWith': 5
      },
      {
        'id': 42,
        'lookFor': 25,
        'plus': 18,
        'minus': 20,
        'multp': 17,
        'div': 19,
        'startWith': 9
      },
      {
        'id': 43,
        'lookFor': 15,
        'plus': 38,
        'minus': 30,
        'multp': 37,
        'div': 40,
        'startWith': 16
      },
      {
        'id': 44,
        'lookFor': 61,
        'plus': 133,
        'minus': 126,
        'multp': 122,
        'div': 130,
        'startWith': 58
      },
      {
        'id': 45,
        'lookFor': 0,
        'plus': 22,
        'minus': 30,
        'multp': 10,
        'div': 36,
        'startWith': 8
      },
      {
        'id': 46,
        'lookFor': 38,
        'plus': 34,
        'minus': 48,
        'multp': 52,
        'div': 17,
        'startWith': 17
      },
      {
        'id': 47,
        'lookFor': 39,
        'plus': 53,
        'minus': 57,
        'multp': 65,
        'div': 35,
        'startWith': 25
      },
      {
        'id': 48,
        'lookFor': 12,
        'plus': 51,
        'minus': 68,
        'multp': 54,
        'div': 63,
        'startWith': 31
      },
      {
        'id': 49,
        'lookFor': -75,
        'plus': 84,
        'minus': 111,
        'multp': 114,
        'div': 110,
        'startWith': 34
      },
      {
        'id': 50,
        'lookFor': 51,
        'plus': 94,
        'minus': 93,
        'multp': 102,
        'div': 96,
        'startWith': 47
      },
      {
        'id': 51,
        'lookFor': -94,
        'plus': 136,
        'minus': 149,
        'multp': 171,
        'div': 155,
        'startWith': 63
      },
      {
        'id': 52,
        'lookFor': -26,
        'plus': 30,
        'minus': 37,
        'multp': 51,
        'div': 42,
        'startWith': 15
      },
      {
        'id': 53,
        'lookFor': 32,
        'plus': 50,
        'minus': 65,
        'multp': 61,
        'div': 51,
        'startWith': 27
      },
      {
        'id': 54,
        'lookFor': 93,
        'plus': 79,
        'minus': 68,
        'multp': 61,
        'div': 91,
        'startWith': 22
      },
      {
        'id': 55,
        'lookFor': 20,
        'plus': 120,
        'minus': 124,
        'multp': 100,
        'div': 90,
        'startWith': 34
      },
      {
        'id': 56,
        'lookFor': 84,
        'plus': 128,
        'minus': 111,
        'multp': 144,
        'div': 108,
        'startWith': 46
      },
      {
        'id': 57,
        'lookFor': 207,
        'plus': 161,
        'minus': 152,
        'multp': 140,
        'div': 144,
        'startWith': 53
      },
      {
        'id': 58,
        'lookFor': 47,
        'plus': 42,
        'minus': 33,
        'multp': 38,
        'div': 15,
        'startWith': 15
      },
      {
        'id': 59,
        'lookFor': -21,
        'plus': 63,
        'minus': 48,
        'multp': 57,
        'div': 73,
        'startWith': 20
      },
      {
        'id': 60,
        'lookFor': -2788,
        'plus': 39,
        'minus': 42,
        'multp': 68,
        'div': 54,
        'startWith': 15
      }
    ];
  }
} 

// Algorith1
// import 'dart:math' ;
// 20/ class GameQuestion {
// 20/   int numberInCenter;
// 20/   int base;
// 20/   int numberToLookFor ;
// 20
// 20   GameQuestion(this.base,this.numberInCenter,this.numberToLookFor) ;
// 20   @override
// 20   String toString(){
// 20
// 20     return 'apply with : $base | 'start with' $numberInCenter | in end i get $numberToLookFor' ;
// 20   }
// 20 }8
// 20 c9ass Step {
// 20 20int num;
//   Operation operation;
//   Step(this.num,this.operation) ;
//   @override
//   String toString(){
//     return 'num : $num ||operation = $operation' ;
//   }
// }

// enum Operation {
//   plus,
//   minus,
//   division,
//   multplication,
// }

// void main() {
//   generate() ;
// //   print(generate()) ;
//  List<Map<String,int>> list =
//     generate().map((item)=> {'look For':item.numberToLookFor,
//                                  'apply with':item.base,
//                                  'start with' : item.numberInCenter} ).toList();
//   print(list) ;
// }
// double  operate(int numToApplyOn ,int num , Operation op ) {
//   if ( op == Operation.plus) {
//     return num + numToApplyOn as double ;
//   }else if ( op == Operation.minus) {
//     return  numToApplyOn  - num  as double ;
//   }
//   else if ( op == Operation.multplication) {
//     return num * numToApplyOn  as double  ;
//   }
//   else {
//     return numToApplyOn  / num ;

//   }
// }
// List<GameQuestion>  generate() {
//   List<GameQuestion> list = [] ;
//   List<Operation> operation = [Operation.plus,
//                                Operation.minus,
//                                Operation.division ,
//                               Operation.multplication] ;
//   for (int i = 0 ; i<20 ; i++) {
//     int formulaBase = Random().nextInt(15)+15*i ;
//     int realNumberInCenter = Random().nextInt(20)+5*i ;
//     int numberInCenter = realNumberInCenter;
//     bool isB = false  ;
//     print('number in center on $numberInCenter');
//     List<Step> step = [] ;
//     List<bool> visited = [false,false,false,false] ;
//      for (int j = 0 ; j < 4 ;j++) {
//        int opIndex = 0 ;
//        double    num  =0 ;
//        int reTry = 0 ;
//        bool isBreaked = false ;
//        do {
//          if ( reTry > 8) {
//            i-- ;
//            print('i breaked') ;
//            isBreaked = true ;
//            break ;
//          }
//         opIndex = Random().nextInt(4);
//         num = operate(numberInCenter,formulaBase,operation[opIndex]);
//         reTry++ ;

//          } while ( num % 1 != 0  || visited[opIndex]) ;
//        if ( isBreaked) {
//          isB = true ;
//          break ;
//        } ;

//        print("after ${operation[opIndex]} with $formulaBase I get  $num") ;
//        numberInCenter  = num as int ;
//        visited[opIndex] = true ;
//        step.add(Step(num as int ,operation[opIndex]));
//     }
//     if ( isB) continue ;
//       if ( numberInCenter == realNumberInCenter) {
//          print('NO ');
//          i-- ;
//          continue ;
//        }

//     list.add(GameQuestion(formulaBase,realNumberInCenter,numberInCenter)) ;
//   }

//   return list ;
// }
// Algorithm ;
// import 'dart:math' ; 
// class GameQuestion {
//   int numberInCenter;
//   int base;
//   int numberToLookFor ; 
 
//   GameQuestion(this.base,this.numberInCenter,this.numberToLookFor) ; 
//   @override
//   String toString(){
      
//     return 'apply with : $base | start with $numberInCenter | in end i get $numberToLookFor' ;
//   }
// }
// class GameQuestion2 {
//   int numberInCenter;
//   int plusMinusBase;
//   int multpDivBase;
//   int numberToLookFor ; 
 
//   GameQuestion2(this.plusMinusBase,this.multpDivBase,
//                this.numberInCenter,this.numberToLookFor) ; 
//   @override
//   String toString(){
      
//     return 'apply with : +- $plusMinusBase or  */  $multpDivBase| start with+'+
//     '$numberInCenter | in end i get $numberToLookFor' ;
//   }
// }

// class Step {
//   int num;
//   Operation operation; 
//   Step(this.num,this.operation) ;
//   @override
//   String toString(){
//     return 'num : $num ||operation = $operation' ;
//   }
// }

// enum Operation {
//   plus,
//   minus,
//   division,
//   multplication,
// }

// void main() {
// //   generate() ;
// //   print(generate()) ;
//  List<Map<String,int>> list = 
//     generate().map((item)=> {'look For':item.numberToLookFor,
//                                  ''plus or  minus'':item.plusMinusBase  ,
//                                  'multiply or devide':item.multpDivBase  ,
//                                  'start with' : item.numberInCenter} ).toList();
//   print(list) ;
// }
// double  operate(int numToApplyOn ,int plus,int mult , Operation op ) {
//   if ( op == Operation.plus) {
//     return  plus + numToApplyOn as double ; 
//   }else if ( op == Operation.minus) {
//     return  numToApplyOn  - plus  as double ; 
//   }
//   else if ( op == Operation.multplication) {
//     return mult * numToApplyOn  as double  ; 
//   }
//   else {
//     return numToApplyOn  / mult ; 
    
//   }
// } 
// List<GameQuestion2>  generate() {
//   List<GameQuestion2> list = [] ; 
//   List<Operation> operation = [Operation.plus,
//                                Operation.minus,
//                                Operation.division ,
//                               Operation.multplication] ; 
//    int  count = 0 ; 
//   for (int i = 0 ; i<4 ; i++,count++) {
//     int multpDivBase = 0; 
//     int plusMinusBase = 0 ; 
//     while (multpDivBase == plusMinusBase) {
//       print('let try $count');
//       multpDivBase = Random().nextInt(15)+15*i ; 
//       plusMinusBase = Random().nextInt(15)+15*i ; 
//       print('+- $plusMinusBase ||*/ $multpDivBase') ;
//     }
//     int realNumberInCenter = Random().nextInt(20)+5*i ; 
//     int numberInCenter = realNumberInCenter; 
//     bool isB = false  ; 
// //     print('number in center on $numberInCenter');
//     List<Step> steps = [] ;
//     List<bool> visited = [false,false,false,false] ;
//      for (int j = 0 ; j < 4 ;j++) {
//        int opIndex = 0 ; 
//        double    num  =0 ; 
//        int reTry = 0 ; 
//        bool isBreaked = false ; 
//        do {
//          if ( reTry > 8) {
//            i-- ; 
//            print('i try to many times') ;
//            isBreaked = true ; 
//            break ; 
//          } 
//         opIndex = Random().nextInt(4); 
//         num = operate(numberInCenter,plusMinusBase,multpDivBase,operation[opIndex]);
//         reTry++ ;
        

//          } while ( num % 1 != 0  || visited[opIndex]) ;
//        if ( isBreaked) {
//          isB = true ; 
//          break ; 
//        } ; 
        
//        if (operation[opIndex] == Operation.plus ||
//           operation[opIndex] == Operation.minus){
//                 steps.add(Step(plusMinusBase,operation[opIndex]));

//        }
//        else {
//                 steps.add(Step(multpDivBase,operation[opIndex]));

//        }
// //        print("after ${operation[opIndex]} with mult/div =$multpDivBase or "+
// //        "with plus/minus $plusMinusBase get  $num") ;
//        numberInCenter  = num as int ; 
//        visited[opIndex] = true ; 
       
//     }
//     if ( isB) continue ;  
//       if ( numberInCenter == realNumberInCenter ) {
//          print('number i get match number i look for');
//          i-- ;
//          continue ; 
//        }
//     print('number i start with $realNumberInCenter') ;
// //     print(steps);
//     steps.forEach((step){
//       print('i did ${step.operation} with  ${step.num}');
//     }); 
//     print('aftet i get $numberInCenter') ;
//     list.add(GameQuestion2(realNumberInCenter,
//                            plusMinusBase,
//                            multpDivBase
//                            ,numberInCenter)) ; 
//   }
 
//   return list ; 
// }




































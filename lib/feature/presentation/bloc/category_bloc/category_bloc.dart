import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit)async {
      List<String>categorys=[];
       final instance = FirebaseFirestore.instance;
    final catSnap = await instance.collection("category").get();
    for(var cate in catSnap.docs){
     categorys.add(cate.data()['category']); 
      
    }
    emit(CategoryLoadedState(caregorys: categorys));
    });
  }
}

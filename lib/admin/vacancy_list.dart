import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/providers/firestore.dart';
import 'package:jsninja/search/vacancy_item_tile.dart';
import 'package:jsninja/state/generic_state_notifier.dart';

final sortStateNotifierProvider =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class VacanciesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: ref.watch(
          // filteredColSP(QueryParams(
          //   path: 'vacancy',
          //   orderBy: 'timeCreated',
          //   isOrderDesc: true,
          //   limit: 100))
          colSP('vacancy')).when(
          loading: () => [Container()],
          error: (e, s) => [ErrorWidget(e)],
          data: (data) {
            // bool onlyMineSwitchStatus =
            //     ref.watch(isMineBatchNotifierProvider) ?? false;
            // var all_batches = data.docs;
            // var authors_only_batch = data.docs
            //     .where((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            //         doc.data()['author'] ==
            //         FirebaseAuth.instance.currentUser!.uid)
            //     .toList();
            // var author_filtered_batches = (onlyMineSwitchStatus == true
            //     ? authors_only_batch
            //     : all_batches);
            // var sorted_batches = author_filtered_batches
            //   ..sort((a, b) {
            //     var sortedBy = ref.watch(sortStateNotifierProvider) ?? 'id';
            //     // print(sortedBy);
            //     return a[sortedBy].compareTo(b[sortedBy]);
            //   });
            print('vacancies found: ${data.docs}');
            return data.docs
                .map((e) => VacancyItem(key: Key(e.id), e.reference))
                .toList();
          }));
}

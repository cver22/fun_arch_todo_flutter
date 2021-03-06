import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_arch_todo_flutter/flutter_todos_keys.dart';
import 'package:fun_arch_todo_flutter/models/stats_state.dart';
import 'package:fun_arch_todo_flutter/store/connect_state.dart';
import 'package:fun_arch_todo_flutter/widgets/loading_indicator.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:fun_arch_todo_flutter/utils/utils.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  Widget _renderStatsData(BuildContext context, StatsData statsData) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).completedTodos,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              '${statsData.numCompleted}',
              key: ArchSampleKeys.statsNumCompleted,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).activeTodos,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              "${statsData.numActive}",
              key: ArchSampleKeys.statsNumActive,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConnectState<StatsState>(
      map: (state) => state.statsState,
      where: notIdentical,
      builder: (stats) {
        return stats.isLoading
            ? LoadingIndicator(key: FlutterTodosKeys.statsLoadingIndicator)
            : stats.statsData
                .map((statsData) => _renderStatsData(context, statsData))
                .orElse(SizedBox());
      },
    );
  }
}

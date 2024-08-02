abstract class TaskState {}

class TaskInitial extends TaskState {}

class GetDateLoadingState extends TaskState {}

class GetDateSuccessState extends TaskState {}

class GetDateErrorState extends TaskState {}

class GetStartTimeLoadingState extends TaskState {}

class GetStartTimeSuccessState extends TaskState {}

class GetStartTimeErrorState extends TaskState {}

class GetSelectedDateSuccessState extends TaskState {}

class GetSelectedDateLoadingState extends TaskState {}

class ChangeThemeState extends TaskState {}

class GetThemeState extends TaskState {}

class GetEndTimeLoadingState extends TaskState {}

class GetEndTimeSuccessState extends TaskState {}

class GetEndTimeErrorState extends TaskState {}

class ChangeCheckMarkIndexState extends TaskState {}

class InsertTaskLoadingState extends TaskState {}

class InsertTaskSuccessState extends TaskState {}

class InsertTaskErrorState extends TaskState {}

class GetTaskLoadingState extends TaskState {}

class GetTaskSucessState extends TaskState {}

class GetTaskErrorState extends TaskState {}

class UpdateTaskLoadingState extends TaskState {}

class UpdateTaskSuccessState extends TaskState {}

class UpdateTaskErrorState extends TaskState {}

class DeleteTaskLoadingState extends TaskState {}

class DeleteTaskSuccessState extends TaskState {}

class DeleteTaskErrorState extends TaskState {}

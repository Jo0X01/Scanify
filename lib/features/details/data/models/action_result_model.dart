class DetailsActionResultModel {
  final bool success;
  final String? error;
  const DetailsActionResultModel.ok() : success = true, error = null;
  const DetailsActionResultModel.fail(this.error) : success = false;
}

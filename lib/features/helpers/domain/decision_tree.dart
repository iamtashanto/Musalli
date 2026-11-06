/// Generic data-driven decision tree model for Islamic fiqh assistants.
class DecisionOption {
  const DecisionOption({
    required this.label,
    required this.description,
    this.nextNodeId,
    this.result,
  }) : assert(
         nextNodeId != null || result != null,
         'DecisionOption must provide either nextNodeId or result',
       );

  /// Label shown on the choice button.
  final String label;

  /// Explanatory guidance for this choice.
  final String description;

  /// The next question node ID, if branch continues.
  final String? nextNodeId;

  /// Final resolution result if this option terminates the tree.
  final DecisionResult? result;
}

/// Final resolution result from an interactive decision tree.
class DecisionResult {
  const DecisionResult({
    required this.title,
    required this.verdict,
    required this.explanation,
    required this.actionSteps,
    required this.reference,
    this.requiresSajdaSahu = false,
    this.invalidatesSalah = false,
    this.needsReview = false,
  });

  /// Short headline of the result.
  final String title;

  /// Primary verdict (e.g. "সাহু সিজদা ওয়াজিব", "নামাজ বাতিল (পুনরায় পড়তে হবে)", "কোনো কিছু লাগবে না").
  final String verdict;

  /// Detailed fiqh explanation in Bangla.
  final String explanation;

  /// Step-by-step instructions for what to do right now.
  final List<String> actionSteps;

  /// Authoritative reference citation (e.g. "রদ্দুল মুহতার ২/৭৮", "সহীহ বুখারী ৪০১").
  final String reference;

  /// Whether Sajda Sahu is required.
  final bool requiresSajdaSahu;

  /// Whether the prayer was invalidated and must be repeated.
  final bool invalidatesSalah;

  /// Flagged if secondary scholars review is suggested.
  final bool needsReview;
}

/// A single step/question node in the decision tree.
class DecisionNode {
  const DecisionNode({
    required this.id,
    required this.question,
    required this.hint,
    required this.options,
  });

  final String id;
  final String question;
  final String hint;
  final List<DecisionOption> options;
}

class WeeklyWorkActivity {
  final String activityName;
  final String pOne;
  final String aOne;

  final String pTwo;
  final String aTwo;

  final String pThree;
  final String aThree;

  final String pFour;
  final String aFour;

  final String pFive;
  final String aFive;

  final String pSix;
  final String aSix;

  final String pSeven;
  final String aSeven;

  final String remarks;
  final String status;

  const WeeklyWorkActivity({
    required this.activityName,
    required this.pOne,
    required this.aOne,
    required this.pTwo,
    required this.aTwo,
    required this.pThree,
    required this.aThree,
    required this.pFour,
    required this.aFour,
    required this.pFive,
    required this.aFive,
    required this.pSix,
    required this.aSix,
    required this.pSeven,
    required this.aSeven,
    required this.remarks,
    required this.status,
  });

  WeeklyWorkActivity update({
    String? activityName,
    String? pOne,
    String? aOne,
    String? pTwo,
    String? aTwo,
    String? pThree,
    String? aThree,
    String? pFour,
    String? aFour,
    String? pFive,
    String? aFive,
    String? pSix,
    String? aSix,
    String? pSeven,
    String? aSeven,
    String? remarks,
    String? status,
  }) =>
      WeeklyWorkActivity(
        activityName: activityName ?? this.activityName,
        pOne: pOne ?? this.pOne,
        aOne: aOne ?? this.aOne,
        pTwo: pTwo ?? this.pTwo,
        aTwo: aTwo ?? this.aTwo,
        pThree: pThree ?? this.pThree,
        aThree: aThree ?? this.aThree,
        pFour: pFour ?? this.pFour,
        aFour: aFour ?? this.aFour,
        pFive: pFive ?? this.pFive,
        aFive: aFive ?? this.aFive,
        pSix: pSix ?? this.pSix,
        aSix: aSix ?? this.aSix,
        pSeven: pSeven ?? this.pSeven,
        aSeven: aSeven ?? this.aSeven,
        remarks: remarks ?? this.remarks,
        status: status ?? this.status,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyWorkActivity &&
          runtimeType == other.runtimeType &&
          activityName == other.activityName &&
          pOne == other.pOne &&
          aOne == other.aOne &&
          pTwo == other.pTwo &&
          aTwo == other.aTwo &&
          pThree == other.pThree &&
          aThree == other.aThree &&
          pFour == other.pFour &&
          aFour == other.aFour &&
          pFive == other.pFive &&
          aFive == other.aFive &&
          pSix == other.pSix &&
          aSix == other.aSix &&
          pSeven == other.pSeven &&
          aSeven == other.aSeven &&
          remarks == other.remarks &&
          status == other.status;

  @override
  int get hashCode =>
      activityName.hashCode ^
      pOne.hashCode ^
      aOne.hashCode ^
      pTwo.hashCode ^
      aTwo.hashCode ^
      pThree.hashCode ^
      aThree.hashCode ^
      pFour.hashCode ^
      aFive.hashCode ^
      pFour.hashCode ^
      aSix.hashCode ^
      aSix.hashCode ^
      pSeven.hashCode ^
      aSeven.hashCode ^
      remarks.hashCode ^
      status.hashCode;
}

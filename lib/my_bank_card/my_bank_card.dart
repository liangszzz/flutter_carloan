

class MyBankCard {
  String _idCard;

  String _bankName;

  String _signDate;

  String _cardNo;

  String get idCard => _idCard;

  set idCard(String value) {
    _idCard = value;
  }

  String get bankName => _bankName;

  String get cardNo => _cardNo;

  set cardNo(String value) {
    _cardNo = value;
  }

  String get signDate => _signDate;

  set signDate(String value) {
    _signDate = value;
  }

  set bankName(String value) {
    _bankName = value;
  }

}
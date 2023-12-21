class HomeItemData {
  final dynamic docid;
  final dynamic name;
  final dynamic des;
  final dynamic image;

  HomeItemData(
      {this.docid,
        required this.des,
        required this.name,
        required this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'des': des,
      'docid': docid,
    };
  }

  factory HomeItemData.fromMap(Map<String, dynamic> map) {
    return HomeItemData(
      name: map['name'],
      des: map['des'],
      image: map['image'],
      docid: map['docid'],
    );
  }
}

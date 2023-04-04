class Source{
  String id, name;
  Source({required this.id, required this.name});
  factory Source.fromJson(Map<String, dynamic> json){
    return Source(id: json['id']?? 'Id',name: json['name']?? 'Name');
  }
}
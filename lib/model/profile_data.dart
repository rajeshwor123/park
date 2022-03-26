class Profile{

  final String userName ;
  final String email;
  final String phone;

  Profile(this.userName , this.email ,this.phone);

  factory Profile.fromJson(Map<String,dynamic> data){
    return  Profile(data['userName'],data['email'],data['phone']);
  }

}
class Profile{

  final String userName ;
  final String email;
  final String phone;
  final double? latitude ;
  final double? longitude ;
  final String? bikePrice ;
  final String? carPrice ;
  final String? truckPrice ;
  final String? isAvailable;
  final String? cyclePrice;

  Profile(this.userName , this.email ,this.phone, this.latitude, this.longitude, this.bikePrice, this.carPrice, this.truckPrice, this.isAvailable,this.cyclePrice);

  factory Profile.fromJson(Map<String,dynamic> data){
    return  Profile(data['userName'],data['email'],data['phone'],data['latitude'],data['longitude'],data['bikePrice'],data['carPrice'],data['truckPrice'],data['isAvailable'],data['cyclePrice']);
  }

}
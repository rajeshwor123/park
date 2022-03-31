class Profile{

   String? userPassword;
   String? userName ;
   String? email;
   String? phone;
   String? latitude ;
   String? longitude ;
   String? bikePrice ;
   String? carPrice ;
   String? truckPrice ;
   String? isAvailable;
   String? cyclePrice;

  Profile(this.userName ,this.userPassword, this.email ,this.phone, this.latitude, this.longitude, this.bikePrice, this.carPrice, this.truckPrice, this.isAvailable,this.cyclePrice);

  factory Profile.fromJson(Map<String,dynamic> data){
    return  Profile(data['userName'],data['userPassword'],data['email'],data['phone'],data['latitude'],data['longitude'],data['bikePrice'],data['carPrice'],data['truckPrice'],data['isAvailable'],data['cyclePrice']);
  }

}
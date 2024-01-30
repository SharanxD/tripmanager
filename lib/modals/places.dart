class places {
  places(
      {required this.PlaceName,
      required this.PlaceLocation,
      required this.visited,
      required this.datevisited,
      required this.imageurl,
      required this.remarks});
  final String PlaceName;
  final String PlaceLocation;
  final bool visited;
  final String datevisited;
  final String remarks;
  final String imageurl;
}

List<places> example = [
  places(
      PlaceName: "Somnath Main temple",
      PlaceLocation: "Somnath",
      visited: false,
      datevisited: "",
      imageurl: "",
      remarks: ""),
  places(
      PlaceName: "Dwarka temple",
      PlaceLocation: "Dwarka",
      visited: false,
      datevisited: "",
      imageurl: "",
      remarks: "Nicee"),
  places(
      PlaceName: "Dwarka temple",
      PlaceLocation: "Dwarka",
      visited: true,
      datevisited: "2024-1-14",
      imageurl:
          "https://i.pinimg.com/originals/d4/9c/8a/d49c8abb59f1a14e88c38ed6b2dbd9e4.jpg",
      remarks: "Nicee"),
  places(
      PlaceName: "Statue of Unity",
      PlaceLocation: "Kevadia",
      visited: true,
      datevisited: "2024-1-15",
      imageurl:
          "https://images.unsplash.com/photo-1631983097767-099c77bf880d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c3RhdHVlJTIwb2YlMjB1bml0eXxlbnwwfHwwfHx8MA%3D%3D",
      remarks: "Coooool")
];

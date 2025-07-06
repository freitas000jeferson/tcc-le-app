import 'package:flutter/material.dart';

class FirstClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var firstControlPoint = Offset(size.width * 0.25, size.height - 120);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 30);

    var secondControlPoint = Offset(
      size.width - (size.width / 4),
      size.height + 20,
    );
    var secondEndPoint = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SecondClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);

    var firstControlPoint = Offset(size.width * 0.1, size.height + 30);
    var firstEndPoint = Offset(size.width * 0.4, size.height - 50);

    var secondControlPoint = Offset(size.width * 0.7, size.height - 150);
    var secondEndPoint = Offset(size.width * 0.75, size.height * 1);

    var tertiaryControlPoint = Offset(size.width * 0.92, size.height - 80);
    var tertiaryEndPoint = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.quadraticBezierTo(
      tertiaryControlPoint.dx,
      tertiaryControlPoint.dy,
      tertiaryEndPoint.dx,
      tertiaryEndPoint.dy,
    );

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class TertiaryClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    var firstCP1 = Offset(size.width * 0.35, size.height - 150);
    var firstCP2 = Offset(size.width * 0.18, size.height * 1);
    var firstEP = Offset(size.width * 0.55, size.height);

    var secondCP1 = Offset(size.width * 0.2, size.height - 140);
    var secondCP2 = Offset(size.width * 0.75, size.height - 110);
    var secondEP = Offset(size.width * 0.82, size.height - 40);

    var tertiaryCP1 = Offset(size.width * 0.95, size.height - 180);
    var tertiaryEP = Offset(size.width, size.height);

    path.cubicTo(
      firstCP1.dx,
      firstCP1.dy,
      firstCP2.dx,
      firstCP2.dy,
      firstEP.dx,
      firstEP.dy,
    );

    path.cubicTo(
      secondCP1.dx,
      secondCP1.dy,
      secondCP2.dx,
      secondCP2.dy,
      secondEP.dx,
      secondEP.dy,
    );

    path.quadraticBezierTo(
      tertiaryCP1.dx,
      tertiaryCP1.dy,
      tertiaryEP.dx,
      tertiaryEP.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

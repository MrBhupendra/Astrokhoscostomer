import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../../utill/vastu_strings.dart';
import '../../../widget/custom_app_bar.dart';

class OfficeVastuZoneDetail extends StatelessWidget {
  String type;
  OfficeVastuZoneDetail(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: type.tr),
        body: Compass(type),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  String type;

  Compass(this.type, {super.key = const Key('defaultKey')});

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with SingleTickerProviderStateMixin {
  double _heading = 0;
  bool _showGoodMessage = false;
  bool _showBadMessage = false;
  bool _showNeutralMessage = false;
  String get _readout => '${(_heading % 359).toStringAsFixed(0)}°';
  String homeEffect = "";
  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void initState() {
    super.initState();
    _compassSubscription = FlutterCompass.events?.listen(_onData);
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  void _onData(CompassEvent event) {
    if (mounted) {
      setState(() {
        _heading = event.heading!;
        _showGoodBadMessage(double.parse(_readout.replaceAll('°', '')), widget.type);
      });
    }
  }

  String _showGoodBadMessage(double degree, String type) {
    if (type == "Account Department") {
      _showBadMessage =
          (degree >= 34 && degree <= 123) || (degree >= 192 && degree <= 213) || (degree >= 282 && degree <= 348);
      _showGoodMessage =
          (degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 33) || (degree >= 124 && degree <= 191) || (degree >= 214 && degree <= 281);
    }
    else if (type == "Basement Office") {
      _showBadMessage =
          (degree >= 79 && degree <= 326);
      _showGoodMessage =
          (degree >= 327 && degree <= 360) || (degree >= 0 && degree <= 78);
    }
    else if (type == "Computer Table") {
      _showBadMessage =
          (degree >= 192 && degree <= 213) || (degree >= 282 && degree <= 348);
      _showGoodMessage =
          (degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 191)|| (degree >= 214 && degree <= 281);
    }
    else if (type == "CEO Room") {
      _showBadMessage =
          (degree >= 34 && degree <= 78) ||
              (degree >= 102 && degree <= 123) ||
              (degree >= 192 && degree <= 213) ||
              (degree >= 282 && degree <= 326);
      _showGoodMessage =
          (degree >= 0 && degree <= 33) ||
              (degree >= 79 && degree <= 101) ||
              (degree >= 124 && degree <= 191) ||
              (degree >= 214 && degree <= 236) ||
              (degree >= 259 && degree <= 281) ||
              (degree >= 327 && degree <= 360);
      _showNeutralMessage = (degree >= 237 && degree <= 258);
    }
    else if (type == "Marketing department") {
      _showBadMessage =
          (degree >= 34 && degree <= 78) ||
              (degree >= 102 && degree <= 123) ||
              (degree >= 192 && degree <= 213) ||
              (degree >= 282 && degree <= 303);
      _showGoodMessage =
          (degree >= 0 && degree <= 33) ||
              (degree >= 79 && degree <= 101) ||
              (degree >= 124 && degree <= 191) ||
              (degree >= 214 && degree <= 281) ||
              (degree >= 304 && degree <= 360);
    }
    else if (type == "Entrance/Main Door") {
      _showBadMessage =
          (degree >= 0 && degree <= 22) ||
              (degree >= 56 && degree <= 78) ||
              (degree >= 90 && degree <= 112) ||
              (degree >= 135 && degree <= 192) ||
              (degree >= 225 && degree <= 292) ||
              (degree >= 326 && degree <= 360);
      _showGoodMessage =
          (degree >= 23 && degree <= 55) ||
              (degree >= 79 && degree <= 89) ||
              (degree >= 113 && degree <= 134) ||
              (degree >= 193 && degree <= 224) ||
              (degree >= 293 && degree <= 325);
    }
    else if (type == "Drinking Water") {
      _showBadMessage =
              (degree >= 102 && degree <= 258) ||
              (degree >= 282 && degree <= 303);
      _showGoodMessage =
              (degree >= 0 && degree <= 101) ||
              (degree >= 259 && degree <= 281) ||
              (degree >= 304 && degree <= 360);
    }
    else if (type == "Purchase Department") {
      _showBadMessage =
          (degree >= 34 && degree <= 56) ||
              (degree >= 102 && degree <= 123)||
              (degree >= 192 && degree <= 213)||
              (degree >= 282 && degree <= 303);
      _showGoodMessage =
          (degree >= 0 && degree <= 33) ||
              (degree >= 57 && degree <= 101) ||
              (degree >= 124 && degree <= 191)||
              (degree >= 214 && degree <= 281)||
              (degree >= 304 && degree <= 360);
    }
    else if (type == "RND Department") {
      _showBadMessage =
              (degree >= 34 && degree <= 56) ||
              (degree >= 124 && degree <= 146)||
              (degree >= 192 && degree <= 213)||
                  (degree >= 282 && degree <= 303);
      _showGoodMessage =
              (degree >= 0 && degree <= 33) ||
              (degree >= 57 && degree <= 123)||
              (degree >= 147 && degree <= 191)||
                  (degree >= 214 && degree <= 281)||
                  (degree >= 304 && degree <= 360);
    }
    else if (type == "Office Reception") {
      _showBadMessage =
              (degree >= 34 && degree <= 56) ||
              (degree >= 102 && degree <= 123)||
                  (degree >= 192 && degree <= 213)||
                  (degree >= 282 && degree <= 303);
      _showGoodMessage =
          (degree >= 0 && degree <= 33) ||
          (degree >= 57 && degree <= 101)||
              (degree >= 124 && degree <= 191)||
              (degree >= 214 && degree <= 281)||
              (degree >= 304 && degree <= 360);
    }
    else if (type == "Waiting Room") {
      _showBadMessage =
          (degree >= 79 && degree <= 168) || (degree >= 192 && degree <= 213);
      _showGoodMessage =
          (degree >= 0 && degree <= 78) || (degree >= 169 && degree <= 191) || (degree >= 214 && degree <= 360);
    }
    else if (type == "Washroom Office") {
      _showBadMessage =
              (degree >= 0 && degree <= 101) ||
              (degree >= 124 && degree <= 191) ||
              (degree >= 214 && degree <= 281) ||
                  (degree >= 304 && degree <= 360);
      _showGoodMessage =
              (degree >= 102 && degree <= 123) ||
              (degree >= 192 && degree <= 213) ||
                  (degree >= 282 && degree <= 303);
    }
    else if (type == "Dustbin Office") {
      _showBadMessage =
              (degree >= 0 && degree <= 101) ||
              (degree >= 124 && degree <= 191) ||
              (degree >= 214 && degree <= 281) ||
              (degree >= 304 && degree <= 360);
      _showGoodMessage =
              (degree >= 102 && degree <= 123) ||
              (degree >= 192 && degree <= 213) ||
              (degree >= 282 && degree <= 303);
    }
    else if (type == "Weight Machine") {
      _showBadMessage =
          (degree >= 11 && degree <= 101) ||
              (degree >= 124 && degree <= 213) ||
              (degree >= 282 && degree <= 348);
      _showGoodMessage =
          (degree >= 0 && degree <= 10) || (degree >= 102 && degree <= 123) ||
              (degree >= 214 && degree <= 281) ||
              (degree >= 349 && degree <= 360);
    }
    else if (type == "Staircase") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    }
    else if (type == "Inverter") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    }
    else if (type == "Ac") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    }
    else if (type == "Electric meter") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    }
    else if (type == "Watch") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    }

    else {
      return ' ';
    }
    return '';
  }

  String getEffect(double degree, String type) {
    if (type == "Account Department") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.accountDepartment1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.accountDepartment2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.accountDepartment3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.accountDepartment4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.accountDepartment5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.accountDepartment6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.accountDepartment7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.accountDepartment8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.accountDepartment9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.accountDepartment10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.accountDepartment11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.accountDepartment12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.accountDepartment13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.accountDepartment14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.accountDepartment15.tr;
      } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
        return VastuStrings.accountDepartment16.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Basement Office") {
      if (degree >= 11 && degree <= 33) {
      return VastuStrings.basementOffice1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.basementOffice2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.basementOffice3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.basementOffice4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.basementOffice5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.basementOffice6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.basementOffice7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.basementOffice8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.basementOffice9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.basementOffice10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.basementOffice11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.basementOffice12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.basementOffice13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.basementOffice14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.basementOffice15.tr;
    } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
      return VastuStrings.basementOffice16.tr;
    } else {
      return ' ';
    }}
    else if (type == "Computer Table"){
      if (degree >= 11 && degree <= 33) {
      return VastuStrings.computerTable1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.computerTable2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.computerTable3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.computerTable4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.computerTable5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.computerTable6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.computerTable7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.computerTable8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.computerTable9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.computerTable10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.computerTable11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.computerTable12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.computerTable13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.computerTable14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.computerTable15.tr;
    } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
      return VastuStrings.computerTable16.tr;
    } else {
      return ' ';
    }
    }
    else if (type == "CEO Room") {if (degree >= 11 && degree <= 33) {
      return VastuStrings.ceoRoom1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.ceoRoom2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.ceoRoom3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.ceoRoom4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.ceoRoom5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.ceoRoom6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.ceoRoom7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.ceoRoom8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.ceoRoom9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.ceoRoom10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.ceoRoom11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.ceoRoom12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.ceoRoom13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.ceoRoom14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.ceoRoom15.tr;
    } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
      return VastuStrings.ceoRoom16.tr;
    } else {
      return ' ';
    }

    }
    else if(type == "Marketing department"){
      if (degree >= 11 && degree <= 33) {
      return VastuStrings.marketingDepartment1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.marketingDepartment2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.marketingDepartment3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.marketingDepartment4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.marketingDepartment5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.marketingDepartment6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.marketingDepartment7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.marketingDepartment8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.marketingDepartment9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.marketingDepartment10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.marketingDepartment11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.marketingDepartment12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.marketingDepartment13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.marketingDepartment14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.marketingDepartment15.tr;
    } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
      return VastuStrings.marketingDepartment16.tr;
    } else {
      return ' ';
    }
    }
    else if(type == "Entrance/Main Door"){
      if (degree >= 0 && degree <= 11) {
      return VastuStrings.entranceMainDoor1.tr;
    } else if (degree >= 11 && degree <= 22) {
      return VastuStrings.entranceMainDoor2.tr;
    } else if (degree >= 23 && degree <= 33) {
      return VastuStrings.entranceMainDoor3.tr;
    } else if (degree >= 34 && degree <= 44) {
      return VastuStrings.entranceMainDoor4.tr;
    } else if (degree >= 45 && degree <= 55) {
      return VastuStrings.entranceMainDoor5.tr;
    } else if (degree >= 56 && degree <= 67) {
      return VastuStrings.entranceMainDoor6.tr;
    } else if (degree >= 68 && degree <= 78) {
      return VastuStrings.entranceMainDoor7.tr;
    } else if (degree >= 79 && degree <= 89) {
      return VastuStrings.entranceMainDoor8.tr;
    } else if (degree >= 90 && degree <= 102) {
      return VastuStrings.entranceMainDoor9.tr;
    } else if (degree >= 103 && degree <= 112) {
      return VastuStrings.entranceMainDoor10.tr;
    } else if (degree >= 113 && degree <= 123) {
      return VastuStrings.entranceMainDoor11.tr;
    } else if (degree >= 124 && degree <= 134) {
      return VastuStrings.entranceMainDoor12.tr;
    } else if (degree >= 135 && degree <= 146) {
      return VastuStrings.entranceMainDoor13.tr;
    } else if (degree >= 147 && degree <= 157) {
      return VastuStrings.entranceMainDoor14.tr;
    } else if (degree >= 158 && degree <= 169) {
      return VastuStrings.entranceMainDoor15.tr;
    } else if (degree >= 170 && degree <= 180) {
      return VastuStrings.entranceMainDoor16.tr;
    } else if (degree >= 181 && degree <= 192) {
      return VastuStrings.entranceMainDoor17.tr;
    } else if (degree >= 193 && degree <= 202) {
      return VastuStrings.entranceMainDoor18.tr;
    } else if (degree >= 203 && degree <= 213) {
      return VastuStrings.entranceMainDoor19.tr;
    } else if (degree >= 214 && degree <= 224) {
      return VastuStrings.entranceMainDoor20.tr;
    } else if (degree >= 225 && degree <= 236) {
      return VastuStrings.entranceMainDoor21.tr;
    } else if (degree >= 237 && degree <= 247) {
      return VastuStrings.entranceMainDoor22.tr;
    } else if (degree >= 248 && degree <= 258) {
      return VastuStrings.entranceMainDoor23.tr;
    } else if (degree >= 259 && degree <= 270) {
      return VastuStrings.entranceMainDoor24.tr;
    } else if (degree >= 271 && degree <= 281) {
      return VastuStrings.entranceMainDoor25.tr;
    } else if (degree >= 282 && degree <= 292) {
      return VastuStrings.entranceMainDoor26.tr;
    } else if (degree >= 293 && degree <= 303) {
      return VastuStrings.entranceMainDoor27.tr;
    } else if (degree >= 304 && degree <= 314) {
      return VastuStrings.entranceMainDoor28.tr;
    } else if (degree >= 315 && degree <= 325) {
      return VastuStrings.entranceMainDoor29.tr;
    } else if (degree >= 326 && degree <= 337) {
      return VastuStrings.entranceMainDoor30.tr;
    } else if (degree >= 338 && degree <= 348) {
      return VastuStrings.entranceMainDoor31.tr;
    } else if (degree >= 349 && degree <= 360) {
      return VastuStrings.entranceMainDoor32.tr;
    } else {
      return ' ';
    }
    }
    else if (type == "Drinking Water"){
      if (degree >= 11 && degree <= 33) {
      return VastuStrings.drinkingWater1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.drinkingWater2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.drinkingWater3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.drinkingWater4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.drinkingWater5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.drinkingWater6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.drinkingWater7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.drinkingWater8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.drinkingWater9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.drinkingWater10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.drinkingWater11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.drinkingWater12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.drinkingWater13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.drinkingWater14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.drinkingWater15.tr;
    } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
      return VastuStrings.drinkingWater16.tr;
    } else {
      return ' ';
    }

    }
    else if(type == "Purchase Department"){
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.purchaseDepartment1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.purchaseDepartment2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.purchaseDepartment3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.purchaseDepartment4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.purchaseDepartment5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.purchaseDepartment6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.purchaseDepartment7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.purchaseDepartment8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.purchaseDepartment9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.purchaseDepartment10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.purchaseDepartment11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.purchaseDepartment12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.purchaseDepartment13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.purchaseDepartment14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.purchaseDepartment15.tr;
      } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.purchaseDepartment16.tr;
      } else {
        return ' ';
      }
    }
    else if(type == "RND Department"){
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.rndDepartment1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.rndDepartment2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.rndDepartment3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.rndDepartment4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.rndDepartment5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.rndDepartment6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.rndDepartment7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.rndDepartment8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.rndDepartment9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.rndDepartment10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.rndDepartment11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.rndDepartment12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.rndDepartment13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.rndDepartment14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.rndDepartment15.tr;
      } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
        return VastuStrings.rndDepartment16.tr;
      } else {
        return ' ';
      }
    }
    else if(type == "Office Reception"){
      if (degree >= 11 && degree <= 33) {
      return VastuStrings.officeReception1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.officeReception2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.officeReception3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.officeReception4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.officeReception5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.officeReception6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.officeReception7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.officeReception8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.officeReception9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.officeReception10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.officeReception11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.officeReception12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.officeReception13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.officeReception14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.officeReception15.tr;
    } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
      return VastuStrings.officeReception16.tr;
    } else {
      return ' ';
    }

    }
    else if(type == "Waiting Room"){
      if (degree >= 11 && degree <= 33) {
      return VastuStrings.waitingRoom1.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.waitingRoom2.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.waitingRoom3.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.waitingRoom4.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.waitingRoom5.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.waitingRoom6.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.waitingRoom7.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.waitingRoom8.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.waitingRoom9.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.waitingRoom10.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.waitingRoom11.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.waitingRoom12.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.waitingRoom13.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.waitingRoom14.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.waitingRoom15.tr;
    } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
      return VastuStrings.waitingRoom16.tr;
    } else {
      return ' ';
    }
    }
    else if(type == "Washroom Office"){
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.washroomOffice1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.washroomOffice2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.washroomOffice3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.washroomOffice4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.washroomOffice5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.washroomOffice6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.washroomOffice7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.washroomOffice8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.washroomOffice9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.washroomOffice10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.washroomOffice11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.washroomOffice12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.washroomOffice13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.washroomOffice14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.washroomOffice15.tr;
      } else if ((degree >= 349 && degree <= 360) || (degree >= 0 && degree <= 10)) {
        return VastuStrings.washroomOffice16.tr;
      } else {
        return ' ';
      }

    }
    else if(type == "Dustbin Office"){
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.dustbinOffice1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.dustbinOffice2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.dustbinOffice3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.dustbinOffice4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.dustbinOffice5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.dustbinOffice6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.dustbinOffice7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.dustbinOffice8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.dustbinOffice9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.dustbinOffice10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.dustbinOffice11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.dustbinOffice12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.dustbinOffice13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.dustbinOffice14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.dustbinOffice15.tr;
      } else if ((degree >= 349 && degree <= 360) ||
          degree >= 0 && degree <= 10) {
        return VastuStrings.dustbinOffice16.tr;
      } else {
        return ' ';
      }
    }
    else if(type == "Weight Machine"){
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.weightMachine1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.weightMachine2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return  VastuStrings.weightMachine3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return  VastuStrings.weightMachine4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return  VastuStrings.weightMachine5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return  VastuStrings.weightMachine6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return  VastuStrings.weightMachine7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return  VastuStrings.weightMachine8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return  VastuStrings.weightMachine9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return  VastuStrings.weightMachine10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return  VastuStrings.weightMachine11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return  VastuStrings.weightMachine12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return  VastuStrings.weightMachine13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return  VastuStrings.weightMachine14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return  VastuStrings.weightMachine15.tr;
      } else if ((degree >= 349 && degree <= 360) ||
          degree >= 0 && degree <= 10) {
        return  VastuStrings.weightMachine16.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Staircase") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.staircase1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.staircase2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.staircase3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.staircase4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.staircase5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.staircase6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.staircase7.tr; } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.staircase8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.staircase9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.staircase10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.staircase11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.staircase12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.staircase13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.staircase14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.staircase15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.staircase16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Inverter") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.inverter1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.inverter2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.inverter3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.inverter4.tr; } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.inverter5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.inverter6.tr; } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.inverter7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.inverter8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.inverter9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.inverter10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.inverter11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.inverter12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.inverter13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.inverter14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.inverter15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.inverter16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Ac") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.ac1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.ac2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.ac3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.ac4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.ac5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.ac6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.ac7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.ac8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.ac9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.ac10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.ac11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.ac12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.ac13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.ac14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.ac15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.ac16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Electric meter") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.electricMeter1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.electricMeter2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.electricMeter3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.electricMeter4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.electricMeter5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.electricMeter6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.electricMeter7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.electricMeter8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.electricMeter9.tr; } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.electricMeter10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.electricMeter11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.electricMeter12.tr; } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.electricMeter13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.electricMeter14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.electricMeter15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.electricMeter16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Watch") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.watch1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.watch2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.watch3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.watch4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.watch5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.watch6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.watch7.tr; } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.watch8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.watch9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.watch10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.watch11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.watch12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.watch13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.watch14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.watch15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.watch16.tr;} else {
        return ' ';
      }
    }
    else {
      return ' ';
    }
  }

  String getDirection(double degree) {
    if (degree >= 0 && degree <= 11) {
      return VastuStrings.north.tr;
    } else if (degree >= 11 && degree <= 33) {
      return VastuStrings.nne.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.ne.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.ene.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.east.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.ese.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.se.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.sse.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.south.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.ssw.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.sw.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.wsw.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.west.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.wnw.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.nw.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.nnw.tr;
    } else if (degree >= 349 && degree <= 360) {
      return VastuStrings.north.tr;
    } else {
      return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    String direction = getDirection(double.parse(_readout.replaceAll('°', '')));
    String effect = getEffect(double.parse(_readout.replaceAll('°', '')), widget.type);

    return SingleChildScrollView(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                // height: 354,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -_heading * (pi / 180),
                          child: Image.asset(
                            Images.oriCompass,
                            height: 350,
                            width: 350,
                          ),
                        ),
                        Positioned(
                          bottom: 75, // Set left to 0 to center horizontally
                          child: Column(
                            children: [
                              const Align(alignment: Alignment.topCenter),
                              Container(
                                padding: const EdgeInsets.only(bottom: 35),
                                child: Icon(
                                  Icons.arrow_drop_up_outlined,
                                  // Replace with the desired icon
                                  color: ColorResources.compassArrow,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Add some space between the icon and text
                              Container(
                                padding: const EdgeInsets.only(bottom: 30, left: 9),
                                child: Text(
                                  '$_readout\n$direction',
                                  textAlign: TextAlign.center,
                                  // Center the text horizontally
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_showGoodMessage) // Display the message conditionally
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.greenTransparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          VastuStrings.good.tr,
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    if (_showBadMessage) // Display the message conditionally
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.redTransparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          VastuStrings.bad.tr,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    if (_showNeutralMessage) // Display the message conditionally
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.blueTransparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          VastuStrings.neutral.tr,
                          style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: ColorResources.effectText,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.effectBg,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                VastuStrings.effects.tr,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          child: Text(
                            textAlign: TextAlign.center,
                            effect,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

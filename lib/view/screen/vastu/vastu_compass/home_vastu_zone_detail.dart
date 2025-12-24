import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../../utill/vastu_strings.dart';
import '../../../widget/custom_app_bar.dart';

class HomeVastuZoneDetail extends StatelessWidget {
  String type;

  HomeVastuZoneDetail(this.type, {super.key});

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
  bool _showWorstMessage = false;
  bool _showTreatment = false;

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
        _updateGoodMessage(
            double.parse(_readout.replaceAll('°', '')), widget.type);
      });
    }
  }

  String _updateGoodMessage(double degree, String type) {
    if (type == "Home Entrance") {
      _showBadMessage = (degree >= 0 && degree <= 33) ||
          (degree >= 45 && degree <= 67) ||
          (degree >= 90 && degree <= 146) ||
          (degree >= 180 && degree <= 247) ||
          (degree >= 270 && degree <= 337);
      _showGoodMessage = (degree >= 34 && degree <= 44) ||
          (degree >= 68 && degree <= 89) ||
          (degree >= 147 && degree <= 179) ||
          (degree >= 248 && degree <= 269) ||
          (degree >= 338 && degree <= 359);
    } else if (type == "Kitchen") {
      _showBadMessage = (degree >= 34 && degree <= 56) ||
          (degree >= 192 && degree <= 258) ||
          (degree >= 282 && degree <= 303) ||
          (degree >= 327 && degree <= 348);
      _showGoodMessage =
          (degree >= 124 && degree <= 191) || (degree >= 259 && degree <= 281);
      _showNeutralMessage = (degree >= 0 && degree <= 33) ||
          (degree >= 57 && degree <= 123) ||
          (degree >= 304 && degree <= 326) ||
          (degree >= 349 && degree <= 359);
    } else if (type == "Bed Room") {
      _showBadMessage = (degree >= 34 && degree <= 56) ||
          (degree >= 102 && degree <= 123) ||
          (degree >= 192 && degree <= 213);
      _showGoodMessage = (degree >= 0 && degree <= 33) ||
          (degree >= 57 && degree <= 101) ||
          (degree >= 147 && degree <= 191) ||
          (degree >= 282 && degree <= 303) ||
          (degree >= 327 && degree <= 359);
      _showNeutralMessage = (degree >= 124 && degree <= 146) ||
          (degree >= 214 && degree <= 281) ||
          (degree >= 304 && degree <= 326);
    } else if (type == "Toilet or septic tank") {
      _showBadMessage = (degree >= 0 && degree <= 33) ||
          (degree >= 57 && degree <= 101) ||
          (degree >= 124 && degree <= 191) ||
          (degree >= 237 && degree <= 281) ||
          (degree >= 304 && degree <= 359);
      _showGoodMessage = (degree >= 102 && degree <= 123) ||
          (degree >= 192 && degree <= 213) ||
          (degree >= 282 && degree <= 303);
      _showWorstMessage =
          (degree >= 34 && degree <= 56) || (degree >= 214 && degree <= 236);
    } else if (type == "Dustbin") {
      _showBadMessage = (degree >= 0 && degree <= 33) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 79 && degree <= 101) ||
          (degree >= 124 && degree <= 191) ||
          (degree >= 237 && degree <= 281);
      _showGoodMessage = (degree >= 102 && degree <= 123) ||
          (degree >= 192 && degree <= 213) ||
          (degree >= 282 && degree <= 303);
      _showWorstMessage =
          (degree >= 34 && degree <= 56) || (degree >= 214 && degree <= 236);
      _showNeutralMessage = (degree >= 57 && degree <= 78);
    } else if (type == "Washing Machine") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Temple") {
      _showNeutralMessage =
          (degree >= 0 && degree <= 11) || (degree >= 124 && degree <= 359);
      _showGoodMessage = (degree >= 12 && degree <= 101);
      _showBadMessage = (degree >= 102 && degree <= 123);
    } else if (type == "Servant Room") {
      _showBadMessage = (degree >= 0 && degree <= 10) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Guest Room") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Bar") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Television") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Computer") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Staircase") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Crockery") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Musical Ins Truments") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Heater") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Inverter") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Ac") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Dining Place") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    } else if (type == "Drawing Room") {
      _showBadMessage = (degree >= 0 && degree <= 101) ||
          (degree >= 304 && degree <= 359) ||
          (degree >= 124 && degree <= 281);
      _showGoodMessage =
          (degree >= 102 && degree <= 123) || (degree >= 282 && degree <= 303);
    }
    // Store Room is not available on app
    else if (type == "Store Room") {
    }
    // Store Room is not available on app
    else {
      return ' ';
    }
    return '';
  }

  String getHomeEffect(double degree, String type) {
    if (type == "Home") {
      if (degree >= 0 && degree <= 11) {
        return VastuStrings.home1.tr;
      } else if (degree >= 11 && degree <= 22) {
        return VastuStrings.home2.tr;
      } else if (degree >= 22 && degree <= 33) {
        return VastuStrings.home3.tr;
      } else if (degree >= 34 && degree <= 44) {
        return VastuStrings.home4.tr;
      } else if (degree >= 45 && degree <= 56) {
        return VastuStrings.home5.tr;
      } else if (degree >= 56 && degree <= 67) {
        return VastuStrings.home6.tr;
      } else if (degree >= 68 && degree <= 78) {
        return VastuStrings.home7.tr;
      } else if (degree >= 79 && degree <= 89) {
        return VastuStrings.home8.tr;
      } else if (degree >= 90 && degree <= 102) {
        return VastuStrings.home9.tr;
      } else if (degree >= 103 && degree <= 112) {
        return VastuStrings.home10.tr;
      } else if (degree >= 113 && degree <= 123) {
        return VastuStrings.home11.tr;
      } else if (degree >= 124 && degree <= 134) {
        return VastuStrings.home12.tr;
      } else if (degree >= 135 && degree <= 146) {
        return VastuStrings.home13.tr;
      } else if (degree >= 147 && degree <= 157) {
        return VastuStrings.home14.tr;
      } else if (degree >= 158 && degree <= 169) {
        return VastuStrings.home15.tr;
      } else if (degree >= 170 && degree <= 180) {
        return VastuStrings.home16.tr;
      } else if (degree >= 181 && degree <= 192) {
        return VastuStrings.home17.tr;
      } else if (degree >= 193 && degree <= 202) {
        return VastuStrings.home18.tr;
      } else if (degree >= 203 && degree <= 213) {
        return VastuStrings.home19.tr;
      } else if (degree >= 214 && degree <= 224) {
        return VastuStrings.home20.tr;
      } else if (degree >= 225 && degree <= 236) {
        return VastuStrings.home21.tr;
      } else if (degree >= 237 && degree <= 247) {
        return VastuStrings.home22.tr;
      } else if (degree >= 248 && degree <= 258) {
        return VastuStrings.home23.tr;
      } else if (degree >= 259 && degree <= 270) {
        return VastuStrings.home24.tr;
      } else if (degree >= 271 && degree <= 281) {
        return VastuStrings.home25.tr;
      } else if (degree >= 282 && degree <= 292) {
        return VastuStrings.home26.tr;
      } else if (degree >= 293 && degree <= 303) {
        return VastuStrings.home27.tr;
      } else if (degree >= 304 && degree <= 314) {
        return VastuStrings.home28.tr;
      } else if (degree >= 315 && degree <= 325) {
        return VastuStrings.home29.tr;
      } else if (degree >= 326 && degree <= 337) {
        return VastuStrings.home30.tr;
      } else if (degree >= 338 && degree <= 348) {
        return VastuStrings.home31.tr;
      } else if (degree >= 349 && degree <= 360) {
        return VastuStrings.home32.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Home Entrance") {
      if (degree >= 0 && degree <= 11) {
        return VastuStrings.home1.tr;
      } else if (degree >= 11 && degree <= 22) {
        return VastuStrings.home2.tr;
      } else if (degree >= 22 && degree <= 33) {
        return VastuStrings.home3.tr;
      } else if (degree >= 34 && degree <= 44) {
        return VastuStrings.home4.tr;
      } else if (degree >= 45 && degree <= 56) {
        return VastuStrings.home5.tr;
      } else if (degree >= 56 && degree <= 67) {
        return VastuStrings.home6.tr;
      } else if (degree >= 68 && degree <= 78) {
        return VastuStrings.home7.tr;
      } else if (degree >= 79 && degree <= 89) {
        return VastuStrings.home8.tr;
      } else if (degree >= 90 && degree <= 102) {
        return VastuStrings.home9.tr;
      } else if (degree >= 103 && degree <= 112) {
        return VastuStrings.home10.tr;
      } else if (degree >= 113 && degree <= 123) {
        return VastuStrings.home11.tr;
      } else if (degree >= 124 && degree <= 134) {
        return VastuStrings.home12.tr;
      } else if (degree >= 135 && degree <= 146) {
        return VastuStrings.home13.tr;
      } else if (degree >= 147 && degree <= 157) {
        return VastuStrings.home14.tr;
      } else if (degree >= 158 && degree <= 169) {
        return VastuStrings.home15.tr;
      } else if (degree >= 170 && degree <= 180) {
        return VastuStrings.home16.tr;
      } else if (degree >= 181 && degree <= 192) {
        return VastuStrings.home17.tr;
      } else if (degree >= 193 && degree <= 202) {
        return VastuStrings.home18.tr;
      } else if (degree >= 203 && degree <= 213) {
        return VastuStrings.home19.tr;
      } else if (degree >= 214 && degree <= 224) {
        return VastuStrings.home20.tr;
      } else if (degree >= 225 && degree <= 236) {
        return VastuStrings.home21.tr;
      } else if (degree >= 237 && degree <= 247) {
        return VastuStrings.home22.tr;
      } else if (degree >= 248 && degree <= 258) {
        return VastuStrings.home23.tr;
      } else if (degree >= 259 && degree <= 270) {
        return VastuStrings.home24.tr;
      } else if (degree >= 271 && degree <= 281) {
        return VastuStrings.home25.tr;
      } else if (degree >= 282 && degree <= 292) {
        return VastuStrings.home26.tr;
      } else if (degree >= 293 && degree <= 303) {
        return VastuStrings.home27.tr;
      } else if (degree >= 304 && degree <= 314) {
        return VastuStrings.home28.tr;
      } else if (degree >= 315 && degree <= 325) {
        return VastuStrings.home29.tr;
      } else if (degree >= 326 && degree <= 337) {
        return VastuStrings.home30.tr;
      } else if (degree >= 338 && degree <= 348) {
        return VastuStrings.home31.tr;
      } else if (degree >= 349 && degree <= 360) {
        return VastuStrings.home32.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Kitchen") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.kitchen1.tr;
      } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.kitchen2.tr;
      } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.kitchen3.tr;
      } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.kitchen4.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.kitchen5.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.kitchen6.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.kitchen7.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.kitchen8.tr;
      } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.kitchen9.tr;
      } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.kitchen10.tr;
      } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.kitchen11.tr;
      } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.kitchen12.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.kitchen13.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.kitchen14.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.kitchen15.tr;
      } else if ((degree >= 349 && degree <= 360) ||
          degree >= 0 && degree <= 10) {
        return VastuStrings.kitchen16.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Bed Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.bedRoom1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.bedRoom2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.bedRoom3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.bedRoom4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.bedRoom5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.bedRoom6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.bedRoom7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.bedRoom8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.bedRoom9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.bedRoom10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.bedRoom11.tr; } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.bedRoom12.tr; } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.bedRoom13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.bedRoom14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.bedRoom15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.bedRoom16.tr; } else {
        return ' ';
      }
    }
    else if (type == "Toilet or septic tank") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.toiletSepticTank1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.toiletSepticTank2.tr; } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.toiletSepticTank3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.toiletSepticTank4.tr; } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.toiletSepticTank5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.toiletSepticTank6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.toiletSepticTank7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.toiletSepticTank8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.toiletSepticTank9.tr; } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.toiletSepticTank10.tr; } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.toiletSepticTank11.tr; } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.toiletSepticTank12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.toiletSepticTank13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.toiletSepticTank14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.toiletSepticTank15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.toiletSepticTank16.tr; } else {
        return ' ';
      }
    }
    else if (type == "Dustbin") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.dustbin1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.dustbin2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.dustbin3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.dustbin4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.dustbin5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.dustbin6.tr; } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.dustbin7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.dustbin8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.dustbin9.tr; } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.dustbin10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.dustbin11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.dustbin12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.dustbin13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.dustbin14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.dustbin15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.dustbin16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Washing Machine") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.washingMachine1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.washingMachine2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.washingMachine3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.washingMachine4.tr; } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.washingMachine5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.washingMachine6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.washingMachine7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.washingMachine8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.washingMachine9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.washingMachine10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.washingMachine11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.washingMachine12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.washingMachine13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.washingMachine14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.washingMachine15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.washingMachine16.tr; } else {
        return ' ';
      }
    }
    else if (type == "Temple") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.temple1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.temple2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.temple3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.temple4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.temple5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.temple6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.temple7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.temple8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.temple9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.temple10.tr; } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.temple11.tr; } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.temple12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.temple13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.temple14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.temple15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.temple16.tr;} else {
        return ' ';
      }
    }
    //no treatment of servant room
    else if (type == "Servant Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.servantRoom1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.servantRoom2.tr; } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.servantRoom3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.servantRoom4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.servantRoom5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.servantRoom6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.servantRoom7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.servantRoom8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.servantRoom9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.servantRoom10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.servantRoom11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.servantRoom12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.servantRoom13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.servantRoom14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.servantRoom15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.servantRoom16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Guest Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.guestRoom1.tr; } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.guestRoom2.tr; } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.guestRoom3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.guestRoom4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.guestRoom5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.guestRoom6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.guestRoom7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.guestRoom8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.guestRoom9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.guestRoom10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.guestRoom11.tr; } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.guestRoom12.tr; } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.guestRoom13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.guestRoom14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.guestRoom15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.guestRoom16.tr;} else {
        return ' ';
      }
    }
    //no treatment of Bar
    else if (type == "Bar") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.bar1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.bar2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.bar3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.bar4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.bar5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.bar6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.bar7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.bar8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.bar9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.bar10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.bar11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.bar12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.bar13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.bar14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.bar15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.bar16.tr;} else {
        return ' ';
      }
    }
    //no treatment of bar
    else if (type == "Television") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.television1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.television2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.television3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.television4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.television5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.television6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.television7.tr; } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.television8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.television9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.television10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.television11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.television12.tr; } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.television13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.television14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.television15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.television16.tr; } else {
        return ' ';
      }
    }
    else if (type == "Computer") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.computer1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.computer2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.computer3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.computer4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.computer5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.computer6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.computer7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.computer8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.computer9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.computer10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.computer11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.computer12.tr; } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.computer13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.computer14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.computer15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.computer16.tr;} else {
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
    //crockery
    //musical instruments
    else if (type == "Heater") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.heater1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.heater2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.heater3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.heater4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.heater5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.heater6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.heater7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.heater8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.heater9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.heater10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.heater11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.heater12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.heater13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.heater14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.heater15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.heater16.tr;} else {
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
    else if (type == "Dining Place") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.diningPlace1.tr; } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.diningPlace2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.diningPlace3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.diningPlace4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.diningPlace5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.diningPlace6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.diningPlace7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.diningPlace8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.diningPlace9.tr; } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.diningPlace10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.diningPlace11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.diningPlace12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.diningPlace13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.diningPlace14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.diningPlace15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.diningPlace16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Drawing Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.drawingRoom1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.drawingRoom2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.drawingRoom3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.drawingRoom4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.drawingRoom5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.drawingRoom6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.drawingRoom7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.drawingRoom8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.drawingRoom9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.drawingRoom10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.drawingRoom11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.drawingRoom12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.drawingRoom13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.drawingRoom14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.drawingRoom15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.drawingRoom16.tr;} else {
        return ' ';
      }
    }
    // Store Room is not available on app
    else if (type == "Store Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.storeRoom1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.storeRoom2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.storeRoom3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.storeRoom4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.storeRoom5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.storeRoom6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.storeRoom7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.storeRoom8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.storeRoom9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.storeRoom10.tr; } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.storeRoom11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.storeRoom12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.storeRoom13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.storeRoom14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.storeRoom15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.storeRoom16.tr;} else {
        return ' ';
      }
    }
    // Store Room is not available on app
    else if (type == "Bore well") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.boreWell1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.boreWell2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.boreWell3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.boreWell4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.boreWell5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.boreWell6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.boreWell7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.boreWell8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.boreWell9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.boreWell10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.boreWell11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.boreWell12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.boreWell13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.boreWell14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.boreWell15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.boreWell16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Mirror") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.mirror1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.mirror2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.mirror3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.mirror4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.mirror5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.mirror6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.mirror7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.mirror8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.mirror9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.mirror10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.mirror11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.mirror12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.mirror13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.mirror14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.mirror15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.mirror16.tr;} else {
        return ' ';
      }
    }
    else if (type == "water tank") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.waterTank1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.waterTank2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.waterTank3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.waterTank4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.waterTank5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.waterTank6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.waterTank7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.waterTank8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.waterTank9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.waterTank10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.waterTank11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.waterTank12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.waterTank13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.waterTank14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.waterTank15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.waterTank16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Basement") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.basement1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.basement2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.basement3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.basement4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.basement5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.basement6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.basement7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.basement8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.basement9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.basement10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.basement11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.basement12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.basement13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.basement14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.basement15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.basement16.tr;} else {
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
    //other from clint ,not in vastuwishdom app
    else if (type == "Study table or library") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.studyTableLibrary1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.studyTableLibrary2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.studyTableLibrary3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.studyTableLibrary4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.studyTableLibrary5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.studyTableLibrary6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.studyTableLibrary7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.studyTableLibrary8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.studyTableLibrary9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.studyTableLibrary10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.studyTableLibrary11.tr; } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.studyTableLibrary12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.studyTableLibrary13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.studyTableLibrary14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.studyTableLibrary15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.studyTableLibrary16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Medicine box") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.medicineBox1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.medicineBox2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.medicineBox3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.medicineBox4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.medicineBox5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.medicineBox6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.medicineBox7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.medicineBox8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.medicineBox9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.medicineBox10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.medicineBox11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.medicineBox12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.medicineBox13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.medicineBox14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.medicineBox15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.medicineBox16.tr; } else {
        return ' ';
      }
    }
    else if (type == "Pets") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.pets1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.pets2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.pets3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.pets4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.pets5.tr; } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.pets6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.pets7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.pets8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.pets9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.pets10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.pets11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.pets12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.pets13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.pets14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.pets15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.pets16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Balcony") {
        if (degree >= 11 && degree <= 33) {
          return VastuStrings.balcony1.tr;} else if (degree >= 34 && degree <= 56) {
          return VastuStrings.balcony2.tr;} else if (degree >= 57 && degree <= 78) {
          return VastuStrings.balcony3.tr;} else if (degree >= 79 && degree <= 101) {
          return VastuStrings.balcony4.tr;} else if (degree >= 102 && degree <= 123) {
          return VastuStrings.balcony5.tr;} else if (degree >= 124 && degree <= 146) {
          return VastuStrings.balcony6.tr;} else if (degree >= 147 && degree <= 168) {
          return VastuStrings.balcony7.tr;} else if (degree >= 169 && degree <= 191) {
          return VastuStrings.balcony8.tr;} else if (degree >= 192 && degree <= 213) {
          return VastuStrings.balcony9.tr;} else if (degree >= 214 && degree <= 236) {
          return VastuStrings.balcony10.tr;} else if (degree >= 237 && degree <= 258) {
          return VastuStrings.balcony11.tr;} else if (degree >= 259 && degree <= 281) {
          return VastuStrings.balcony12.tr;} else if (degree >= 282 && degree <= 303) {
          return VastuStrings.balcony13.tr;} else if (degree >= 304 && degree <= 326) {
          return VastuStrings.balcony14.tr;} else if (degree >= 327 && degree <= 348) {
          return VastuStrings.balcony15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
          return VastuStrings.balcony16.tr;} else {
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
    else if (type == "Garage") {
      if (degree >= 11 && degree <= 168) {
        return VastuStrings.garage1to7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.garage8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.garage9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.garage10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.garage11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.garage12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.garage13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.garage14.tr;} else if ((degree >= 327 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.garage15to16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Garden") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.garden1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.garden2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.garden3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.garden4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.garden5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.garden6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.garden7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.garden8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.garden9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.garden10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.garden11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.garden12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.garden13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.garden14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.garden15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.garden16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Locker") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.locker1.tr; } else if (degree >= 34 && degree <= 56) {
        return VastuStrings.locker2.tr; } else if (degree >= 57 && degree <= 78) {
        return VastuStrings.locker3.tr; } else if (degree >= 79 && degree <= 101) {
        return VastuStrings.locker4.tr; } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.locker5.tr;  } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.locker6.tr; } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.locker7.tr; } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.locker8.tr; } else if (degree >= 192 && degree <= 213) {
        return VastuStrings.locker9.tr; } else if (degree >= 214 && degree <= 236) {
        return VastuStrings.locker10.tr; } else if (degree >= 237 && degree <= 258) {
        return VastuStrings.locker11.tr; } else if (degree >= 259 && degree <= 281) {
        return VastuStrings.locker12.tr;  } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.locker13.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.locker14.tr; } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.locker15.tr; } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.locker16.tr; } else {
        return ' ';
      }
    }
    else {
      return ' ';
    }
  }

  String getHomeTreatment(double degree, String type) {
    if (type == "Home") {
      if (degree >= 0 && degree <= 11) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 11 && degree <= 22) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 22 && degree <= 33) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 34 && degree <= 44) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 45 && degree <= 56) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 56 && degree <= 67) {
        return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
      } else if (degree >= 68 && degree <= 78) {
        return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
      } else if (degree >= 79 && degree <= 89) {
        return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
      } else if (degree >= 90 && degree <= 102) {
        return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
      } else if (degree >= 103 && degree <= 112) {
        return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
      } else if (degree >= 113 && degree <= 123) {
        return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
      } else if (degree >= 124 && degree <= 134) {
        return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
      } else if (degree >= 135 && degree <= 146) {
        return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
      } else if (degree >= 147 && degree <= 157) {
        return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
      } else if (degree >= 158 && degree <= 169) {
        return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
      } else if (degree >= 170 && degree <= 180) {
        return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
      } else if (degree >= 181 && degree <= 192) {
        return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
      } else if (degree >= 193 && degree <= 202) {
        return 'Permanent: Block with Brass Strips, Temporary: Block with Yellow Tape';
      } else if (degree >= 203 && degree <= 213) {
        return 'Permanent: Block with Brass Strips, Temporary: Block with Yellow Tape';
      } else if (degree >= 214 && degree <= 224) {
        return 'Permanent: Block with Brass Strips, Temporary: Block with Yellow Tape';
      } else if (degree >= 225 && degree <= 236) {
        return 'Permanent: Block with Brass Strips, Temporary: Block with Yellow Tape';
      } else if (degree >= 237 && degree <= 247) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 248 && degree <= 258) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 259 && degree <= 270) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 271 && degree <= 281) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 282 && degree <= 292) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 293 && degree <= 303) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 304 && degree <= 314) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 315 && degree <= 325) {
        return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
      } else if (degree >= 326 && degree <= 337) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 338 && degree <= 348) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else if (degree >= 349 && degree <= 360) {
        return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
      } else {
        return ' ';
      }
    }
    // {
    //   if (degree >= 0 && degree <= 55) {
    //     return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
    //   } else if (degree >= 56 && degree <= 123) {
    //     return 'Permanent: Block with Stainless Steel Strips, Temporary: Block with Green Tape';
    //   }  else if (degree >= 124 && degree <= 192) {
    //     return 'Permanent: Block with Copper Strips, Temporary: Block with Red Tape';
    //   }  else if (degree >= 193 && degree <= 236) {
    //     return 'Permanent: Block with Brass Strips, Temporary: Block with Yellow Tape';
    //   }  else if (degree >= 237 && degree <= 348) {
    //     return 'Permanent: Block with Iron Strips, Temporary: Block with White Tape';
    //   } else if (degree >= 349 && degree <= 360) {
    //     return 'Permanent: Block with Aluminium Strips, Temporary: Block with Blue Tape';
    //   } else {
    //     return ' ';
    //   }
    // }
    else if (type == "Home Entrance") {
      if (degree >= 0 && degree <= 11) {
        return VastuStrings.homeTreatment1.tr;} else if (degree >= 11 && degree <= 22) {
        return VastuStrings.homeTreatment2.tr;} else if (degree >= 22 && degree <= 33) {
        return VastuStrings.homeTreatment3.tr;} else if (degree >= 34 && degree <= 44) {
        return VastuStrings.homeTreatment4.tr;} else if (degree >= 45 && degree <= 56) {
        return VastuStrings.homeTreatment5.tr;} else if (degree >= 56 && degree <= 67) {
        return VastuStrings.homeTreatment6.tr;} else if (degree >= 68 && degree <= 78) {
        return VastuStrings.homeTreatment7.tr;} else if (degree >= 79 && degree <= 89) {
        return VastuStrings.homeTreatment8.tr;} else if (degree >= 90 && degree <= 102) {
        return VastuStrings.homeTreatment9.tr;} else if (degree >= 103 && degree <= 112) {
        return VastuStrings.homeTreatment10.tr;} else if (degree >= 113 && degree <= 123) {
        return VastuStrings.homeTreatment11.tr;} else if (degree >= 124 && degree <= 134) {
        return VastuStrings.homeTreatment12.tr;} else if (degree >= 135 && degree <= 146) {
        return VastuStrings.homeTreatment13.tr;} else if (degree >= 147 && degree <= 157) {
        return VastuStrings.homeTreatment14.tr;} else if (degree >= 158 && degree <= 169) {
        return VastuStrings.homeTreatment15.tr;} else if (degree >= 170 && degree <= 180) {
        return VastuStrings.homeTreatment16.tr;} else if (degree >= 181 && degree <= 192) {
        return VastuStrings.homeTreatment17.tr;} else if (degree >= 193 && degree <= 202) {
        return VastuStrings.homeTreatment18.tr;} else if (degree >= 203 && degree <= 213) {
        return VastuStrings.homeTreatment19.tr;} else if (degree >= 214 && degree <= 224) {
        return VastuStrings.homeTreatment20.tr;} else if (degree >= 225 && degree <= 236) {
        return VastuStrings.homeTreatment21.tr;} else if (degree >= 237 && degree <= 247) {
        return VastuStrings.homeTreatment22.tr;} else if (degree >= 248 && degree <= 258) {
        return VastuStrings.homeTreatment23.tr;} else if (degree >= 259 && degree <= 270) {
        return VastuStrings.homeTreatment24.tr;} else if (degree >= 271 && degree <= 281) {
        return VastuStrings.homeTreatment25.tr;} else if (degree >= 282 && degree <= 292) {
        return VastuStrings.homeTreatment26.tr;} else if (degree >= 293 && degree <= 303) {
        return VastuStrings.homeTreatment27.tr;} else if (degree >= 304 && degree <= 314) {
        return VastuStrings.homeTreatment28.tr;} else if (degree >= 315 && degree <= 325) {
        return VastuStrings.homeTreatment29.tr;} else if (degree >= 326 && degree <= 337) {
        return VastuStrings.homeTreatment30.tr;} else if (degree >= 338 && degree <= 348) {
        return VastuStrings.homeTreatment31.tr;} else if (degree >= 349 && degree <= 360) {
        return VastuStrings.homeTreatment32.tr; } else {
        return ' ';
      }
    }
    else if (type == "Kitchen") {
      if (degree >= 11 && degree <= 123) {
        return VastuStrings.kitchenTreatment1.tr;}else if (degree >= 124 && degree <= 146) {
        return VastuStrings.kitchenTreatment2.tr;} else if (degree >= 147 && degree <= 191) {
        return VastuStrings.kitchenTreatment3.tr;} else if (degree >= 192 && degree <= 326) {
        return VastuStrings.kitchenTreatment4.tr;} else if ((degree >= 327 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.kitchenTreatment5.tr;} else {
        return ' ';
      }
    }
    else if (type == "Bed Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.bedRoomTreatment1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.bedRoomTreatment2.tr;} else if (degree >= 57 && degree <= 78) {
        return VastuStrings.bedRoomTreatment3.tr;} else if (degree >= 79 && degree <= 101) {
        return VastuStrings.bedRoomTreatment4.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.bedRoomTreatment5.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.bedRoomTreatment6.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.bedRoomTreatment7.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.bedRoomTreatment8.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.bedRoomTreatment9.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.bedRoomTreatment10.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.bedRoomTreatment11.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.bedRoomTreatment12.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.bedRoomTreatment13.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.bedRoomTreatment14.tr;} else if (degree >= 327 && degree <= 348) {
        return VastuStrings.bedRoomTreatment15.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.bedRoomTreatment16.tr;} else {
        return ' ';
      }
    }
    else if (type == "Toilet or septic tank") {
      if (degree >= 11 && degree <= 56) {
        return VastuStrings.toiletSepticTankTreatment1.tr;} else if (degree >= 57 && degree <= 101) {
        return VastuStrings.toiletSepticTankTreatment2.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.toiletSepticTankTreatment3.tr;} else if (degree >= 124 && degree <= 191) {
        return VastuStrings.toiletSepticTankTreatment4.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.toiletSepticTankTreatment5.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.toiletSepticTankTreatment6.tr;} else if (degree >= 237 && degree <= 281) {
        return VastuStrings.toiletSepticTankTreatment7.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.toiletSepticTankTreatment8.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.toiletSepticTankTreatment9.tr;} else if ((degree >= 327 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.toiletSepticTankTreatment10.tr;} else {
        return ' ';
      }
    }
    else if (type == "Dustbin") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.dustbinTreatment1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.dustbinTreatment2.tr;} else if (degree >= 57 && degree <= 101) {
        return VastuStrings.dustbinTreatment3.tr;} else if (degree >= 102 && degree <= 123) {
        return VastuStrings.dustbinTreatment4.tr;} else if (degree >= 124 && degree <= 191) {
        return VastuStrings.dustbinTreatment5.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.dustbinTreatment6.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.dustbinTreatment7.tr;} else if (degree >= 237 && degree <= 258) {
        return VastuStrings.dustbinTreatment8.tr;} else if (degree >= 259 && degree <= 281) {
        return VastuStrings.dustbinTreatment9.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.dustbinTreatment10.tr; } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.dustbinTreatment11.tr;} else if ((degree >= 327 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.dustbinTreatment12.tr;} else {
        return ' ';
      }
    }
    else if (type == "Staircase") {
      if (degree >= 57 && degree <= 123) {
        return VastuStrings.staircaseTreatment1.tr;
      } else if (degree >= 124 && degree <= 191) {
        return VastuStrings.staircaseTreatment2.tr;
      } else if (degree >= 192 && degree <= 236) {
        return VastuStrings.staircaseTreatment3.tr;
      } else if (degree >= 237 && degree <= 326) {
        return VastuStrings.staircaseTreatment4.tr;
      } else if ((degree >= 327 && degree <= 360) || degree >= 0 && degree <= 56) {
        return VastuStrings.staircaseTreatment3.tr;
      } else {
        return ' ';
      }
    }
    //add this string value in this given blow code string in english
    // add this string value in given blow code's string in hindi
    else if (type == "Store Room") {
      if (degree >= 11 && degree <= 33) {
        return VastuStrings.storeRoomTreatment1.tr;} else if (degree >= 34 && degree <= 56) {
        return VastuStrings.storeRoomTreatment2.tr;} else if (degree >= 57 && degree <= 123) {
        return VastuStrings.storeRoomTreatment3.tr;} else if (degree >= 124 && degree <= 146) {
        return VastuStrings.storeRoomTreatment4.tr;} else if (degree >= 147 && degree <= 168) {
        return VastuStrings.storeRoomTreatment5.tr;} else if (degree >= 169 && degree <= 191) {
        return VastuStrings.storeRoomTreatment6.tr;} else if (degree >= 192 && degree <= 213) {
        return VastuStrings.storeRoomTreatment7.tr;} else if (degree >= 214 && degree <= 236) {
        return VastuStrings.storeRoomTreatment8.tr;} else if (degree >= 237 && degree <= 281) {
        return VastuStrings.storeRoomTreatment9.tr;} else if (degree >= 282 && degree <= 303) {
        return VastuStrings.storeRoomTreatment10.tr;} else if (degree >= 304 && degree <= 326) {
        return VastuStrings.storeRoomTreatment11.tr;} else if ((degree >= 327 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.storeRoomTreatment12.tr;} else {
        return ' ';
      }
    }
    else if (type == "Bore well") {
      if (degree >= 11 && degree <= 101) {
        return VastuStrings.noTreatmentAvailable.tr;} else if (degree >= 102 && degree <= 348) {
        return VastuStrings.boreWellTreatment1.tr;} else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Mirror") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "water tank") {
      if (degree >= 169 && degree <= 303) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else if ((degree >= 304 && degree <= 360) || degree >= 0 && degree <= 168) {
        return VastuStrings.waterTankTreatment1.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Basement") {
      if (degree >= 11 && degree <= 102) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else if (degree >= 102 && degree <= 123) {
        return VastuStrings.basementTreatment1.tr;
      } else if (degree >= 124 && degree <= 146) {
        return VastuStrings.basementTreatment2.tr;
      } else if (degree >= 147 && degree <= 168) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else if (degree >= 169 && degree <= 191) {
        return VastuStrings.basementTreatment3.tr;
      } else if (degree >= 192 && degree <= 236) {
        return VastuStrings.basementTreatment4.tr;
      } else if (degree >= 237 && degree <= 281) {
        return VastuStrings.basementTreatment5.tr;
      } else if (degree >= 282 && degree <= 303) {
        return VastuStrings.basementTreatment6.tr;
      } else if (degree >= 304 && degree <= 326) {
        return VastuStrings.basementTreatment7.tr;
      } else if (degree >= 327 && degree <= 348) {
        return VastuStrings.basementTreatment8.tr;
      } else if ((degree >= 349 && degree <= 360) || degree >= 0 && degree <= 10) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Watch") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Crockery") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Musical Ins Truments") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Heater") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Washing Machine") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Temple") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Servant Room") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Guest Room") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Bar") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Television") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Computer") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Inverter") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Ac") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Dining Place") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Drawing Room") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }

    else if (type == "Study table or library") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Medicine box") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Pets") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Balcony") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Electric meter") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Garage") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Garden") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else if (type == "Locker") {
      if (degree >= 0 && degree <= 360) {
        return VastuStrings.noTreatmentAvailable.tr;
      } else {
        return ' ';
      }
    }
    else {
      return ' ';
    }
  }

  bool isShowTreatment(String type) {
    if (type == "Home") {
      return true;
    }
    else if (type == "Home Entrance") {
      return true;
    }
    else if (type == "Kitchen") {
      return true;
    }
    else if (type == "Bed Room") {
      return true;
    }
    else if (type == "Toilet or septic tank") {
      return true;
    }
    else if (type == "Dustbin") {
      return true;
    }
    else if (type == "Staircase") {
      return true;
    }
    else if (type == "Store Room") {
      return true;
    }
    else if (type == "Bore well") {
      return true;
    }
    else if (type == "Mirror") {
      return true;
    }
    else if (type == "water tank") {
      return true;
    }
    else if (type == "Basement") {
      return true;
    }
    else if (type == "Watch") {
      return true;
    }
    else if (type == "Crockery") {
      return true;
    }
    else if (type == "Musical Ins Truments") {
      return true;
    }
    else if (type == "Heater") {
      return true;
    }
    else if (type == "Washing Machine") {
      return true;
    }
    else if (type == "Temple") {
      return true;
    }
    else if (type == "Servant Room") {
      return true;
    }
    else if (type == "Guest Room") {
      return true;
    }
    else if (type == "Bar") {
      return true;
    }
    else if (type == "Television") {
      return true;
    }
    else if (type == "Computer") {
      return true;
    }
    else if (type == "Inverter") {
      return true;
    }
    else if (type == "Ac") {
      return true;
    }
    else if (type == "Dining Place") {
      return true;
    }
    else if (type == "Drawing Room") {
      return true;
    }
    else if (type == "Study table or library") {
      return true;
    }
    else if (type == "Medicine box") {
      return true;
    }
    else if (type == "Pets") {
      return true;
    }
    else if (type == "Balcony") {
      return true;
    }
    else if (type == "Electric meter") {
      return true;
    }
    else if (type == "Garage") {
      return true;
    }
    else if (type == "Garden") {
      return true;
    }
    else if (type == "Locker") {
      return true;
    }
    else {
      return false;
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
    String effect =
        getHomeEffect(double.parse(_readout.replaceAll('°', '')), widget.type);
    String treatment = getHomeTreatment(
        double.parse(_readout.replaceAll('°', '')), widget.type);
    _showTreatment = isShowTreatment(widget.type);

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
                    const SizedBox(height: 20),
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
                                padding:
                                    const EdgeInsets.only(bottom: 40, left: 9),
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
                                padding:
                                    const EdgeInsets.only(bottom: 30, left: 16),
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
                    if (_showWorstMessage) // Display the message conditionally
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.blackTransparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          VastuStrings.worst.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
              if (_showTreatment)
                Card(
                  color: ColorResources.treatmentBg,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorResources.treatmentText,
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
                                  VastuStrings.treatment.tr,
                                  style: const TextStyle(
                                    color: Colors.lightBlue,
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
                              treatment,
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

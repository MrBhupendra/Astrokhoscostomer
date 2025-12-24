import 'dart:async';
import 'dart:math';
import 'package:astro_brahmand/utill/vastu_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';

class HomeVastuScreen extends StatelessWidget {
  const HomeVastuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: VastuStrings.home.tr),
        body: const Compass(),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  const Compass({super.key});
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with SingleTickerProviderStateMixin {
  double _heading = 0;
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
      });
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
  String getHomeZoneMidText(double degree, String type) {
      if (degree >= 0 && degree <= 56) {
        return VastuStrings.water.tr;
      } else if (degree >= 57 && degree <= 123) {
        return VastuStrings.air.tr;
      } else if (degree >= 124 && degree <= 191) {
        return VastuStrings.fire.tr;
      } else if (degree >= 192 && degree <= 236) {
        return VastuStrings.earth.tr;
      } else if (degree >= 237 && degree <= 326) {
        return VastuStrings.space.tr;
      } else if (degree >= 327 && degree <= 360) {
        return VastuStrings.water.tr;
      } else {
        return ' ';
      }
  }
  String getHomeZoneText(double degree, String type) {
    if (degree >= 0 && degree <= 11) {
      return VastuStrings.moneyOpportunities.tr;
    } else if (degree >= 12 && degree <= 33) {
      return VastuStrings.healthImmunity.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.ideasVision.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.leisureJoy.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.socialAssociations.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.analysisChurning.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.fireCashLiquidity.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.powerConfidence.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.relaxationFame.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.letgoSpendingDisposal.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.relationshipSkills.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.educationSaving.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.gainsFulfillment.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.depressionDetox.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.bankSupport.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.attractionSex.tr;
    }  else if (degree >= 349 && degree <= 360) {
      return VastuStrings.moneyOpportunities.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneShape(double degree, String type) {
    if (degree >= 327 && degree <= 360) {
      return VastuStrings.wavy.tr;
    } else if (degree >= 0 && degree <= 56) {
      return VastuStrings.wavy.tr;
    } else if (degree >= 57 && degree <= 123) {
      return VastuStrings.rectangle.tr;
    } else if (degree >= 124 && degree <= 191) {
      return VastuStrings.triangle.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.square.tr;
    } else if (degree >= 237 && degree <= 326) {
      return VastuStrings.circle.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneMetal(double degree, String type) {
    if (degree >= 327 && degree <= 360) {
      return VastuStrings.aluminium.tr;
    } else if (degree >= 0 && degree <= 56) {
      return VastuStrings.aluminium.tr;
    } else if (degree >= 57 && degree <= 123) {
      return VastuStrings.stainLessSteel.tr;
    } else if (degree >= 124 && degree <= 191) {
      return VastuStrings.copper.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.brass.tr;
    } else if (degree >= 237 && degree <= 326) {
      return VastuStrings.iron.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneSelfColours(double degree, String type) {
    if (degree >= 327 && degree <= 360) {
      return VastuStrings.blue.tr;
    } else if (degree >= 0 && degree <= 56) {
      return VastuStrings.blue.tr;
    } else if (degree >= 57 && degree <= 168) {
      return VastuStrings.green.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.red.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.yellow.tr;
    } else if (degree >= 237 && degree <= 326) {
      return VastuStrings.white.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneDestructColours(double degree, String type) {
    if (degree >= 327 && degree <= 360) {
      return VastuStrings.yellow.tr;
    } else if (degree >= 0 && degree <= 33) {
      return VastuStrings.yellow.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.red.tr;
    } else if (degree >= 57 && degree <= 123) {
      return VastuStrings.greyOrWhite.tr;
    } else if (degree >= 124 && degree <= 191) {
      return VastuStrings.blue.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.green.tr;
    } else if (degree >= 237 && degree <= 326) {
      return VastuStrings.red.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneEnhanceColours(double degree, String type) {
    if (degree >= 327 && degree <= 360) {
      return VastuStrings.whiteOrGrey.tr;
    } else if (degree >= 0 && degree <= 56) {
      return VastuStrings.whiteOrGrey.tr;
    } else if (degree >= 57 && degree <= 123) {
      return VastuStrings.blue.tr;
    } else if (degree >= 124 && degree <= 191) {
      return VastuStrings.green.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.red.tr;
    } else if (degree >= 237 && degree <= 326) {
      return VastuStrings.yellow.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneExhaustColours(double degree, String type) {
    if (degree >= 327 && degree <= 360) {
      return VastuStrings.green.tr;
    } else if (degree >= 0 && degree <= 56) {
      return VastuStrings.green.tr;
    } else if (degree >= 57 && degree <= 123) {
      return VastuStrings.red.tr;
    } else if (degree >= 124 && degree <= 191) {
      return VastuStrings.yellow.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.white.tr;
    } else if (degree >= 237 && degree <= 326) {
      return VastuStrings.blue.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneAcceptableColours(double degree, String type) {
    if (degree >= 349 && degree <= 360) {
      return VastuStrings.greyWhiteGreenBrown.tr;
    } else if (degree >= 0 && degree <= 11) {
      return VastuStrings.greyWhiteGreenBrown.tr;
    } else if (degree >= 12 && degree <= 33) {
      return VastuStrings.greyOrWhite.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.lightYellow.tr;
    } else if (degree >= 57 && degree <= 123) {
      return VastuStrings.blueBlack.tr;
    } else if (degree >= 124 && degree <= 191) {
      return VastuStrings.greenBrownYellow.tr;
    } else if (degree >= 192 && degree <= 236) {
      return VastuStrings.yellow.tr;
    } else if (degree >= 237 && degree <= 303) {
      return VastuStrings.yellowBlackBlue.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.greyBlackBlueYellowWhite.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.whiteGreyBlueBlack.tr;
    } else {
      return ' ';
    }
  }
  String getHomeZoneRelationship(double degree, String type) {
    if (degree >= 349 && degree <= 360) {
      return VastuStrings.buyersCustomerClients.tr;
    } else if (degree >= 0 && degree <= 11) {
      return VastuStrings.buyersCustomerClients.tr;
    } else if (degree >= 12 && degree <= 33) {
      return VastuStrings.doctorHealthAdvisors.tr;
    } else if (degree >= 34 && degree <= 56) {
      return VastuStrings.selfGod.tr;
    } else if (degree >= 57 && degree <= 78) {
      return VastuStrings.friends.tr;
    } else if (degree >= 79 && degree <= 101) {
      return VastuStrings.societyGovernment.tr;
    } else if (degree >= 102 && degree <= 123) {
      return VastuStrings.inLawsUnlawfulRelationships.tr;
    } else if (degree >= 124 && degree <= 146) {
      return VastuStrings.domesticHelperCleanerWasher.tr;
    } else if (degree >= 147 && degree <= 168) {
      return VastuStrings.siblingsRelativesInfluentialPersonsPolice.tr;
    } else if (degree >= 169 && degree <= 191) {
      return VastuStrings.neighboursSociety.tr;
    } else if (degree >= 192 && degree <= 213) {
      return VastuStrings.sweeperEnemy.tr;
    } else if (degree >= 214 && degree <= 236) {
      return VastuStrings.parentsSpouseSiblingsChildrenCustomerPartner.tr;
    } else if (degree >= 237 && degree <= 258) {
      return VastuStrings.technicalSkilledEmployeesStaff.tr;
    } else if (degree >= 259 && degree <= 281) {
      return VastuStrings.teachersGuruFriendsSupplier.tr;
    } else if (degree >= 282 && degree <= 303) {
      return VastuStrings.counsellors.tr;
    } else if (degree >= 304 && degree <= 326) {
      return VastuStrings.bankFinancialInstitutionsWorkPartner.tr;
    } else if (degree >= 327 && degree <= 348) {
      return VastuStrings.sexPartnerExtraMaritalAffair.tr;
    } else {
      return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    String direction = getDirection(double.parse(_readout.replaceAll('°', '')));
    String showHomeZoneMidText = getHomeZoneMidText(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneText = getHomeZoneText(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneShape = getHomeZoneShape(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneMetal = getHomeZoneMetal(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneSelfColours = getHomeZoneSelfColours(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneDestructColours = getHomeZoneDestructColours(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneEnhanceColours = getHomeZoneEnhanceColours(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneExhaustColours = getHomeZoneExhaustColours(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneAcceptableColours = getHomeZoneAcceptableColours(
        double.parse(_readout.replaceAll('°', '')),'Home');
    String showHomeZoneRelationship = getHomeZoneRelationship(
        double.parse(_readout.replaceAll('°', '')),'Home');

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
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: Column(
                              children: [
                                const Align(alignment: Alignment.topCenter),
                                Icon(
                                  Icons.arrow_drop_up_outlined,
                                  color: ColorResources.compassArrow,
                                  size: 40,
                                ),
                                Text(
                                  _readout,
                                  textAlign: TextAlign.center,
                                  // Center the text horizontally
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: ColorResources.homeZoneMidText,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    showHomeZoneMidText,
                                    textAlign: TextAlign.center,
                                    // Center the text horizontally
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Text(
                                  direction,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),// Display the message conditionally
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.effectText,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          showHomeZoneText,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                      VastuStrings.shape.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneShape,
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
                  ),
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                      VastuStrings.metal.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneMetal,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                      VastuStrings.selfColours.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneSelfColours,
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
                  ),
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                      VastuStrings.destructColours.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneDestructColours,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                      VastuStrings.enhanceColours.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneEnhanceColours,
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
                  ),
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                      VastuStrings.exhaustColours.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneExhaustColours,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.blueTransparent,
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
                                     VastuStrings.acceptableColours.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneAcceptableColours,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: ColorResources.homeZoneTextBg,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.effectText,
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
                                      VastuStrings.relationship.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
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
                                  showHomeZoneRelationship,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





/*class QRBarcode extends StatefulWidget {
  QRBarcode({Key? key}) : super(key: key);

  @override
  _QrBarcodeState createState() => new _QrBarcodeState();
}

class _QrBarcodeState extends State<QRBarcode>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode mFocusNodeQrValue = FocusNode();
  TextEditingController qrController = new TextEditingController();
  final demande_badge_certifie = ServiceBadgeCertifie();
  late PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;
  bool valide_qrcode = false;
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "www.developerlibs.com";
  final TextEditingController _textController = TextEditingController();
  String _qrInfo = '';
  @override
  void initState() {
    // TODO: implement initState
   setState(() {
     _pageController = PageController();
   });
    new Timer(const Duration(seconds: 1), () async {
      ButtomSetData(context,'Veuillez patienter...');
      print(_qrInfo);
      ApiResponse response = await demande_badge_certifie.ValiderBadge(_qrInfo);
      if(response.error == null && demande_badge_certifie.StatusCode == 200){
        Navigator.pop(context);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Bravo !!!!",
                text: "Badge certifié avec succès"
            )
        );
        new Timer(const Duration(seconds: 1), () async {
          setState(() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultScanncodeScreen(text: '${_qrInfo}',)));
          });
        });
      }else if(response.error == null && demande_badge_certifie.StatusCode == 501){
        Navigator.pop(context);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oppp !!!!",
                text: "auccun badge ne correspond à ce code"
            )
        );
      }else if(response.error == null && demande_badge_certifie.StatusCode == 504){
        Navigator.pop(context);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oppp !!!!",
                text: "Désolé ce code est déjà utilisé"
            )
        );
      } else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          backgroundColor: Colors.red,));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/2.7,
      child: PageView(
        controller: _pageController,
        onPageChanged: (i) {
          if (i == 0) {
            setState(() {
              right = Colors.white;
              left = Colors.black;
            });
          } else if (i == 1) {
            setState(() {
              right = Colors.black;
              left = Colors.white;
            });
          }
        },
        children: <Widget>[
          _buildScan(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mFocusNodeQrValue.dispose();
    _pageController?.dispose();
    super.dispose();
  }



  _qrCallback(String code) {
    setState(() {
      _qrInfo = code;
    });
  }

  Widget _buildScan(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height*0.6,
        width: size.width*0.8,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: const Offset(0, 0.5),
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
        child: QRBarScannerCamera(
          onError: (context, error) => Text(
            error.toString(),
            style: TextStyle(color: Colors.red),
          ),
          qrCodeCallback: (code) {
            _qrCallback(code!);
          },
        ),
      ),
    );
  }

  void _onScanButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate);
  }

}*/
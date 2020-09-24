import 'package:flutter/material.dart';
// kita import untuk helper
import './DBHelper.dart';
import './mynote.dart';

class NotePage extends StatefulWidget {
  NotePage(this._mynote, this._isNew);

  final Mynote _mynote;
  final bool _isNew;


  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String title;
   bool btnDelete;
   bool btnEdit;
   bool btnSave;

  final cTitle = TextEditingController();
  final cNote = TextEditingController();

  var now = DateTime.now();
    Future addRecord() async{
    var db = DBHelper();
    String dateNow="${now.day}-${now.month}-${now.year},${now.hour},${now.minute}";

    var mynote = Mynote(cTitle.text, cNote.text,dateNow,dateNow,now.toString());
    await db.saveNote(mynote);
    print("saved");
    }
  Future updateRecord() async{

    }
    void _saveData(){
      if(widget._isNew) {
        addRecord();
      }else{
        updateRecord();
      }
      Navigator.of(context).pop();
    }
  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = "New Note";
      btnSave=true;
      btnEdit=false;
      btnDelete=false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        elevation: 0.0,
        actions: <Widget> [
            IconButton(
              onPressed: () =>Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.black,
                size: 25,
              ),
            )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: <Widget>[
              CreateBUtton(icon: Icons.save, enable: btnSave, onpress: _saveData,),
              CreateBUtton(icon: Icons.edit, enable: btnEdit, onpress: (){},),
              CreateBUtton(icon: Icons.delete, enable: btnDelete, onpress: (){},)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: cTitle,
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none
              ),
              style: TextStyle(fontSize: 24.0, color: Colors.grey[800]),
              maxLines: null,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: cNote,
              decoration: InputDecoration(
                  hintText: "Create Here",
                  border: InputBorder.none
              ),
              style: TextStyle(fontSize: 24.0, color: Colors.grey[800]),
              maxLines: null,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
class CreateBUtton extends StatelessWidget{
  final IconData icon;
  final bool enable;
  final onpress;

    // kita buat konstruktor
  CreateBUtton({this.icon, this.enable, this.onpress});

  Widget build(BuildContext context){
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, color: enable? Colors.purple : Colors.grey),
      child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          iconSize: 18,
          onPressed: (){
              if(enable){
                onpress();
              }
      }),
        );
  }


}


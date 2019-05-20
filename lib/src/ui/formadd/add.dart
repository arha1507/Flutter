import 'package:flutter/material.dart';
import 'package:crud_sample/src/api/apiservice.dart';
import 'package:crud_sample/src/model/gudang.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  Gudang gudang;

  FormAddScreen({this.gudang});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldCodeValid;
  bool _isFieldNameValid;
  bool _isFieldStockValid;
  bool _isFieldUnitValid;
  bool _isFieldSupIdValid;
  bool _isFieldCatIdValid;
  bool _isFieldSubCatIdValid;
  TextEditingController _controllerCode = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerStock = TextEditingController();
  TextEditingController _controllerUnit = TextEditingController();
  TextEditingController _controllerSupId = TextEditingController();
  TextEditingController _controllerCatId = TextEditingController();
  TextEditingController _controllerSubCatId = TextEditingController();

  @override
  void initState() {
    if (widget.gudang != null) {
      _isFieldCodeValid = true;
      _controllerCode.text = widget.gudang.warehouseItem_code;
      _isFieldNameValid = true;
      _controllerName.text = widget.gudang.warehouseItem_name;
      _isFieldStockValid = true;
      _controllerStock.text = widget.gudang.warehouseItem_stock.toString();
      _isFieldUnitValid = true;
      _controllerUnit.text = widget.gudang.warehouseItem_unit;
      _isFieldSupIdValid = true;
      _controllerSupId.text = widget.gudang.warehouseItemSupplier_id.toString();
      _isFieldCatIdValid = true;
      _controllerCatId.text = widget.gudang.warehouseItemCategory_id.toString();
      _isFieldSubCatIdValid = true;
      _controllerSubCatId.text = widget.gudang.warehouseItemSubCategory_id.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.gudang == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldCode(),
                _buildTextFieldName(),
                _buildTextFieldStock(),
                _buildTextFieldUnit(),
                _buildTextFieldSupId(),
                _buildTextFieldCatId(),
                _buildTextFieldSubCatId(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.gudang == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldCodeValid == null ||
                          _isFieldNameValid == null ||
                          _isFieldStockValid == null ||
                          _isFieldUnitValid == null ||
                          _isFieldSupIdValid == null ||
                          _isFieldCatIdValid == null ||
                          _isFieldSubCatIdValid == null ||
                          !_isFieldCodeValid ||
                          !_isFieldNameValid ||
                          !_isFieldStockValid ||
                          !_isFieldUnitValid ||
                          !_isFieldSupIdValid ||
                          !_isFieldCatIdValid ||
                          !_isFieldSubCatIdValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String warehouseItem_code = _controllerCode.text.toString();
                      String warehouseItem_name = _controllerName.text.toString();
                      String warehouseItem_stock = _controllerStock.text.toString();
                      String warehouseItem_unit = _controllerUnit.text.toString();
                      String warehouseItemSupplier_id = _controllerSupId.text.toString();
                      String warehouseItemCategory_id = _controllerCatId.text.toString();
                      String warehouseItemSubCategory_id = _controllerSubCatId.text.toString();
                      Gudang gudang =
                          Gudang(warehouseItem_code: warehouseItem_code, warehouseItem_name: warehouseItem_name, warehouseItem_stock: warehouseItem_stock,
                           warehouseItem_unit: warehouseItem_unit, warehouseItemSupplier_id: warehouseItemSupplier_id, warehouseItemCategory_id: warehouseItemCategory_id,
                           warehouseItemSubCategory_id: warehouseItemSubCategory_id);
                      if (widget.gudang == null) {
                        _apiService.createGdg(gudang).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        gudang.warehouseItem_id = widget.gudang.warehouseItem_id;
                        _apiService.updateGdg(gudang).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.lightBlue[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldCode() {
    return TextField(
      controller: _controllerCode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Code",
        errorText: _isFieldCodeValid == null || _isFieldCodeValid
            ? null
            : "Code is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldCodeValid) {
          setState(() => _isFieldCodeValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldStock() {
    return TextField(
      controller: _controllerStock,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Stock",
        errorText: _isFieldStockValid == null || _isFieldStockValid
            ? null
            : "Stock is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldStockValid) {
          setState(() => _isFieldStockValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldUnit() {
    return TextField(
      controller: _controllerUnit,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Unit",
        errorText: _isFieldStockValid == null || _isFieldStockValid
            ? null
            : "Stock is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldStockValid) {
          setState(() => _isFieldStockValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldSupId() {
    return TextField(
      controller: _controllerSupId,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Supplier ID",
        errorText: _isFieldSupIdValid == null || _isFieldSupIdValid
            ? null
            : "Supplier ID is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldSupIdValid) {
          setState(() => _isFieldSupIdValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldCatId() {
    return TextField(
      controller: _controllerCatId,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Category ID",
        errorText: _isFieldCatIdValid == null || _isFieldCatIdValid
            ? null
            : "Category ID is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldSupIdValid) {
          setState(() => _isFieldSupIdValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldSubCatId() {
    return TextField(
      controller: _controllerSubCatId,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Supplier ID",
        errorText: _isFieldSubCatIdValid == null || _isFieldSubCatIdValid
            ? null
            : "Supplier ID is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldSubCatIdValid) {
          setState(() => _isFieldSubCatIdValid = isFieldValid);
        }
      },
    );
  }
}
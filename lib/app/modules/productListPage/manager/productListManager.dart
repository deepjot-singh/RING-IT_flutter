import 'package:foodorder/app/modules/productListPage/model/cartItemModel.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/widgets/refreshController/refreshController.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductsListManager {
  List<ProductsListModel> productsList = [];
  List<ProductsListModel> searchproductsList = [];

  var isLoading = false;
  int productQuantity = 0;
  int pageNo = 1;
  RefreshController controller = RefreshController();
  String selectedValue = "";
  String selectedOrder = "";
  var selectionListManager = SelectionListManager();
  String errorMsg = "";
  bool isMultiple = false;
//products list bottom sheet variables
  CartItemModel? cartItemModel;
  var cartDetailLoader = false;
  Iterable<VariableProductModel>? dataVariableList;

  var userPlaceOrderAddress = "";
  var userPlaceOrderAddressType = "Current Location";
  var latitude = "";
  var longitude = "";
  int count = 0;
  double variablePrice = 0.0;

  clearError() {
    clearMsg();
    count = 0;
    selectionListManager.selectedItem = [];
    selectionListManager.selectedItemSize = [];
    clearTotalItem();
    isMultiple = false;
    clearCheckBox(clearErrMgs: true);
  }

  clearErrorView() {
    selectionListManager.selectedItem = [];
    clearTotalItem();
    clearCheckBox(clearErrMgs: true);
  }

  clearCheckBox({clearErrMgs = false}) {
    selectionListManager.selectedItem = [];
    productsList.forEach((element) {
      element.variableProduct.forEach((element1) {
        if (clearErrMgs) element1.errorMsg = "";
        element1.variations.forEach((element2) {
          element2.isChecked = false;
        });
      });
    });
  }

  clearErrorPopular() {
    clearMsg();
    count = 0;
    selectionListManager.selectedItem = [];
    selectionListManager.selectedItemSize = [];
    selectionListManager.priceListDouble = [];

    clearTotalItem();
    isMultiple = false;
  }

  clearCheckBoxProduct({required List<ProductsListModel> productsListPopular}) {
    productsListPopular.forEach((element) {
      element.variableProduct.forEach((element1) {
        element1.variations.forEach((element2) {
          element2.isChecked = false;
        });
      });
    });
  }

  clearPricie({required List<VariableProductModel> variableList}) {
    selectionListManager.priceListDouble = [];
    calculateProductPrice(variableList: variableList);
    checkRequired(variableList: variableList);
  }

  clearTotalItem() {
    selectionListManager.totalSelectedItem = [];
  }

  clearMsg() {
    errorMsg = "";
  }

  addisMultipleZeroData(
      {required List<Variations> variation,
      required SelectionListManager selectedItemSize1,
      variationId,
      bool isPopular = false,
      productsListPopular,
      required VariableProductModel variableProductModel}) {
    variation.forEach((element) {
      selectedItemSize1.selectedItemSize.removeWhere((e) => e == element.id);
    });
    if (isPopular) {
      clearCheckBoxProduct(productsListPopular: productsListPopular);
    } else {
      clearCheckBox();
    }
    if (selectedItemSize1.checkValueExistsSize(variationId)) {
      selectedItemSize1.removeFromItemsSize(variationId);
    } else {
      selectedItemSize1.addtoItemsSize(variationId);
    }
    print("selectedItemSize1${selectedItemSize1.selectedItemSize}");
  }

  addisMultipleOneData(
      {required SelectionListManager selectedItem1, variationId}) {
    if (selectedItem1.checkValueExists(variationId)) {
      selectedItem1.removeFromItems(variationId);
    } else {
      selectedItem1.addtoItems(variationId);
    }
    print("selectedItem1${selectedItem1.selectedItem}");
  }

  calculateProductPriceisMultipleZeroData(
      {required List<Variations> variation,
      required SelectionListManager selectedItemSize1,
      required Variations variationsModel}) {
    selectionListManager.priceListDouble = [];
    variation.forEach((element) {
      selectionListManager.priceListDouble.removeWhere((e) =>
          e ==
          double.parse(element.sale_price_double != ""
              ? element.sale_price_double
              : element.regular_price_double));
    });
    if (selectionListManager.checkValueExistsDouble(
        dataSaleOrRegular(variationsModel: variationsModel))) {
      selectionListManager.removeFromItemsDouble(
          dataSaleOrRegular(variationsModel: variationsModel));
      totalPrice();
    } else {
      selectionListManager.addtoItemsDouble(
          dataSaleOrRegular(variationsModel: variationsModel));
      totalPrice();
    }
  }

  dataSaleOrRegular({required Variations variationsModel}) {
    return double.parse(variationsModel.sale_price_double != ""
        ? variationsModel.sale_price_double
        : variationsModel.regular_price_double);
  }

  calculateProductPriceisMultipleOneData(
      {required SelectionListManager selectedItem1,
      required Variations variationsModel}) {
    if (selectionListManager.checkValueExistsDouble(
        dataSaleOrRegular(variationsModel: variationsModel))) {
      selectionListManager.removeFromItemsDouble(
          dataSaleOrRegular(variationsModel: variationsModel));
    } else {
      selectionListManager.addtoItemsDouble(
          dataSaleOrRegular(variationsModel: variationsModel));
    }
    totalPrice();
  }

  totalPrice() {
    if (selectionListManager.priceListDouble.isNotEmpty) {
      variablePrice =
          selectionListManager.priceListDouble.reduce((a, b) => a + b);
      print("variablePrice${variablePrice}");
    }
  }

  checkRequired({required List<VariableProductModel> variableList}) {
    dataVariableList =
        variableList.where((element) => element.is_multiple == "0");
    dataVariableList?.forEach((element) {
      isMultiple = true;
      selectionListManager.addtoItemsSize(element.variations.first.id ?? 0);
      print("selectionListManager${selectionListManager.selectedItemSize}");

      // if (selectionListManager
      //     .checkValueExistsSize(element.variations.single.id ?? 0)) {
      //   element.errorMsg = "Required";
      // }

      // if (dataVariableList?.length !=
      //     selectionListManager.selectedItemSize.length) {
      //   element.errorMsg = "Required";
      // }
    });
  }

  calculateProductPrice({required List<VariableProductModel> variableList}) {
    dataVariableList =
        variableList.where((element) => element.is_multiple == "0");
    dataVariableList?.forEach((element) {
      selectionListManager.addtoItemsDouble(double.parse(
          element.variations.first.sale_price_double != ""
              ? element.variations.first.sale_price_double
              : element.variations.first.regular_price_double));
    });
    if (selectionListManager.priceListDouble.isNotEmpty) {
      variablePrice =
          selectionListManager.priceListDouble.reduce((a, b) => a + b);
    }
  }

  addTotal(
      {isCheckoutPage = false, required List<dynamic> productAttributeIds}) {
    clearTotalItem();
    if (!isCheckoutPage) {
      selectionListManager.totalSelectedItem
          .addAll(selectionListManager.selectedItemSize);
      selectionListManager.totalSelectedItem
          .addAll(selectionListManager.selectedItem);
    } else {
      print("productAttributeIds$productAttributeIds");
      selectionListManager.totalSelectedItem.addAll(productAttributeIds);
    }
    print("PRODUCT IDS Add--${selectionListManager.totalSelectedItem}");
  }
}

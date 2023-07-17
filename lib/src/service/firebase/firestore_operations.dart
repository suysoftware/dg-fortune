import 'package:dg_fortune/src/service/firebase/rest_api_constants.dart';
import 'package:dg_fortune/src/service/firebase/rest_api_operations.dart';

class FirestoreOperations{

static Future<void> sendManifestMessage(String manifestMessage,String userUid)async{
  var quotaPayload = {
      "manifest_message": manifestMessage,
      "user_no": userUid,
    };
await RestApiServices.restApiRequest(RestApiConstants.API_LINK_SEND_MANIFEST_MESSAGE, quotaPayload,(){
  return "success";});

}


}
import 'package:algorand_dart/algorand_dart.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
class Connect{
  final algoTestNet=AlgoExplorer.TESTNET_ALGOD_API_URL;

  final algodClient = AlgodClient(
    apiUrl: AlgoExplorer.TESTNET_ALGOD_API_URL,
  );

  final indexerClient = IndexerClient(
    apiUrl: AlgoExplorer.TESTNET_INDEXER_API_URL,
  );

  Algorand algorandMe(){
    final algorand = Algorand(
      algodClient: algodClient,
      indexerClient: indexerClient,
    );
    return algorand;
  }


  Future<Account> accountMe() async {

    return  await Account.fromSeedPhrase(accountStorage.read("login")!.split(' '));
  }

  Future<double> algodclient() async {


    final algorand = Algorand(
      algodClient: algodClient,
      indexerClient: indexerClient,
    );
    final aa=await accountMe();
    final int nn;
    try {

      nn=await algorand.getBalance( aa.publicAddress);
    }catch(e){
      return 0.0000;
    }
    return Algo.fromMicroAlgos(nn);
  }


  Future<void> addAssetsMe({required int indexI}) async {

    final algorand = Algorand(algodClient: algodClient);
    final aa=await accountMe();
    try{
      print(  await  algorand.assetManager.optIn(assetId: indexI, account: aa));
    }catch(e){

    }
  }

  Future<void> destroyAssets({required int indexI}) async {

    final algorand = Algorand(algodClient: algodClient);
    final account=await accountMe();


    try{
 // await algorand.assetManager.destroyAsset(assetId: 96989531, account: account);

      transfer(sender: account, assetId: 96989531, receiver: account, algorand: algorand);



    }catch(e){
      print(e);
    }
  }


  /// Transfer asset from creator to opted in account
  Future<bool> transfer({
    required Algorand algorand,
    required Account sender,
    required Account receiver,
    required int assetId,
  }) async {
    print('--- Transfering asset ---');

    // Get the suggested transaction params
    final params = await algorand.getSuggestedTransactionParams();

    // Transfer the asset
    final tx = await (AssetTransferTransactionBuilder()
      ..assetId = assetId
      ..sender = sender.address
      ..receiver = receiver.address
      ..amount = 1000
      ..suggestedParams = params)
        .build();

    // Sign the transaction
    final signedTx = await tx.sign(sender);

    // Broadcast the transaction
    final txId = await algorand.sendTransaction(signedTx);
    final response = await algorand.waitForConfirmation(txId);
    print(response);


    return Future.value(true);
  }





  Future<List<AssetHolding>> printAssetHolding() async {
    List<AssetHolding> assestsList=[];

    final algorand = Algorand(algodClient: algodClient);

    final account=await accountMe();

    final information = await algorand.getAccountByAddress(account.publicAddress);
    for (var asset in information.assets) {

      assestsList.add(asset);

    }
    return assestsList;
  }


  Future<void> assetsi() async {

    final algorand = Algorand(algodClient: algodClient);
    final aa=await accountMe();

    final params = await algorand.getSuggestedTransactionParams();
    print(  await  params.fee);

  }


  Future<List<Asset>>  searchAssetsByName() async {
    List<Asset> assetsSearch=[];
    try {

      final algorand = Algorand(algodClient: algodClient);

      final aa=await accountMe();
      final response =
      await algorand.indexer().assets().whereAssetName('').search();
      final account=await accountMe();
      assetsSearch.assignAll(response.assets);
    } on AlgorandException catch (ex) {
      final error = ex.cause as DioError;
      print(error.response?.toString());
    }
    return assetsSearch;
  }


  Future<String> sender( {required String address,required double amount}) async {
    // Get the suggested transaction params
    final params = await algorandMe().getSuggestedTransactionParams();
final aa=await accountMe();
    // Create the first transaction
    final tx1 = await (PaymentTransactionBuilder()
      ..sender = aa.address
      ..receiver = Address.fromAlgorandAddress(address: address)
      ..amount = Algo.toMicroAlgos(amount)
      ..suggestedParams = params)
        .build();

    // Sign the transaction
    final signedTx1 = await tx1.sign(await accountMe());


    final txId = await algorandMe().sendTransactions([signedTx1]);
    final response = await algorandMe().waitForConfirmation(txId);
    print(response.logs);
   return txId;

  }
}
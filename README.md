# DynamoDBとRDSそれぞれにLambdaからInsertを実行する

### 1. Cloud9構築(Ruby2.5, SAM)
元々インストールされているRubyとSAMのバージョンを変更します。  
[こちらのサイト](https://gitkado.hatenadiary.jp/entry/20190701/1561983034)を参考に行なってください。  

### 2. [GitHub](https://github.com/gitkado/jaws-lambda-db-access)からソースを取得
以下のコマンドでソースを取得します。

```sh
$ git clone https://github.com/gitkado/jaws-lambda-db-access.git
```

### 3. SAMコマンド実行
**【バケット名】** は、``「S3バケットを作成」``で作成したバケット名に置き換える必要があります。  
以下のコマンドをそれぞれ実行してLambdaとApiGatewayを作成します。  

```sh
$ cd jaws-lambda-db-access
$ sam package \
    --template-file template.yaml \
    --s3-bucket 【バケット名】 \
    --output-template-file packaged-template.yaml \
    --region ap-northeast-1
$ sam deploy \
    --template-file packaged-template.yaml \
    --stack-name cfn-lambda-db-access \
    --capabilities CAPABILITY_IAM
```

### 実行結果
以下のAPIが作成されます。

|API|処理内容|
|---|---|
|DynamoAccessFunction|生成したDynamoDBに対してInsertを実行|
|RdsAccessFunction|生成したRDS(MySQL)に対してInsertを実行 *1|
|RdsCreateTableFunction|生成したRDS(MySQL)に対してCreateTableを実行|

*1...Insert先のテーブルをRdsCreateTableFunctionで生成しておく必要があります。
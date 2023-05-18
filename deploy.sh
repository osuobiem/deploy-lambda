echo Enter function name:;
read funcName;

if test -f bin/$funcName.zip;
then 

  aws lambda get-function --function-name $funcName > /dev/null 2>&1
  if [ 0 == $? ];
  then
    aws lambda update-function-code --function-name $funcName --zip-file fileb://bin/$funcName.zip;
  else
    aws lambda create-function --function-name $funcName --zip-file fileb://bin/$funcName.zip --handler index.handler --runtime nodejs18.x --role arn:aws:iam::708837903773:role/lambda-ex;
  fi

  exit 0;
else 

  echo Error: bundled function with name \'$funcName\' does not exist in ./bin directory;
  exit 1;

fi
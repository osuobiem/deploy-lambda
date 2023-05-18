echo Enter function name:;
read funcName;
echo " > > > Bundling function ... 📦 < < <";

if test -f functions/$funcName/index.js;
then 

  mkdir $funcName;
  cp -r node_modules $funcName;
  cp package.json $funcName;
  cp functions/$funcName/index.js $funcName;
  zip -r bin/$funcName.zip $funcName/* -q;
  rm -r $funcName;

  if [ -n $1 ] && [ "$1" == "deploy" ];
  then

    echo " > > > Deploying function ... 🚀 < < <";

    aws lambda get-function --function-name $funcName > /dev/null 2>&1
    if [ 0 == $? ];
    then
      aws lambda update-function-code --function-name $funcName --zip-file fileb://bin/$funcName.zip;
    else
      aws lambda create-function --function-name $funcName --zip-file fileb://bin/$funcName.zip --handler $funcName/index.handler --runtime nodejs18.x --role arn:aws:iam::708837903773:role/lambda-ex;
    fi

    rm bin/$funcName.zip;
    echo " > > > ✅ Function deployed successfully 🚀 😎 < < <";
    exit 0;
  fi

else 

  echo " 🚨 Error: function with name \'$funcName\' does not exist in ./functions directory ";
  exit 1;

fi
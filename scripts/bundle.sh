# Read function name from user input
echo Enter function name:;
read funcName;
echo " > > > Bundling function ... ⚙️ < < <";

if test -f functions/$funcName/index.js;
then 

  # Create function directory and zip contents
  mkdir $funcName;
  cp -r node_modules $funcName;
  cp package.json $funcName;
  cp functions/$funcName/index.js $funcName;
  zip -r .dl-bin/$funcName.zip $funcName/* -q;
  rm -r $funcName;

  # Deploy function if "deploy" command is passed
  if [ -n $1 ] && [ "$1" == "deploy" ];
  then

    echo " > > > Deploying function ... 🚀 < < <";

    # Check if function already exists
    aws lambda get-function --function-name $funcName > /dev/null 2>&1
    if [ 0 == $? ];
    then
      aws lambda update-function-code --function-name $funcName --zip-file fileb://.dl-bin/$funcName.zip;
    else
      aws lambda create-function --function-name $funcName --zip-file fileb://.dl-bin/$funcName.zip --handler $funcName/index.handler --runtime nodejs18.x --role arn:aws:iam::708837903773:role/lambda-ex;
    fi
  
    rm .dl-bin/$funcName.zip;
    echo " > > > ✅ Function deployed successfully 🚀 😎 < < <";

  else
    echo " > > > ✅ Function bundled successfully 📦 < < <";
  fi

  exit 0;

else 

  echo " 🚨 Error: function with name \'$funcName\' does not exist in /functions directory ";
  exit 1;

fi
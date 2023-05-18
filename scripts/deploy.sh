# Read function name from user input
echo Enter function name:;
read funcName;

# Check if function zip has been created
if test -f .dl-bin/$funcName.zip;
then 

  echo " > > > Deploying function ... 🚀 < < <";

  # Check if function already exists
  aws lambda get-function --function-name $funcName > /dev/null 2>&1
  if [ 0 == $? ];
  then
    aws lambda update-function-code --function-name $funcName --zip-file fileb://.dl-bin/$funcName.zip;
  else
    aws lambda create-function --function-name $funcName --zip-file fileb://.dl-bin/$funcName.zip --handler index.handler --runtime nodejs18.x --role arn:aws:iam::708837903773:role/lambda-ex;
  fi

  echo " > > > ✅ Function deployed successfully 🚀 😎 < < <";
  exit 0;
else 

  echo 🚨 Error: bundled function with name \'$funcName\' does not exist in /.dl-bin directory;
  exit 1;

fi
## Deploy Lambda

This is not a module or package that can be installed, it's just a bunch of scripts that make it super easy to deploy AWS Lambda functions using AWS CLI.
You might need them if you don't want to use any module, serverless framework, or infrastructure-as-code software.

🚨 Note: _These scripts will not run on a **Windows machine** 🙅🏾, they're specifically for Unix-based operating systems like **Linux and MacOS** that can execute `.sh` files._

_This is specifically for `.js` functions, feel free to tweak for `.py` and other functions._

### Initial Setup ⚙️

- Make sure you have [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed
- Install [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable) or [NPM](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm/)
- Create a `scripts` folder in your project root directory and copy the scripts ([setup.sh](/scripts/setup.sh), [bundle.sh](/scripts/bundle.sh), and [deploy.sh](/scripts/deploy.sh)) into the folder.
- Create a `package.json` file or run `yarn init` or `npm init` and answer the questions to create a `package.json` file.
- Add this to your `package.json` file
  ```
    "scripts": {
      "dl:setup": "sh scripts/setup.sh",
      "dl:bundle": "sh scripts/bundle.sh",
      "dl:deploy": "sh scripts/bundle.sh deploy",
      "dl:deploy:dry": "sh scripts/deploy.sh"
    }
  ```
- The scripts assume that you have a `functions` folder with each function in it's own folder containing `index.js` which contains the function handler.
- Finally, in your terminal, run `yarn dl:setup` or `npm run dl:setup`, this will require you to configure AWS CLI if you haven't done that already. It'll go ahead to create the needed roles and the `.dl-bin` folder.

### Usage 🚙

I'll use Yarn from here on, the commands are the same for NPM, just don't forget to add `run` after `npm`.

- To `bundle` function into a zip file ready for deployment, run `yarn dl:bundle`, you'll be prompted to enter the function name. You'll find the zipped function in the `.dl-bin` folder.
- To `bundle` and `deploy` in one go, run `yarn dl:deploy`, you'll be prompted to enter the function name.
- To `deploy` an already bundled function, run `yarn dl:deploy:dry`. This command assumes the `zip` file of function to be deploy already exists in the `.dl-bin` folder.

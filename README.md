## Pre-requisites

You will need:

<<<<<<< HEAD
1. An Azure subscription (free trial is fine)
1. A GitHub account
1. Command line with az cli installed, or use [Azure Cloud Shell](http://shell.azure.com/)
1. Microsoft Teams

## Fork the source code

1. Make sure you are logged into GitHub, then navigate to https://github.com/CharleneMcKeown/TailwindTraders and fork the repo. This will create a copy of the repo in your GitHub account. 
1. Clone the newly created repo from your account (optional - we will be making small code changes that can be done in the browser)

## Setup Teams



## Generate secrets

In order to deploy and access Azure resources, we need an identity that has the right permissions.

1. In your terminal or Cloud Shell, run the following command:

    ```
    az ad sp create for rbac
    ```

    The output will look something like this:
    ```
        {
        "appId": "",
        "displayName": "",
        "name": "",
        "password": "",
        "tenant": ""
        }
    ```
1. Copy and paste the output into a text editor.
1. We need to change this slightly. Update **appId** to **clientId**, **password** to **clientSecret**, **tenant** to **tenantId** and finally, add in a new key value pair for your **subscriptionId**. It should now look like the below: 

    ``` {
        "clientId": "",
        "displayName": "",
        "name": "",
        "clientSecret": "",
        "tenantId": "",
        "subscriptionId": ""
        }
    ```

1. Return to your terminal or Cloud Shell, and run the following command to get the object id of your newly created service principal. Copy it and paste it into your text editor for the next step. 
    ```
    az ad sp show --id <putYourclientIdHere>
    ```

## GitHub Secrets

We now need to do some configuration in GitHub. 

1. Generate a GitHub Personal Access Token on the [developer settings](https://github.com/settings/tokens) page in GitHub. Make sure it has admin:repo_hook permissions. Copy and paste it into your text editor. 
1. In the repo, navigate to Settings > Secrets. 
1. Add a new secret called AZURE_CREDENTIALS, and paste in the JSON object you modified earlier in your text editor. Save it.
1. Add another secret called GH_TOKEN, and paste in the GitHub token you just created.
1. Add one last secret called TEAMS_WEBHOOK, and paste in the webhook you saved earlier. Save it. 

## GitHub Environments


## Update Source code

1. In your repo, navigate to **Deploy/main.bicep** and prepare to edit it (in your code editor or in the browser).
1. On line 15, add in your objectId that you saved earlier on and save the file. If working locally, run:

    ```
    git add .
    git commit -m "Updated Bicep file"
    git push
    ```
This should trigger the GitHub workflow to build and deploy the application! So what's actually happening? 

## Azure Bicep

blurb about Bicep

We are deploying:

1. App Service Plan
1. Web App for Containers
1. Extra deployment slot for our web app
1. Azure Container Registry to host the Tailwind Trader application image
1. Azure Key Vault to store the password for the container registry

=======
# Deploy to Azure
>>>>>>> fedae7a4e88581030eb5edc65ab03c387a3d2b97

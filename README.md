# BackgroundRefresh

This script will install and update the desktop background and lockscreen. The desktop background is refreshed for **all users** using the ActiveSetup function. The images will be placed in `C:\Windows\customization`, so the script needs to run under SYSTEM context.

Active Setup can be versioned to support updates—just take a look at the code!
Feel free to update the images and modify the script.

I chose to use Active Setup because it ensures that the background is updated for users who are already signed in, while still allowing users the option to change their desktop background. This is designed as a first-time setup experience. The only element that is locked is the lockscreen image, which is applied directly so that setting up a policy isn’t necessary. However, feel free to adjust this if you prefer to enforce the policy.


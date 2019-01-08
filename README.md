# NEHotspotHelperApp
- This project is Apple NetworkExtension API App.
- App can set Wi-Fi auth setting to iOS setting.

## Prepare NetworkExtension API
We need prepare to use NetworkExtention API.

### Send request to apple for NetworkExtension API.
https://developer.apple.com/contact/request/network-extension/

Wait for apple's allow...  
( I experienced "one week wait" case and "two week wait" case, and "one month wait" case. there are various periods. )


### Setting on Apple Developer
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/provisioning.png" width="640px">

After recieved allow mail from apple,  
Set "Network Extension iOS" entitlements to provisioning file on Apple Developer.  
and Download provisioning file then install it.


### Setting on Xcode
#### Add NetworkExtension Framework
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/xcode_add_framework.png" width="640px">
Open "Build Phases", add NetworkExtension.framework.

#### Enable "Personal VPN"
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/xcode_enable_personal_vpn.png" width="640px">
Open "Capabilities", enable "Personal VPN".  

#### Add "Background Mode ( network-auth )"
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/xcode_info_plist_add_background_mode.png" width="640px">
Open "Info.plist", add "Required background modes ( Array )" row and Set value "network-authentication ( String )".

#### Set Entitlements file
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/xcode_entitlements_set.png" width="640px">
Open "*.entitlements" file, add "com.apple.developer.networking.HotspotHelper" row and Set value "YES ( Boolean )".


## Run App
### Set SSID ( BSSID ) and Password then touch "Register" button.
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/app_register.png" width="320px">

### Open iOS "Wi-Fi" Setting.
<img src="https://github.com/daisuke-t-github/NEHotspotHelperApp/blob/master/doc/app_ios_setting.png" width="320px">

If "Display name" shows under target SSID Text, HotspotHelper succeed.  
iOS can connect to target SSID Wi-Fi when user touch SSID text.  
After connected Wi-Fi, iOS auto connect to target Wi-FI without user action.  
Auto connect is enable until uninstalled app.

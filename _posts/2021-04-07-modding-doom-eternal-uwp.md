---
layout: post
published: true
title: 'Installing mods for DOOM Eternal UWP'
subtitle: 'slightly more technical than just extracting a zip file'
comments: false
---
# Note:
I won't really be explaining everything... if you're looking for an easy way to get mods working on Game Pass, 
_I'm pretty close to finishing a tool that will dump the game to an unencrypted location, and patch the existing modding tools to work properly; **doing everything below for you**_ 

## The first problem:
_**UWP Apps are heavily guarded by the system**_  
Often, taking ownership of the *WindowsApps* folder through the security dialog in File Explorer is not enough and tends to cause even more issues.
### The solution: 
Use [UWPDumper](https://github.com/Wunkolo/UWPDumper).  
1. Launch DOOM Eternal
2. Get the proc id of `DOOMEternalx64vk.exe` from Task Manager
3. Run `UWPInjector.exe -p <proc id> -d <dump location>` (dump location can be wherever you want, as long as it has ~70 GB free.)
4. Wait until the dump is complete
5. Uninstall DOOM Eternal from settings.
6. Open powershell
7. `cd <dump location>` (Same as earlier)
8. `Add-AppxPackage -Register AppxManifest.xml`

## The second (smaller) problem
_**EternalPatcher.exe's patch definitions all work except for one. 'skip data checksum checks'**_ (Also, hashes need to be updated in the injecotr script.)  
This is where I have little knowledge, yet somehow got this working????
### The solution:
* EternalPatcher.exe and EternalModInjector.bat: The vanilla hash for `uwpdlc2` (5.0) is `5535c56445e55f20e6d3b475217def4f`
* EternalPatcher.exe: The replacement patch is this pattern patch: `741F418B564841B8EFBEADDE:EB1F418B564841B8EFBEADDE`
* EternalModInjector.bat: The patched hash for UWP, 5.0 is `1f3ab720232314e81efb2b2b6c4b5563`

### My Process
I don't have **any** previous experience with low-level programming. But, after some quick research, I learned about [Ghidra](https://ghidra-sre.org), and went in blindly.  

I used the UWP version and a DRM-free version of the exe so I could compare the two executables (keep in mind I don't know anything about how the patches work at this point).  
I searched for the bytes that the original patch changes (in the DRM-free exe), then looked for anything I could compare between the two versions.  
I found a string in the decompiler panel:  
`resource %s:%s data integrity checksum failure, has: 0x%llx, wants 0x%llx\n`, and then searched for it in the UWP exe.  
What I think I learned:    
![DOOMEternalx64vk.exe (UWP)](https://sewsam.github.io/img/uwp.png)  
does _about_ the same thing as  
![DOOMEternalx64vk.exe (DRM-Free)](https://sewsam.github.io/img/nodrm.png)  
(At least, I think... still don't really know how this works).

So, the next step was to test the patch on this new pattern, changing the first byte to `EB`. This worked.  


DM me on discord if I got something wrong or if you have a question about what I learned doing this. (SEWsam#4092)

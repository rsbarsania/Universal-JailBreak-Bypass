# Universal JailBreak Bypass
This tool is designed to circumvent Jailbreak Detection mechanisms in iOS devices. This tool enumerates classes and methods directly from the application and then automatically generates a Frida script to bypass the mechanism. This is unlike other publicly available applications and scripts that mostly search for predefined class and method names. This approach often fails when developers make changes to class or method names. In such cases, manual identification of the class and method name is required for bypassing, which can take around 1.5 to 2 hours.

## Audience
This tool is written for pentesters, who wants to bypass the JailBreak Detection during their assessments. It may also be useful for developers who want their applications to remain uncompromised.

## Requirements
This tool is written in PowerShell script; thus, the user has to run it in PowerShell.

## Installation
Installation is just a case of downloading the Universal-JailBreak-Bypass.zip file (or git clone the repo).

```
git clone https://github.com/rsbarsania/Universal-JailBreak-Bypass.git
```

## Usage

1. Unzip the Universal-JailBreak-Bypass.zip file.
2. Launch the target iOS application.
3. Right click on the Universal_JailBreak_Bypass.ps1 file and select "Run with Powershell".
4. Enter the Process Identifier of the application from the Frida output which you want to bypass.

## Screenshot
![img](https://github.com/rsbarsania/Universal-JailBreak-Bypass/assets/81644857/9f2e00fb-9c7d-4f74-9d91-54ab6e7865c6)

## About Me

* **Rishabh Singh** - *Cyber Security Researcher* - [Rishabh Singh](https://github.com/rsbarsania/)

### Social Media Handles
* [Twitter](https://twitter.com/rsbarsania)
* [Medium](https://medium.com/@rsbarsania)
* [Linkedin](https://www.linkedin.com/in/rishabhkumarsingh20/)
* [Instagram](https://www.instagram.com/th.rishabhsingh/)

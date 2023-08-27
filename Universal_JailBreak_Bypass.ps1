# Store the current execution policy
$prevExecutionPolicy = Get-ExecutionPolicy

# Temporarily set the execution policy to Bypass
Set-ExecutionPolicy Bypass -Scope Process -Force
echo ""


echo ""
echo '
                  ___  __   __                                   
|  | |\ | | \  / |__  |__) /__`  /\  |                           
\__/ | \| |  \/  |___ |  \ .__/ /~~\ |___                        
                                                                 
                                 __   __   ___                   
                  |  /\  | |    |__) |__) |__   /\  |__/         
               \__/ /~~\ | |___ |__) |  \ |___ /~~\ |  \         
                                                                 
                                     __       __        __   __  
                                    |__) \ / |__)  /\  /__` /__` 
                                    |__)  |  |    /~~\ .__/ .__/ 
                                                                 
'
echo "   	Made By Rishabh Singh (@rsbarsania) <3"
echo ""

Write-Output "`n"
Write-Output "Running Frida to Know the Process Identifier:"
Frida-ps -Ua

Write-Output "`n"
$Process_Name = Read-Host "Enter Process Identifier Name: "

Start-Transcript -Path "transcript.txt"
Write-Output "`n"
Write-Host "Running ios hooking search methods jail:"
objection -g "$Process_Name" run "ios hooking search methods jail"

Stop-Transcript

# Read content from data.txt
$inputContent = Get-Content -Path "transcript.txt" | findstr "["

# Initialize an empty array to store formatted lines
$formattedLines = @()

# Process each line of the input content
foreach ($line in $inputContent) {
$line = $line -replace "^\[", '["'
    $line = $line -replace " - ", '", "- '
    $line = $line -replace " \+ ", '", "+ '
    $line = $line -replace "\]", '"],'
    $formattedLines += $line
}

# Join the formatted lines into a single variable
$output = $formattedLines -join "`n"

# Print the formatted output

# Build the script content with the provided output

echo 'if (ObjC.available) {' > .\scripts\script.js
echo   ' try {' >> .\scripts\script.js
echo   '    const hooks = [' >> .\scripts\script.js
echo          $output  >> .\scripts\script.js
echo      '  ];' >> .\scripts\script.js
echo '       hooks.forEach(([className, funcName]) => {' >> .\scripts\script.js
echo '            const hook = ObjC.classes[className][funcName];' >> .\scripts\script.js
echo '            if (hook) {' >> .\scripts\script.js
echo '                Interceptor.attach(hook.implementation, {' >> .\scripts\script.js
echo '                   onLeave: function (retval) {' >> .\scripts\script.js
echo '                        console.log("Class Name: " + className);' >> .\scripts\script.js
echo '                        console.log("Method Name: " + funcName);' >> .\scripts\script.js
echo '                        console.log("\tType of return value: " + typeof retval);' >> .\scripts\script.js
echo '                       console.log("\tOriginal Return Value: " + retval);' >> .\scripts\script.js
echo '                       ' >> .\scripts\script.js
echo '                       const newretval = ptr("0x0");' >> .\scripts\script.js
echo '                       if (retval.equals(ptr("0x1")) || retval.equals(ptr("0x0"))) {' >> .\scripts\script.js
echo '                           retval.replace(newretval);' >> .\scripts\script.js
echo '                           console.log("\tNew Return Value: " + newretval);' >> .\scripts\script.js
echo '                       } else {' >> .\scripts\script.js
echo '                           console.log("\tNo modification made to return value.");' >> .\scripts\script.js
echo '                       }' >> .\scripts\script.js
echo '                   }' >> .\scripts\script.js
echo '               });' >> .\scripts\script.js
echo '           } else {' >> .\scripts\script.js
echo '               console.log(`Method not found: ${funcName} in class: ${className}`);' >> .\scripts\script.js
echo '           }' >> .\scripts\script.js
echo '       });' >> .\scripts\script.js
echo '   } catch (err) {' >> .\scripts\script.js
echo '      console.log("Exception: " + err.message);' >> .\scripts\script.js
echo '   }' >> .\scripts\script.js
echo '} else {' >> .\scripts\script.js
echo '    console.log("Objective-C Runtime is not available!");' >> .\scripts\script.js
echo '}' >> .\scripts\script.js

# Save the script content to a file

Get-Content .\scripts\script.js | Set-Content -Path ".\scripts\${Process_Name}_script.js" -Encoding UTF8

frida -U -l ".\scripts\${Process_Name}_script.js" -f "$Process_Name"
       
# Restore the original execution policy
Set-ExecutionPolicy $prevExecutionPolicy -Scope Process -Force
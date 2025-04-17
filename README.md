# Process Signature Scanner

A PowerShell script to audit running processes on a Windows machine and extract their signature status. This tool is useful for security auditing and system analysis, helping you determine which processes are signed, unsigned, or potentially suspicious.

## 📌 Features

- Scans all running processes
- Retrieves the signer and Authenticode signature status
- Estimates time remaining per scan
- Saves results to a text file on the desktop
- Automatically opens results in Notepad
- Prevents window from auto-closing

## 🚀 Usage

1. Open PowerShell **as Administrator**.
2. Run the script:
   ```powershell
   .\Process Signature Check.ps1

## Example output
Process: svchost | ID: 672 | Signer: CN=Microsoft Windows, O=Microsoft Corporation, L=Redmond, S=Washington, C=US | Status: Valid
Process: unknownapp | ID: 10523 | Signer: Unsigned | Status: UnknownError






~Work in progress

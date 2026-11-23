# RemoveFile.ps1

RemoveFile.ps1 provides a workaround for Microsoft Defender for Endpoint Live Response scenarios where the standard command `remediate file "filename"` fails due to non-standard file naming conventions.

## Supported Scenarios

- File names containing ampersands (`&`)
- File names containing spaces
- Long file names and paths
- Other special-character-related parsing issues

## Purpose

The script enables analysts to locate and remove files that cannot be remediated using the native `remediate file` command because of command-line parsing limitations or file path constraints.

# Markdown relative link validator
Validate the relative links in your Markdown files with PowerShell! 
Broken relative links are simply written to the default output as a table grouped by file. 
Since it just checks whether relative links actually exist on the file system, it works for any type of relative link (i.e. to other Markdown files, images etc.).

## Usage
Get the source and either:
- Run the script and enter path when prompted;
- Call the script with a path as the parameter.

## Contributions are welcome
This simple script was quickly written when the author found it rather bothersome to manually validate relative links when reorganizing the folder structure of a big repository with lots of Markdown files. 

Because of this specific purpose, it's also rather basic. Feel free to improve or extend it: pull requests are very welcome! 

## Thanks to...
- Stack Overflow user [sln](https://stackoverflow.com/users/557597/sln) for [sharing the regular expression](https://stackoverflow.com/a/44511243) used in this script when answering [this question](https://stackoverflow.com/questions/44511043/regex-to-match-local-markdown-links/).

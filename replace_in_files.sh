#!/bin/bash

# Define the find pattern using ASCII values for tab (0x09) and newline (0x0A)
FIND_PATTERN=$'\t\tCALL\tmemcpy\nskip:\n\t\tMOV\t\tESP,[EBX+12]\t; \x83\x58\x83\x5e\x83\x62\x83\x4e\x8f\x89\x8a\xfa\x92\x6c\n\t\tJMP\t\tDWORD 2*8:0x0000001b'

# Define the replace pattern
REPLACE_PATTERN=$';\t\tCALL\tmemcpy\nskip:\n;\t\tMOV\t\tESP,[EBX+12]\t; \x83\x58\x83\x5e\x83\x62\x83\x4e\x8f\x89\x8a\xfa\x92\x6c\n;\t\tJMP\t\tDWORD 2*8:0x0000001b\n\t\tMOV\t\tESP, 0xffff\n\t\tJMP\t\tDWORD 2*8:0x00000000'

# Function to find and replace the target pattern in a file
find_and_replace() {
    local file="$1"
    LC_ALL=C awk -v find="$FIND_PATTERN" -v replace="$REPLACE_PATTERN" '
    BEGIN { RS = ""; FS = "\n" }
    {
        content = $0
        if (index(content, find) != 0) {
            gsub(find, replace, content)

            print $file
        }
    }' "$file"
}

# system("mv \"" FILENAME ".tmp\" \"" FILENAME "\"")
#             print "Replaced in: " FILENAME

# Export the function to be used by find
export -f find_and_replace
export FIND_PATTERN
export REPLACE_PATTERN

# Find all files recursively and process them with find_and_replace
find . -type f -exec bash -c 'find_and_replace "$0"' {} \;

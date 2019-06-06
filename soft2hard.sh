#!/bin/sh
# soft2hard.sh by Ryan Helinski
# Replace a soft (symbolic) link with a hard one.
#
# $1 is name of soft link
# Returns 0 on success, 1 otherwise
#
# Example: To replace all the soft links in a particular directory:
# find ./ -type l | tr \\n \\0 | xargs -0 -n 1 soft2hard.sh
#
# finds all files under ./ of type link (l), replaces (tr) the newline
# characters with null characters and then pipes each filename one-by-one
# to soft2hard.sh

# Check that link exists
ls "$1" > /dev/null
if test $? -eq 0
then
echo -n "File found. "
else
echo "Error: File not found."
exit 1
fi

linktarget=`find "$1" -printf "%l\0"`
linktargettype=`stat --format=%F "$linktarget"`

# Check that link target exists
if test -z "$linktarget"
 then
   echo "Error: Null link target, not a soft link."
   exit 1
 else
   echo -n "Found soft link. "
fi


# Check that link target is NOT a directory
if test "$linktargettype" = "directory"
 then
   echo "Link to directory, skipping."
   exit 0
 else
   echo "Not a directory."
fi

# Remove soft link
echo -n "Unlinking $1... "
unlink "$1"
if test $? -eq 0
 then
   echo "Done."
 else
   echo "Error!"
   exit 1
fi

# Replace with hard link
echo "Creating hard link from $1"
echo -n " to $linktarget... "
ln "$linktarget" "$1"
if test $? -eq 0
 then
   echo "Done."
 else
   echo "Error creating hard link, replacing soft link"
   ln -s "$linktarget" "$1"
   exit 1
fi


exit 0

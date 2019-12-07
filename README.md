Sat 07 Dec 2019 10:02:01 AM EST


# General Information

  convert_academic is a bash script which will convert an ancient hugo academic site to a more recent version.  I am not sure when or with what version of hugo academic theme where the breaking changes were first introduced so I'm not sure how far back in time or what specific early versions of the academic theme this script may work for.  For my own uses this script works with the version of hugo academic theme I started with in early-mid 2017.

  It only converts projects and posts, but the method used in the script can be adapted to other sections if you have enough of them it may be worth using as a template.

  It took me a few days to develop this script and test it, for 30 projects and 14 posts it has saved me several days doing this sort of conversion by hand.  By no means is this guaranteed to convert everything needed for you but it may help.  ALWAYS preview your new converted site and BACKUP your original site before changing any files in case you later find out something isn't what you really wanted.

  Read through the script it is largely meant to be self evident and self documented.  The LICENSE file is provided to make sure you have the full text of that.

  Some parameters are set up for the defaults of how I use it here.  You can edit to adjust them to suit your own set up.


# To Install for a Linux/Posix Type System

  convert_academic has various linux/posix/unix type tools within it so if you are trying to use it on any other type system than those you will either have to figure out what is different and fix it or work around it.

  Some of the dependencies are: cat, cp, rm, ln, cd, echo, test, sed, gawk, tr, cut, grep/egrep and of course you will need to be up to date on the version of hugo (0.58.3-1 on the Debian Linux testing/unstable distribution) is what I have used for this version).

  To run the script it needs to be in the $PATH as an executable.  It should run from anywhere the directories this script operates on are specified using HOME it should not affect any location where you run it from.

  convert_academic will not change your original site.  The exercise of updating your hugo installation, creating the new target site, installing the academic theme and changing it to suit yourself is covered by the academic theme documentation already.

  When you have run this script once then the script will no longer update any of the converted items unless you specify the -c or --clobber option.  It will also not remove any items from the new target site if you remove them from the original site unless you specify the -c or --clobber option.

  WARNING: always make a backup copy of your original site  (just in case).  NEVER specify the original site as the target site (the source site is always first).

  If you have your tags in the project or post files set up on separate lines instead of all on one line you will need to edit those to combine them before converting otherwise some of them may not be converted.


# Bugs or Changes

  I am not supporting this for a living.  Any bugs or issues may take some time for me to get fixed.  The only way I will ever be on someone else's schedule would involve rather large sums of $.  That said you may contact me at flowerbug@anthive.com or post an issue to the tracker.  When gardening season is underway I may not check the tracker for some time.  If you think of sending a bug report please check first to be sure that you are using the most recent hugo version, the most recent academic theme version and then also be sure to include the files which are causing errors.

  In the end though, it may be something you have to figure out for yourself.  This script is only meant to be a helper and a starting point, there may be other things you need to change or convert besides what I've done (I don't use all the features of posts or projects).

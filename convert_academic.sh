#!/bin/bash

# please read through this LICENSE and the NOTES below.

# LICENSE:
#
# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2019 Flowerbug <flowerbug@anthive.com>
#
#
# Copyright 2019 Flowerbug <flowerbug@anthive.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# NOTES:

# convert an older version directory of academic projects and
# convert an older version directory of academic posts 
# into the newer version.

# i don't know as to what version of the academic theme these 
# breaking changes happened, but for me i initally set up my 
# website back in early to mid 2017.
#
# there are FURTHER NOTES below about the directories used 
# which may be of interest.
#
#
# change this if you want to use your own naming scheme
# as the default otherwise you will have to specify a base
# site or a source site and target site when you run this
# script.
# 
# one example of what you might be want to change is that 
# i use a link to the featured image instead of making a 
# copy, some people may not care and just copy it instead.


default_site_name_base="anthive"


function usage_message () {
  echo -e "\nUsage: $0\n\n\
  [-c] | [--clobber]       clear target img, project and post directories\n\n\
  [-h] | [--help]          this help\n\n\
  [-v] | [--verbose]       print out more as things happen\n\n\
  [-V] | [--Version]       give the version number\n\n\n\
  [<SITE>] |               specifies the base site name\n\n\
  [<OLDSITE> <NEWSITE>]    specifies the original site name\n\
                             and the new site name\n\n\n\
" >&2
exit
}


# check options
clobber="0"
help="0"
verbose="0"
version="0"
default="0"
while test "$1" != "" ; do
  case "$1" in
    "-c")
        clobber="1"  # clear directories in target before setting up items
        ;;
    "--clobber")
        clobber="1"  # clear directories in target before setting up items
        ;;
    "-h")
        help="1"   # print some help text
        ;;
    "--help")
        help="1"   # print some help text
        ;;
    "-v")
        verbose="1"   # print what is happening
        ;;
    "--verbose")
        verbose="1"   # print what is happening
        ;;
    "-V")
        version="1"   # give the version
        ;;
    "--Version")
        version="1"   # give the version
        ;;
    *)
      leading_char=`echo $1 | cut -c 1`
      if test "${leading_char}" == "-" ; then
        echo -e "\nUnrecognized option $1 to $0\n\n"
        usage_message $0
        exit
      elif test "${default}" == "0" || test ${default} == "1" ; then
        if test "${default}" == "0" ; then
          default="1"
          site_name_start="$1"
          default_site_name_base=""
        else
          if test "$1" == "${site_name_start}" ; then
            echo -e "\nSource Site and Target Site cannot be the same...  exiting...\n\n"
           usage_message $0
          else
            default="2"
            source_site="${site_name_start}"
            site_name_start=""
            target_site="$1"
          fi
        fi
      else
        echo -e "\nExtra input $1 to $0 discarded...\n\n"
        usage_message $0
      fi
        ;;
  esac
shift
done


# print the version if asked and then exit
if test "${version}" == "1" ; then
  echo "$0 Version 1.0.0"
  exit
fi

# print help if asked then exit
if test "${help}" == "1" ; then
  usage_message $0
fi


# set up src and tgt directories based upon options or defaults
if test ${default} == "0" ; then
  src_site_root="${HOME}/${default_site_name_base}/production"
  src_site_name="${HOME}/${default_site_name_base}"
  tgt_site_root="${HOME}/new${default_site_name_base}/production"
  tgt_site_name="${HOME}/new${default_site_name_base}"
elif test ${default} == "1" ; then
  src_site_root="${HOME}/${site_name_start}/production"
  src_site_name="${HOME}/${site_name_start}"
  tgt_site_root="${HOME}/new${site_name_start}/production"
  tgt_site_name="${HOME}/new${site_name_start}"
else
  src_site_root="${HOME}/${source_site}/production"
  src_site_name="${HOME}/${source_site}"
  tgt_site_root="${HOME}/${target_site}/production"
  tgt_site_name="${HOME}/${target_site}"
fi


date
echo -e "\n\n  Source Site: $src_site_name\n  Target Site: $tgt_site_name\n"
echo -e "  Source Site Root: $src_site_root\n  Target Site Root: $tgt_site_root\n"


# FURTHER NOTES:

# make sure these are what you want before running
# however, if by chance you just run this script it
# will not overwrite any existing files or directories
# in the source site if they already exist.  all changes
# are made to a copy of your files that you make as your
# target before running this script.
#
# as an example i use /home/me/anthive for the
# source site and /home/me/newanthive for the
# results/aka target site after running the script.
#
# the final update of your website files and folders
# is up to you how you do that after you've previewed
# the changes to make sure you are happy with them.
#
# BUT ALWAYS MAKE SURE TO HAVE A RECENT BACKUP!
# just in case you don't like what happens and you 
# somehow mess up your site/system.
#
# while the clobber option will make sure you are 
# getting the whole source site only and clean out
# the target directories, for a very large site with
# many images, projects and posts you might not want 
# to do that each time you run the script.  so the
# default behavior is to only copy new images and to
# convert only new projects or posts that have not 
# already been converted before.  this makes it go
# much quicker.  if you want to copy different images
# or update an existing project or post after you've
# already run this script you will have to delete it 
# manually from the target site.
#
# use the verbose option to see more of what is going
# on during conversions.  if something isn't working
# right this will be a help to figure it out.
#
# never specify the target site first, the first site 
# is always the source site the second site is always
# the target (where the converted items end up).  i do
# check to make sure you don't specify the source and
# target sites as the same name - this script is not
# meant to be a convert in place tool - i always aim to
# leave the original source site files alone.

src_dir="${src_site_root}/content/project"
src_img_dir="${src_site_root}/static/img"

tgt_dir="${tgt_site_root}/content/project"
tgt_img_dir="${tgt_site_root}/static/img"

echo -e "\n\nProject Convert\n\n"
echo -e "  Source Dir: $src_dir\n  Target Dir: $tgt_dir\n"
echo -e "  Source Image Dir: $src_img_dir\n  Target Image Dir: $tgt_img_dir\n\n"

if test ! -d ${src_dir} || test ! -d ${tgt_dir} ; then
  echo "  directory $src_dir or $tgt_dir does not exist"
  echo "  please specify the correct names or edit this script to provide the right locations."
  exit
fi


# save me a lot of typing
function printout ( ) {

  if test "${verbose}" == "1" ; then
    echo -e "$1"
  fi
  }


# clean up the images and projects if requested
if test "${clobber}" == "1" ; then

  # images
  echo -e "Clear out target site image directory...\n"
  rm -rf ${tgt_img_dir}/*
  echo -e "Image copy from source site to target site...\n"
  cp -a ${src_img_dir}/* ${tgt_img_dir}

  # projects
  echo -e "Clear out target site project directory...\n"
  rm -rf ${tgt_dir}/*

else
  echo -e "Copy only new images to the target site image directory...\n"
  cp -an ${src_img_dir}/* ${tgt_img_dir}
fi


# Part one convert projects
#
# get a list of projects to convert
rm -f .xyz_file_list
find ${src_dir} -maxdepth 1 -name '*.md' -exec basename {} \; >> .xyz_file_list
listing=`cat .xyz_file_list | sort`
#listing="from-the-roof.md"
rm .xyz_file_list
echo -e "List of Source projects to convert:\n$listing\n\n"

for fname in ${listing}; do

  newfname=`echo ${fname} | sed -e 's/\.md//'`

  # set up the project 
  cd ${tgt_site_root}

  # skip existing if not clobbering
  if test "${clobber}" == "0" ; then
    if test -d ${tgt_dir}/${newfname} ; then
      echo -e "Already exists, skipping ${tgt_dir}/${newfname}"
      continue
    fi
  fi

  echo -e "\nConverting ${fname}...\n"
  printout "hugo new  --kind project project/${newfname}\n"
  hugo new  --kind project project/${newfname}

  if test ! -d ${tgt_dir}/${newfname} ; then
    echo "Creation of ${tgt_dir}/${newfname} failed!?"
    exit
  fi

  cd ${tgt_dir}/${newfname}
  printout "cp -a ${src_dir}/${fname} ${tgt_dir}/${newfname}/zzzoldall\n"
  cp -a ${src_dir}/${fname} ${tgt_dir}/${newfname}/zzzoldall

  # this should give three zzzpart files
  # 1st empty, 2nd contains header from zzzoldall, 
  # with the 3rd having the rest
  gawk -v RS='+++\n' -v ORS= '{print > "zzzpart"NR}' zzzoldall

  # pull information from the old header in zzzpart2
  old_title=`cat zzzpart2 | egrep "^title = " | cut -d\" -f 2 | tr -d [\"] | tr -d [\"]`
  printout "Title -->${old_title}<--"
  old_date=`cat zzzpart2 | egrep "^date = " | cut -d\  -f 3 | tr -d [\"]`
  printout "Date -->${old_date}<--"
  old_summary=`cat zzzpart2 | egrep "^summary = " | cut -d\" -f 2 | tr -d [\"]`
  printout "Summary -->${old_summary}<--"
  old_tags=`cat zzzpart2 | egrep "^tags = " | cut -d\[ -f 2 | tr -d [\]]`
  printout "Tags -->${old_tags}<--"
  old_external_link=`cat zzzpart2 | egrep "^external_link = " | cut -d\" -f 2 | tr -d [\"] | tr -d [\"]`
  printout "External Link -->${old_external_link}<--"
  old_image=`cat zzzpart2 | egrep "^image = " | cut -d\  -f 3 | tr -d [\"]`
  printout "Image -->${old_image}<--"
  old_caption=`cat zzzpart2 | egrep "^caption = " | cut -d\" -f 2 | tr -d [\"]`
  printout "Caption -->${old_caption}<--"

  # make these changes to the index.md file
  # yes, i know i can do these all at once, i'm not worried about
  # efficiency with this code
  cat index.md | sed -e "s/^title: .*$/title: \"${old_title}\"/" > zzzi0
  cat zzzi0 | sed -e "s/^summary: .*$/summary: \"${old_summary}\"/" > zzzi1
  cat zzzi1 | sed -e "s/^tags: .*$/tags: \[${old_tags}\]/" > zzzi0
  cat zzzi0 | sed -e "s/^date: .*$/date: ${old_date}/" > zzzi1
  cat zzzi1 | sed -e "s/^external_link: .*$/external_link: \"${old_external_link}\"/" > zzzi0
  cat zzzi0 | sed -e "s/^  caption: .*$/  caption: \"${old_caption}\"/" > zzzi1

  # set up the featured image if there is one
  if test "${old_image}" != "" ; then
    if test ! -e "${tgt_dir}/${newfname}/featured.jpg" ; then
     
      printout "Link ${tgt_img_dir}/$old_image ${tgt_dir}/${newfname}/featured.jpg\n"
      ln ${tgt_img_dir}/$old_image ${tgt_dir}/${newfname}/featured.jpg
    fi
  fi

  if test "${verbose}" == "1" ; then
     cat zzzi1 | head -13
  fi

  # we can combine zzzi1 and zzzpart3 to get the new index.md
  cat zzzi1 zzzpart3 > index.md

  # clean up bits leftover
  rm -rf zzzi[01] zzzpart[123] zzzoldall

  # done with this one
  echo -e "\nDone with converting ${fname}\n\n"

done

echo -e "\n\nDone with converting Projects\n\n\n\n"

src_dir="${src_site_root}/content/post"

tgt_dir="${tgt_site_root}/content/post"

echo -e "Post Convert\n"
echo -e "  Source Dir: $src_dir\n  Target Dir: $tgt_dir\n"
echo -e "  Source Image Dir: $src_img_dir\n  Target Image Dir: $tgt_img_dir\n"

if test ! -d ${src_dir} || test ! -d ${tgt_dir} ; then
  echo "  directory $src_dir or $tgt_dir does not exist"
  echo "  please specify the correct names or edit this script to provide the right locations."
  exit
fi


# clean up posts if requested
if test "${clobber}" == "1" ; then

  # posts
  echo -e "Clear out target site post directory...\n"
  rm -rf ${tgt_dir}/*

fi


# Part two convert posts
#
# get a list of posts to convert
rm -f .xyz_file_list
find ${src_dir} -maxdepth 1 -name '*.md' -exec basename {} \; >> .xyz_file_list
listing=`cat .xyz_file_list | sort`
#listing="winter.md"
rm .xyz_file_list
echo -e "List of Source posts to convert:\n$listing\n\n"

for fname in ${listing}; do

  newfname=`echo ${fname} | sed -e 's/\.md//'`

  # set up the post 
  cd ${tgt_site_root}

  # skip existing if not clobbering
  if test "${clobber}" == "0" ; then
    if test -d ${tgt_dir}/${newfname} ; then
      echo -e "Already exists, skipping ${tgt_dir}/${newfname}"
      continue
    fi
  fi

  echo -e "\nConverting ${fname}...\n"
  printout "hugo new  --kind post post/${newfname}"
  hugo new  --kind post post/${newfname}

  if test ! -d ${tgt_dir}/${newfname} ; then
    echo "Creation of ${tgt_dir}/${newfname} failed!?"
    exit
  fi

  cd ${tgt_dir}/${newfname}
  printout "cp -a ${src_dir}/${fname} ${tgt_dir}/${newfname}/zzzoldall\n"
  cp -a ${src_dir}/${fname} ${tgt_dir}/${newfname}/zzzoldall

  # this should give three zzzpart files
  # 1st empty, 2nd contains header from zzzoldall, 
  # with the 3rd having the rest
  gawk -v RS='+++\n' -v ORS= '{print > "zzzpart"NR}' zzzoldall

  # this should give three zzzsumm files
  # 1st empty, 2nd contains summary from zzzoldall, 
  # with the 3rd having the rest
  gawk -v RS='\"\"\"\n' -v ORS= '{print > "zzzsumm"NR}' zzzoldall

  # pull information from the old header in zzzpart2
  old_title=`cat zzzpart2 | egrep "^title = " | cut -d\" -f 2 | tr -d [\"] | tr -d [\"]`
  printout "Title -->${old_title}<--"
  old_date=`cat zzzpart2 | egrep "^date = " | cut -d\  -f 3 | tr -d [\"]`
  printout "Date -->${old_date}<--"
  old_summary=`cat zzzsumm2 | sed -e 's#/#\\\/#g'`
  printout "Summary -->${old_summary}<--"
  old_tags=`cat zzzpart2 | egrep "^tags = " | cut -d\[ -f 2 | tr -d [\]]`
  printout "Tags -->${old_tags}<--"
  old_external_link=`cat zzzpart2 | egrep "^external_link = " | cut -d\" -f 2 | tr -d [\"] | tr -d [\"]`
  printout "External Link -->${old_external_link}<--"
  old_image=`cat zzzpart2 | egrep "^image = " | cut -d\  -f 3 | tr -d [\"]`
  printout "Image -->${old_image}<--"
  old_caption=`cat zzzpart2 | egrep "^caption = " | cut -d\" -f 2 | tr -d [\"]`
  printout "Caption -->${old_caption}<--"

  # make these changes to the index.md file
  # yes, i know i can do these all at once, i'm not worried about
  # efficiency with this code
  cp -a index.md zzzindex.md
  cat index.md | sed -e "s/^title: .*$/title: \"${old_title}\"/" > zzzi0
  cat zzzi0 | sed -e "s/^summary: .*$/summary: \"${old_summary}\"/" > zzzi1
  cat zzzi1 | sed -e "s/^tags: .*$/tags: \[${old_tags}\]/" > zzzi0
  cat zzzi0 | sed -e "s/^date: .*$/date: ${old_date}/" > zzzi1
  cat zzzi1 | sed -e "s/^lastmod: .*$/lastmod: ${old_date}/" > zzzi0
  cat zzzi0 | sed -e "s/^external_link: .*$/external_link: \"${old_external_link}\"/" > zzzi1
  cat zzzi1 | sed -e "s/^  caption: .*$/  caption: \"${old_caption}\"/" > zzzi0

  # set up the featured image if there is one
  if test "${old_image}" != "" ; then
    if test ! -e "${tgt_dir}/${newfname}/featured.jpg" ; then
     
      printout "Link ${tgt_img_dir}/$old_image ${tgt_dir}/${newfname}/featured.jpg\n"
      ln ${tgt_img_dir}/$old_image ${tgt_dir}/${newfname}/featured.jpg
    fi
  fi

  if test "${verbose}" == "1" ; then
    cat zzzi0 | head -13
  fi

  # we can combine zzzi1 and zzzpart3 to get the new index.md
  cat zzzi0 zzzpart3 > index.md

  # clean up bits leftover
  rm -rf zzzi[01] zzzpart[123] zzzsumm[0123] zzzindex.md zzzoldall

  # done with this one
  echo -e "\nDone with converting ${fname}\n\n"

done
echo -e "\n\nDone with converting Posts\n\n"
date

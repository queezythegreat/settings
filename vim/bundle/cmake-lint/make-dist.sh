#!/bin/sh
project=cmake-lint

die() {
  echo >&2 "$@"
  exit 1
}

upload="no"
tag="no"
TEMP=$(getopt -o uth --long upload,tag,help -- "$@")
if [ $? != 0 ] ; then
  echo "Try '$0 --help' for more information"
  exit 1
fi

eval set -- "$TEMP"
while true ; do
  case $1 in
    -u|--up|--upl|--uplo|--uploa|--upload ) upload="yes" ; shift ;;
    -t|--ta|--tag ) tag="yes" ; shift ;;
    -h|--help )
    echo "Create and optionally upload distribution files."
    echo ""
    echo "Usage: $(basename $0) [OPTION]... "
    echo "Options available are:"
    echo "-u, --upload             Upload the files too"
    echo "-t, --tag                Create a svn tag for the release"
    echo "-h, --help               This message."
    exit 0
    ;;
    --) shift ;  break ;;
    *) echo "Internal error! " >&2 ; exit 1 ;;
  esac
done

VERSION=$(./cmakelint.py --version 2>&1 | cut -d\  -f2 )
SVN="svn"
UPLOAD="googlecode_upload.py"
what=$project-$VERSION
tarball=$what.tar.gz
zipname=$what.zip
git archive --format=tar --prefix=$what/ HEAD | gzip - > $tarball
git archive --format=zip --prefix=$what/ HEAD > $zipname

repo=$(git svn info --url| sed 's,/trunk,,')
trunk=$repo/trunk
tags=$repo/tags
revision=$(git svn find-rev HEAD)
if test "$tag" = "yes" ; then
  [ x$revision = x ] && die "No SVN revision at HEAD"
  tagname=${project}_${VERSION}_r${revision}
  $SVN cp $trunk $tags/$tagname || die "Unable to make tag $tagname"
fi

if test "$upload" = "yes" ; then
  authfile=$(grep $(dirname $repo) $HOME/.subversion/auth/svn.simple/* -l)
  user=$(grep username -2 $authfile | tail -1)
  pass=$(grep password -2 $authfile | tail -1)
  for upfile in $tarball $zipname
  do
    $UPLOAD -s "$project v$VERSION" --project=$project --user=$user --password=$pass \
       -l Type-Source,Type-Archive,Featured $upfile \
      || die "Unable to upload $upfile"
  done
fi
